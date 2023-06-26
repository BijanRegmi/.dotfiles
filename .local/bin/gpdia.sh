set -e

HYBRID_UDEV_PATH="/lib/udev/rules.d/80-nvidia-pm.rules"
HYBRID_UDEV_CONTENT='
# Remove NVIDIA USB xHCI Host Controller devices, if present
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{remove}="1"

# Remove NVIDIA USB Type-C UCSI devices, if present
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{remove}="1"

# Remove NVIDIA Audio devices, if present
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{remove}="1"

# Enable runtime PM for NVIDIA VGA/3D controller devices on driver bind
ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="auto"
ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="auto"

# Disable runtime PM for NVIDIA VGA/3D controller devices on driver unbind
ACTION=="unbind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="on"
ACTION=="unbind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="on"
'

INTEGRATED_UDEV_PATH='/lib/udev/rules.d/50-remove-nvidia.rules'
INTEGRATED_UDEV_CONTENT='
# Remove NVIDIA USB xHCI Host Controller devices, if present
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"

# Remove NVIDIA USB Type-C UCSI devices, if present
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"

# Remove NVIDIA Audio devices, if present
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"

# Remove NVIDIA VGA/3D controller devices
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
'

INTEGRATED_MODPROBE_PATH='/etc/modprobe.d/blacklist-nvidia.conf'
INTEGRATED_MODPROBE_CONTENT='
blacklist nouveau
blacklist nvidia
blacklist nvidia_drm
blacklist nvidia_uvm
blacklist nvidia_modeset
alias nouveau off
alias nvidia off
alias nvidia_drm off
alias nvidia_uvm off
alias nvidia_modeset off
'

HYBRID_MODPROBE_PATH='/etc/modprobe.d/nvidia.conf'
HYBRID_MODPROBE_CONTENT='
options nvidia-drm modeset=1
options nvidia NVreg_DynamicPowerManagement=0x03
options nvidia NVreg_PreserveVideoMemoryAllocations=1
'

# set -xe

cleanup() {
    echo "Info: Cleaning up existing files"
    rm -f "$HYBRID_UDEV_PATH" "$HYBRID_MODPROBE_PATH" "$INTEGRATED_UDEV_PATH" "$INTEGRATED_MODPROBE_PATH"
}

hybrid(){
    require_root
    cleanup

    echo "Info: Copying hybrid contents"
    echo "$HYBRID_UDEV_CONTENT" > "$HYBRID_UDEV_PATH"
    echo "$HYBRID_MODPROBE_CONTENT" > "$HYBRID_MODPROBE_PATH"

    reload

    modprobe nvidia NVreg_DynamicPowerManagement=0x03 NVreg_PreserveVideoMemoryAllocations=1
    modprobe nvidia-drm modeset=1
    modprobe nvidia-uvm nvidia-modeset

}

integrated(){
    require_root
    cleanup

    echo "Info: Disabling loaded nvidia modules"
    modprobe -r nvidia-drm nvidia-uvm nvidia-modeset nvidia

    echo "Info: Copying integrated contents"
    echo "$INTEGRATED_UDEV_CONTENT" > "$INTEGRATED_UDEV_PATH"
    echo "$INTEGRATED_MODPROBE_CONTENT" > "$INTEGRATED_MODPROBE_PATH"

    reload
}

query(){
    if [ -f $INTEGRATED_MODPROBE_PATH ]; then
        echo "Integrated"
    else
        echo "Hybrid"
    fi

}

reload(){
    echo "Info: Reloading modules"
    systemctl restart systemd-modules-load.service

    echo "Info: Rescanning pci devices"
    echo 1 > /sys/bus/pci/rescan
}

usage(){
    echo -e "USAGE: $0 [options]
OPTIONS:
-h\tEnable Hybrid Mode
-i\tEnable Integrated Mode
-q\tQuery Mode
"
}

require_root(){
    if [ "$(id -u)" -ne 0 ]; then
        echo 'Error: This script must be run by root' >&2
        exit 1
    fi
}


if [ "$1" = "-h" ]; then
    echo "Info: Switching to hybrid"
    hybrid
elif [ "$1" = "-i" ]; then
    echo "Info: Switching to integrated"
    integrated
elif [ "$1" = "-q" ]; then
    query
else
    usage
fi

