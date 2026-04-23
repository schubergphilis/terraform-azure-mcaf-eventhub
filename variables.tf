variable "resource_group_name" {
  description = "The name of the resource group in which to deploy the resources."
  type        = string
}

variable "location" {
  description = "The location in which to deploy the resources."
  type        = string
}

variable "eventhub_namespace_name" {
  description = "The name of the EventHub Namespace."
  type        = string
}

variable "eventhub_namespace_sku" {
  description = "The SKU of the EventHub Namespace. Valid values are Basic, Standard, and Premium."
  type        = string
}

variable "eventhub_namespace_capacity" {
  description = "The capacity (throughput) units for the EventHub Namespace."
  type        = number
}

variable "eventhub_namespace_minimum_tls_version" {
  description = "The minimum TLS version for the EventHub Namespace. Valid values are 1.0, 1.1, and 1.2."
  type        = string
  default     = "1.2"
}

variable "eventhub_namespace_auto_inflate_enabled" {
  description = "Whether auto-inflate is enabled for the EventHub Namespace."
  type        = bool
  default     = false
}

variable "eventhub_namespace_maximum_throughput_units" {
  description = "The maximum throughput units for auto-inflate. Must be greater than capacity when auto-inflate is enabled."
  type        = number
  default     = 0
}

variable "eventhub_namespace_user_assigned_identity_ids" {
  description = "A set of user-assigned managed identity IDs to assign to the EventHub Namespace. A SystemAssigned identity is always created."
  type        = set(string)
  default     = []
}

variable "eventhub_namespace_customer_managed_key" {
  description = <<-EOT
    Customer managed key configuration for the EventHub Namespace. Requires a user-assigned identity with access to the key vault key.
      - key_vault_id:                      The id of the Key Vault in which the CMK key is stored.
      - key_name:                          The name of the CMK key in the Key Vault. This name will be used to query the versionless id of the key for use as the cmk key of this EventHub namespace.
      - user_assigned_identity_id:         The ID of the user-assigned managed identity used to access the key vault key, this identity also needs to be assigned to the EventHub namespace.
      - infrastructure_encryption_enabled: Whether infrastructure-level encryption is enabled in addition to the CMK. Defaults to true.
  EOT
  type = object({
    key_vault_id = string
    key_name      = string
    user_assigned_identity_id         = string
    infrastructure_encryption_enabled = optional(bool, true)
  })
  default = null
}

variable "eventhub_namespace_network_ruleset" {
  description = <<-EOT
    Network ruleset configuration for the EventHub Namespace. Defaults to the most restrictive configuration.
      - public_network_access_enabled:  Whether public network access is enabled. Defaults to false.
      - default_action:                 The default action when no rules match. When null (default), resolves to "Deny"
                                        if public_network_access_enabled is true, or "Allow" if false (required by Azure).
                                        Valid values are "Allow" and "Deny".
      - trusted_service_access_enabled: Whether trusted Microsoft services are allowed to bypass network rules. Defaults to false.
      - ip_rules:                       A list of IP rules. Each entry requires an ip_mask and an optional action (default "Allow").
      - virtual_network_rules:          A list of virtual network rules. Each entry requires a subnet_id and an optional
                                        ignore_missing_virtual_network_service_endpoint flag (default false).
  EOT
  type = object({
    public_network_access_enabled  = optional(bool, false)
    default_action                 = optional(string, null)
    trusted_service_access_enabled = optional(bool, false)
    ip_rules = optional(list(object({
      ip_mask = string
      action  = optional(string, "Allow")
    })), [])
    virtual_network_rules = optional(list(object({
      subnet_id                                       = string
      ignore_missing_virtual_network_service_endpoint = optional(bool, false)
    })), [])
  })
  default = {}
}

variable "eventhub_namespace_authorization_rules" {
  description = <<-EOT
    A map of namespace-level authorization rules to create on the EventHub Namespace. The map key is used as the rule name.
      - listen: Whether this rule grants listen access.
      - send:   Whether this rule grants send access.
      - manage: Whether this rule grants manage access. Granting manage also requires listen and send to be true.
  EOT
  type = map(object({
    listen = bool
    send   = bool
    manage = bool
  }))
  default = {}
}

variable "event_hubs" {
  description = <<-EOT
    A map of event hubs and their associated configuration to deploy within the namespace.
    The map key is used as the EventHub name.
      - partition_count:     The number of partitions. Must be between 1 and 32 for Standard/Basic, or up to 2048 for Premium.
      - message_retention:   The number of days to retain messages. Must be between 1 and 7 for Standard/Basic, or up to 90 for Premium.
      - authorization_rules: A map of authorization rules to create on the EventHub. The map key is used as the rule name. Each rule specifies listen, send, and manage permissions.
      - consumer_groups:     A set of consumer group names to create on the EventHub.
  EOT
  type = map(object({
    partition_count   = number
    message_retention = number
    authorization_rules = optional(map(object({
      listen = bool
      send   = bool
      manage = bool
    })), {})
    consumer_groups = optional(set(string), [])
  }))
  default = null
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
