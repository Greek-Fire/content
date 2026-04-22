# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if ( ! ( { rpm --quiet -q kernel-core ;} && { rpm --quiet -q rpm-ostree ;} && { rpm --quiet -q bootc ;} && { ! rpm --quiet -q openshift-kubelet ;} && ([ -f /run/ostree-booted ] || [ -L /ostree ]) ) && ! ( [ -f /.dockerenv ] || [ -f /run/.containerenv ] ) ); then

MOUNT_OPTION="nodev"
# Create array of local non-root partitions
readarray -t partitions_records < <(findmnt --mtab --raw --evaluate | grep "^/\w" | grep -v "^/proc" | grep "\s/dev/\w")

# Create array of polyinstantiated directories, in case one of them is found in mtab
readarray -t polyinstantiated_dirs < \
    <(grep -oP "^\s*[^#\s]+\s+\S+" /etc/security/namespace.conf | grep -oP "(?<=\s)\S+?(?=/?\$)")

# Define excluded non-local file systems
excluded_fstypes=(
    afs
    autofs
    ceph
    cifs
    smb3
    smbfs
    sshfs
    ncpfs
    ncp
    nfs
    nfs4
    gfs
    gfs2
    glusterfs
    gpfs
    pvfs2
    ocfs2
    lustre
    davfs
    fuse.sshfs
)

for partition_record in "${partitions_records[@]}"; do
    # Get all important information for fstab
    mount_point="$(echo "${partition_record}" | cut -d " " -f1)"
    device="$(echo "${partition_record}" | cut -d " " -f2)"
    device_type="$(echo "${partition_record}" | cut -d " " -f3)"

    # Skip /boot and /efi partitions
    if [[ "$mount_point" =~ ^/(boot|efi) ]]; then
        continue
    fi

    # Skip polyinstantiated directories
    if printf '%s\0' "${polyinstantiated_dirs[@]}" | grep -qxzF "$mount_point"; then
        continue
    fi

    # Skip any non-local filesystem
    for excluded_fstype in "${excluded_fstypes[@]}"; do
        if [[ "$device_type" == "$excluded_fstype" ]]; then
            # jump out of both loops and move to next partition_record
            continue 2
        fi
    done

    # If we reach here, it's a local, non-root partition that isn't excluded.
    mount_point_match_regexp="$(printf "^[[:space:]]*[^#].*[[:space:]]%s[[:space:]]" $mount_point)"

    # If the mount point is not in /etc/fstab, get previous mount options from /etc/mtab
    if ! grep -q "$mount_point_match_regexp" /etc/fstab; then
        # runtime opts without some automatic kernel/userspace-added defaults
        previous_mount_opts=$(grep "$mount_point_match_regexp" /etc/mtab | head -1 |  awk '{print $4}' \
                    | sed -E "s/(rw|defaults|seclabel|$MOUNT_OPTION)(,|$)//g;s/,$//")
        [ "$previous_mount_opts" ] && previous_mount_opts+=","
        # In iso9660 filesystems mtab could describe a "blocksize" value, this should be reflected in
        # fstab as "block".  The next variable is to satisfy shellcheck SC2050.
        fs_type="$device_type"
        if [  "$fs_type" == "iso9660" ] ; then
            previous_mount_opts=$(sed 's/blocksize=/block=/' <<< "$previous_mount_opts")
        fi
        echo "$device $mount_point $device_type defaults,${previous_mount_opts}$MOUNT_OPTION 0 0" >> /etc/fstab
    # If the mount_opt option is not already in the mount point's /etc/fstab entry, add it
    elif ! grep "$mount_point_match_regexp" /etc/fstab | grep -q "$MOUNT_OPTION"; then
        previous_mount_opts=$(grep "$mount_point_match_regexp" /etc/fstab | awk '{print $4}')
        sed -i "s|\(${mount_point_match_regexp}.*${previous_mount_opts}\)|\1,$MOUNT_OPTION|" /etc/fstab
    fi
    if mkdir -p "$mount_point"; then
        if mountpoint -q "$mount_point"; then
            mount -o remount --target "$mount_point"
        fi
    fi
done

# Remediate unmounted /etc/fstab entries, excluding /boot and /efi partitions
sed -i -E '/nodev/! { /^\s*(\/dev\/\S+|UUID=\S+)\s+\/(boot|efi)/! s;^\s*(/dev/\S+|UUID=\S+)\s+(/\w\S*)\s+(\S+)\s+(\S+)(.*)$;\1 \2 \3 \4,nodev \5; }' /etc/fstab

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi