# Snap Default Config Testing

Supporting material for bug report: https://bugs.launchpad.net/snapd/+bug/2047949

## App

Build:
```
cd app
snapcraft -v --destructive
```

Install from scratch:
```
sudo snap remove --purge default-config-test-farshidtz && \
    sudo snap install --dangerous ./default-config-test-farshidtz_0.1_amd64.snap
```

Check the logs:
```
sudo journalctl -f --no-hostname -o short-iso -n 100 | grep default-config-test
```

Upload (needed for gadget testing):
```
snapcraft upload --release=edge ./default-config-test-farshidtz_0.1_amd64.snap
```

## Gadget
Build:
```
cd gadget
snapcraft -v --destructive
```

## Ubuntu Core
Sign the model:
```
yq eval model.yaml -o=json | snap sign -k otbr-testing > model.signed.yaml
```

Build the image:
```
ubuntu-image snap model.signed.yaml -v --validation=enforce     --snap gadget/my-gadget_0.1_amd64.snap
```

Run with QEMU:
```
sudo qemu-system-x86_64 \
 -enable-kvm \
 -smp 1 \
 -m 2048 \
 -machine q35 \
 -cpu host \
 -global ICH9-LPC.disable_s3=1 \
 -net nic,model=virtio \
 -net user,hostfwd=tcp::8022-:22,hostfwd=tcp::8090-:80  \
 -drive file=/usr/share/OVMF/OVMF_CODE.secboot.fd,if=pflash,format=raw,unit=0,readonly=on \
 -drive file=/usr/share/OVMF/OVMF_VARS.ms.fd,if=pflash,format=raw,unit=1 \
 -drive "file=pc.img",if=none,format=raw,id=disk1 \
 -device virtio-blk-pci,drive=disk1,bootindex=1 \
 -serial mon:stdio
```

## Logs
```
sudo journalctl -f --no-hostname -o short-iso -n 100 | grep default-config-test
```
