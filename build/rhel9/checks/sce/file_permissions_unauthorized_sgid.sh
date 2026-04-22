#!/bin/bash




# Get filesystems mounted with 'nodev' option
filter_nodev=$(awk '/nodev/ { print $2 }' /proc/filesystems | paste -sd,)

# Find all mounted partitions, excluding those with 'nodev'
readarray -t partitions < <(findmnt -n -l -k -it "${filter_nodev}" | awk '{ print $1 }')

# Ensure /tmp is also checked when tmpfs is used.
if grep -Pq "^tmpfs\\h+/tmp" /proc/mounts; then
    partitions+=("/tmp")
fi

unauthorized_files=()

# Loop through each partition and find files based on provided type and permissions
for partition in "${partitions[@]}"; do
  while IFS= read -r file; do
    # Skip files that belong to an RPM package
    if ! rpm -qf --quiet "$file"; then
        unauthorized_files+=("$file")
    fi
  done < <(find "${partition}" -xdev -type f -perm -2000 )
done

if (( ${#unauthorized_files[@]} > 0 )); then
  echo "Found SGID executables that are unauthorized:"
  printf '%s\n' "${unauthorized_files[@]}"
  exit "${XCCDF_RESULT_FAIL}"
fi

exit "${XCCDF_RESULT_PASS}"


