variable "ip_groups" {
  description = "Contains all ip groups configuration"
  type = map(object({
    name                = optional(string, null)
    resource_group_name = optional(string, null)
    location            = optional(string, null)
    cidr                = any
    tags                = optional(map(string))
  }))
}

variable "tags" {
  description = "tags to be added to the resources"
  type        = map(string)
  default     = {}
}

variable "location" {
  description = "contains the region"
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "contains the resource group name"
  type        = string
  default     = null
}

variable "naming" {
  description = "contains naming convention"
  type        = map(string)
  default     = null
}
