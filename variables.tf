variable "resource_group" {
  description = "The name and location of the resource group in which to create the resources."
  type = object({
    name     = string,
    location = string
  })
  default = {
    name     = null,
    location = null
  }
  nullable = false
}

variable "event_hub_namespace" {
  description = "Configuration for the EventHub Namespace."
  type = object({
    name = string,
    config = object({
      sku                      = string,
      capacity                 = number,
      minimum_tls_version      = string,
      auto_inflate_enabled     = bool,
      maximum_throughput_units = number
    })
  })
  nullable = false
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "user_assigned_identity_id" {
  description = "The ID of the user-assigned identity for the EventHub Namespace."
  type        = string
  nullable    = false
} 