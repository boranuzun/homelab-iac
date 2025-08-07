resource "proxmox_vm_qemu" "nixos" {
  agent                       = 1
  args                        = ""
  bios                        = "seabios"
  boot                        = "order=scsi0;ide2;net0"
  bootdisk                    = ""
  define_connection_info      = false
  description                 = ""
  force_create                = false
  full_clone                  = false
  hagroup                     = ""
  hastate                     = ""
  hotplug                     = "network,disk,usb"
  kvm                         = true
  machine                     = "q35"
  memory                      = 6144
  name                        = "nixos"
  onboot                      = true
  pool                        = ""
  protection                  = false
  qemu_os                     = "l26"
  scsihw                      = "virtio-scsi-single"
  startup                     = ""
  tablet                      = true
  tags                        = ""
  target_nodes                = ["pve1"]
  vm_state                    = "running"
  vmid                        = 105

  cpu {
    affinity = ""
    cores    = 4
    limit    = 0
    numa     = false
    sockets  = 1
    type     = "x86-64-v2-AES"
    units    = 0
    vcores   = 0
  }

  disks {
    ide {
      ide2 {
        cdrom {
          iso         = "local:iso/latest-nixos-minimal-x86_64-linux.iso"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          asyncio              = ""
          backup               = true
          cache                = ""
          discard              = false
          emulatessd           = false
          format               = "raw"
          iops_r_burst         = 0
          iops_r_burst_length  = 0
          iops_r_concurrent    = 0
          iops_wr_burst        = 0
          iops_wr_burst_length = 0
          iops_wr_concurrent   = 0
          iothread             = true
          mbps_r_burst         = 0
          mbps_r_concurrent    = 0
          mbps_wr_burst        = 0
          mbps_wr_concurrent   = 0
          readonly             = false
          replicate            = true
          serial               = ""
          size                 = "128G"
          storage              = "local-lvm"
          wwn                  = ""
        }
      }
    }
  }

  network {
    bridge    = "vmbr0"
    firewall  = true
    id        = 0
    link_down = false
    macaddr   = "bc:24:11:fe:1a:b4"
    model     = "virtio"
    mtu       = 0
    queues    = 0
    rate      = 0
    tag       = 0
  }

  smbios {
    family       = ""
    manufacturer = ""
    product      = ""
    serial       = ""
    sku          = ""
    uuid         = "3ae926c3-1c06-4c11-b5b1-e1b9998209a8"
    version      = ""
  }
}