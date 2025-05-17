variable "pm_api_url" {
  type        = string
  description = "The Proxmox server URL (https://ip:port/api2/json)"
}

variable "pm_api_token_id" {
  type        = string
  description = "The Proxmox API Token ID (user@realm!tokenid)"
}

variable "pm_api_token_secret" {
  type        = string
  sensitive   = true
  description = "The Proxmox API Token secret (UUID)"
}
