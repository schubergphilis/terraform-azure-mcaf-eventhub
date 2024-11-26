variable "resource_group" {
  description = <<-DESCRIPTION
    The configuration for the resource group in which to create the resources.

    - `name`     = (Required) The name of the resource group.
    - `location` = (Required) The location/region of the resource group.

    Example Input:
    ```hcl
    resource_group = {
      name     = "my-resource-group"
      location = "eastus"
    }
    ```
  DESCRIPTION
  type = object({
    name     = string
    location = string
  })
  default = {
    name     = null
    location = null
  }
  nullable = false
}

variable "event_hub_namespace" {
  description = <<-DESCRIPTION
    This object describes the configuration for the EventHub Namespace.

    - `name`   = (Required) The name of the Event Hub namespace.
    - `config` = (Required) A configuration block for the Event Hub namespace:
      - `sku`                      = (Required) The SKU for the Event Hub namespace (e.g., Basic, Standard).
      - `capacity`                 = (Required) The capacity for the Event Hub namespace.
      - `minimum_tls_version`      = (Required) The minimum TLS version for the Event Hub namespace.
      - `auto_inflate_enabled`     = (Required) Indicates if Auto Inflate is enabled for the Event Hub namespace.
      - `maximum_throughput_units` = (Required) Maximum throughput units for Auto Inflate.

    Example Input:
    ```hcl
    event_hub_namespace = {
      name   = "example-namespace"
      config = {
        sku                      = "Standard"
        capacity                 = 1
        minimum_tls_version      = "1.2"
        auto_inflate_enabled     = true
        maximum_throughput_units = 2
      }
    }
    ```
  DESCRIPTION
  type = object({
    name   = string
    config = object({
      sku                      = string
      capacity                 = number
      minimum_tls_version      = string
      auto_inflate_enabled     = bool
      maximum_throughput_units = number
    })
  })
  nullable = false
}

variable "tags" {
  description = <<-DESCRIPTION
    A map of tags to assign to the resource.

    Example Input:
    ```hcl
    tags = {
      Environment = "Production"
      Project     = "MyProject"
    }
    ```
  DESCRIPTION
  type    = map(string)
  default = {}
}

variable "user_assigned_identity_id" {
  description = <<-DESCRIPTION
    The ID of the user-assigned identity for the EventHub Namespace.

    Example Input:
    ```hcl
    user_assigned_identity_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourcegroups/my-resource-group/providers/Microsoft.ManagedIdentity/userAssignedIdentities/my-identity"
    ```
  DESCRIPTION
  type     = string
  nullable = false
}
