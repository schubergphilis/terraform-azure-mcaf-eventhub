## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_eventhub_namespace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_event_hub_namespace"></a> [event\_hub\_namespace](#input\_event\_hub\_namespace) | Configuration for the EventHub Namespace. | <pre>object({<br/>    name = string,<br/>    config = object({<br/>      sku                      = string,<br/>      capacity                 = number,<br/>      auto_inflate_enabled     = bool,<br/>      maximum_throughput_units = number<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_managed_identities"></a> [managed\_identities](#input\_managed\_identities) | Controls the Managed Identity configuration on this resource. The following properties can be specified:<br/><br/>  - `system_assigned` - (Optional) Specifies if the System Assigned Managed Identity should be enabled.<br/>  - `user_assigned_resource_ids` - (Optional) Specifies a list of User Assigned Managed Identity resource IDs to be assigned to this resource. | <pre>object({<br/>    system_assigned            = optional(bool, false)<br/>    user_assigned_resource_ids = optional(set(string), [])<br/>  })</pre> | `{}` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | The name and location of the resource group in which to create the resources. | <pre>object({<br/>    name     = string,<br/>    location = string<br/>  })</pre> | <pre>{<br/>  "location": null,<br/>  "name": null<br/>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eventhub_namespace_id"></a> [eventhub\_namespace\_id](#output\_eventhub\_namespace\_id) | The ID of the EventHub Namespace |
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | The ID of the Resource Group |

**Copyright:** Schuberg Philis

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_eventhub.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub) | resource |
| [azurerm_eventhub_authorization_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_authorization_rule) | resource |
| [azurerm_eventhub_consumer_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_consumer_group) | resource |
| [azurerm_eventhub_namespace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) | resource |
| [azurerm_eventhub_namespace_authorization_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace_authorization_rule) | resource |
| [azurerm_eventhub_namespace_customer_managed_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace_customer_managed_key) | resource |
| [azurerm_key_vault_key.eventhub_namespace_cmk_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eventhub_namespace_capacity"></a> [eventhub\_namespace\_capacity](#input\_eventhub\_namespace\_capacity) | The capacity (throughput) units for the EventHub Namespace. | `number` | n/a | yes |
| <a name="input_eventhub_namespace_name"></a> [eventhub\_namespace\_name](#input\_eventhub\_namespace\_name) | The name of the EventHub Namespace. | `string` | n/a | yes |
| <a name="input_eventhub_namespace_sku"></a> [eventhub\_namespace\_sku](#input\_eventhub\_namespace\_sku) | The SKU of the EventHub Namespace. Valid values are Basic, Standard, and Premium. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location in which to deploy the resources. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to deploy the resources. | `string` | n/a | yes |
| <a name="input_event_hubs"></a> [event\_hubs](#input\_event\_hubs) | A map of event hubs and their associated configuration to deploy within the namespace.<br/>The map key is used as the EventHub name.<br/>  - partition\_count:     The number of partitions. Must be between 1 and 32 for Standard/Basic, or up to 2048 for Premium.<br/>  - message\_retention:   The number of days to retain messages. Must be between 1 and 7 for Standard/Basic, or up to 90 for Premium.<br/>  - authorization\_rules: A map of authorization rules to create on the EventHub. The map key is used as the rule name. Each rule specifies listen, send, and manage permissions.<br/>  - consumer\_groups:     A set of consumer group names to create on the EventHub. | <pre>map(object({<br/>    partition_count   = number<br/>    message_retention = number<br/>    authorization_rules = optional(map(object({<br/>      listen = bool<br/>      send   = bool<br/>      manage = bool<br/>    })), {})<br/>    consumer_groups = optional(set(string), [])<br/>  }))</pre> | `null` | no |
| <a name="input_eventhub_namespace_authorization_rules"></a> [eventhub\_namespace\_authorization\_rules](#input\_eventhub\_namespace\_authorization\_rules) | A map of namespace-level authorization rules to create on the EventHub Namespace. The map key is used as the rule name.<br/>  - listen: Whether this rule grants listen access.<br/>  - send:   Whether this rule grants send access.<br/>  - manage: Whether this rule grants manage access. Granting manage also requires listen and send to be true. | <pre>map(object({<br/>    listen = bool<br/>    send   = bool<br/>    manage = bool<br/>  }))</pre> | `{}` | no |
| <a name="input_eventhub_namespace_auto_inflate_enabled"></a> [eventhub\_namespace\_auto\_inflate\_enabled](#input\_eventhub\_namespace\_auto\_inflate\_enabled) | Whether auto-inflate is enabled for the EventHub Namespace. | `bool` | `false` | no |
| <a name="input_eventhub_namespace_customer_managed_key"></a> [eventhub\_namespace\_customer\_managed\_key](#input\_eventhub\_namespace\_customer\_managed\_key) | Customer managed key configuration for the EventHub Namespace. Requires a user-assigned identity with access to the key vault key.<br/>  - key\_vault\_id:                      The id of the Key Vault in which the CMK key is stored.<br/>  - key\_name:                          The name of the CMK key in the Key Vault. This name will be used to query the versionless id of the key for use as the cmk key of this EventHub namespace.<br/>  - user\_assigned\_identity\_id:         The ID of the user-assigned managed identity used to access the key vault key, this identity also needs to be assigned to the EventHub namespace.<br/>  - infrastructure\_encryption\_enabled: Whether infrastructure-level encryption is enabled in addition to the CMK. Defaults to true. | <pre>object({<br/>    key_vault_id = string<br/>    key_name      = string<br/>    user_assigned_identity_id         = string<br/>    infrastructure_encryption_enabled = optional(bool, true)<br/>  })</pre> | `null` | no |
| <a name="input_eventhub_namespace_maximum_throughput_units"></a> [eventhub\_namespace\_maximum\_throughput\_units](#input\_eventhub\_namespace\_maximum\_throughput\_units) | The maximum throughput units for auto-inflate. Must be greater than capacity when auto-inflate is enabled. | `number` | `0` | no |
| <a name="input_eventhub_namespace_minimum_tls_version"></a> [eventhub\_namespace\_minimum\_tls\_version](#input\_eventhub\_namespace\_minimum\_tls\_version) | The minimum TLS version for the EventHub Namespace. Valid values are 1.0, 1.1, and 1.2. | `string` | `"1.2"` | no |
| <a name="input_eventhub_namespace_network_ruleset"></a> [eventhub\_namespace\_network\_ruleset](#input\_eventhub\_namespace\_network\_ruleset) | Network ruleset configuration for the EventHub Namespace. Defaults to the most restrictive configuration.<br/>  - public\_network\_access\_enabled:  Whether public network access is enabled. Defaults to false.<br/>  - default\_action:                 The default action when no rules match. When null (default), resolves to "Deny"<br/>                                    if public\_network\_access\_enabled is true, or "Allow" if false (required by Azure).<br/>                                    Valid values are "Allow" and "Deny".<br/>  - trusted\_service\_access\_enabled: Whether trusted Microsoft services are allowed to bypass network rules. Defaults to false.<br/>  - ip\_rules:                       A list of IP rules. Each entry requires an ip\_mask and an optional action (default "Allow").<br/>  - virtual\_network\_rules:          A list of virtual network rules. Each entry requires a subnet\_id and an optional<br/>                                    ignore\_missing\_virtual\_network\_service\_endpoint flag (default false). | <pre>object({<br/>    public_network_access_enabled  = optional(bool, false)<br/>    default_action                 = optional(string, null)<br/>    trusted_service_access_enabled = optional(bool, false)<br/>    ip_rules = optional(list(object({<br/>      ip_mask = string<br/>      action  = optional(string, "Allow")<br/>    })), [])<br/>    virtual_network_rules = optional(list(object({<br/>      subnet_id                                       = string<br/>      ignore_missing_virtual_network_service_endpoint = optional(bool, false)<br/>    })), [])<br/>  })</pre> | `{}` | no |
| <a name="input_eventhub_namespace_user_assigned_identity_ids"></a> [eventhub\_namespace\_user\_assigned\_identity\_ids](#input\_eventhub\_namespace\_user\_assigned\_identity\_ids) | A set of user-assigned managed identity IDs to assign to the EventHub Namespace. A SystemAssigned identity is always created. | `set(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_event_hubs"></a> [event\_hubs](#output\_event\_hubs) | A map of deployed EventHubs, keyed by name, each containing the resource id and name. |
| <a name="output_eventhub_namespace_id"></a> [eventhub\_namespace\_id](#output\_eventhub\_namespace\_id) | The ID of the EventHub Namespace. |
| <a name="output_eventhub_namespace_name"></a> [eventhub\_namespace\_name](#output\_eventhub\_namespace\_name) | The name of the EventHub Namespace. |
<!-- END_TF_DOCS -->