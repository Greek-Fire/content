# platform = multi_platform_rhel

# Correct BLS option using grubby, which is a thin wrapper around BLS operations
grubby --update-kernel=ALL --args="init_on_alloc=1"

# Ensure new kernels and boot entries retain the boot option
if [ ! -f /etc/kernel/cmdline ]; then
    echo "init_on_alloc=1" > /etc/kernel/cmdline
elif ! grep -q '^(.*\s)?init_on_alloc=1(\s.*)?$' /etc/kernel/cmdline; then
    
    sed -Ei 's/^(.*)$/\1 init_on_alloc=1/' /etc/kernel/cmdline
fi