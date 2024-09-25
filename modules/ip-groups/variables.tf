variable "ip_groups" {
  description = "describes all ip groups"
  type        = map(any)
  default     = {}
}

variable "location" {
  description = "contains the region"
  type        = string
  default     = null
}

variable "resource_group" {
  description = "contains the resource group name"
  type        = string
  default     = null
}

variable "naming" {
  description = "contains naming convention"
  type        = map(string)
  default     = null
}
