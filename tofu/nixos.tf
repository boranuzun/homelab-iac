# __generated__ by OpenTofu
# Please review these resources and move them into your main configuration files.

# __generated__ by OpenTofu
resource "proxmox_vm_qemu" "nixos" {
  additional_wait             = null
  agent                       = 1
  agent_timeout               = null
  args                        = ""
  automatic_reboot            = null
  balloon                     = null
  bios                        = "seabios"
  boot                        = "order=scsi0;ide2;net0"
  bootdisk                    = ""
  ci_wait                     = null
  cicustom                    = null
  cipassword                  = null # sensitive
  ciupgrade                   = null
  ciuser                      = null
  clone                       = null
  clone_id                    = null
  clone_wait                  = null
  cores                       = 4
  cpu_type                    = "x86-64-v2-AES"
  define_connection_info      = false
  desc                        = ""
  force_create                = false
  force_recreate_on_change_of = null
  full_clone                  = false
  hagroup                     = ""
  hastate                     = ""
  hotplug                     = "network,disk,usb"
  ipconfig0                   = null
  ipconfig1                   = null
  ipconfig10                  = null
  ipconfig11                  = null
  ipconfig12                  = null
  ipconfig13                  = null
  ipconfig14                  = null
  ipconfig15                  = null
  ipconfig2                   = null
  ipconfig3                   = null
  ipconfig4                   = null
  ipconfig5                   = null
  ipconfig6                   = null
  ipconfig7                   = null
  ipconfig8                   = null
  ipconfig9                   = null
  kvm                         = true
  machine                     = "q35"
  memory                      = 6144
  name                        = "nixos"
  nameserver                  = null
  numa                        = false
  onboot                      = true
  os_network_config           = null
  os_type                     = null
  pool                        = ""
  protection                  = false
  pxe                         = null
  qemu_os                     = "l26"
  scsihw                      = "virtio-scsi-single"
  searchdomain                = null
  skip_ipv4                   = null
  skip_ipv6                   = null
  sockets                     = 1
  ssh_forward_ip              = null
  ssh_private_key             = null # sensitive
  ssh_user                    = null
  sshkeys                     = null
  startup                     = ""
  tablet                      = true
  tags                        = ""
  target_node                 = null
  target_nodes                = ["pve1"]
  vcpus                       = null
  vm_state                    = "running"
  vmid                        = 105
  disks {
    ide {
      ide2 {
        cdrom {
          iso = "local:iso/nixos-minimal-24.11.717586.3e362ce63e16-x86_64-linux.iso"
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
    macaddr   = "bc:24:11:2a:19:35"
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
    uuid         = "4f1fbc8e-2077-4fbf-9689-3c5f20e09ffc"
    version      = ""
  }
}
