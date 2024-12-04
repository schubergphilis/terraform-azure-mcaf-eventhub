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

variable "managed_identities" {
  type = object({
    system_assigned            = optional(bool, false)
    user_assigned_resource_ids = optional(set(string), [])
  })
  default     = {}
  description = <<DESCRIPTION
  Controls the Managed Identity configuration on this resource. The following properties can be specified:

  - `system_assigned` - (Optional) Specifies if the System Assigned Managed Identity should be enabled.
  - `user_assigned_resource_ids` - (Optional) Specifies a list of User Assigned Managed Identity resource IDs to be assigned to this resource.
  DESCRIPTION
  nullable    = false
}