variable "location" { type = string, default = "uksouth" }
variable "rg_name" { type = string }
variable "name" { type = string, default = "self-hosted-ai" }
variable "vm_size" { type = string, default = "Standard_D4s_v5" }

variable "admin_user" { type = string, default = "mahbub" }
variable "ssh_public_key_path" { type = string }
variable "admin_ip_cidr" { type = string } # e.g. "1.2.3.4/32"

variable "repo_url" { type = string }       # e.g. "https://github.com/<you>/ai-platform.git"
variable "repo_branch" { type = string, default = "main" }
