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
| [azurerm_eventhub_namespace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_event_hub_namespace"></a> [event\_hub\_namespace](#input\_event\_hub\_namespace) | This object describes the configuration for the EventHub Namespace.<br/><br/>- `name`   = (Required) The name of the Event Hub namespace.<br/>- `config` = (Required) A configuration block for the Event Hub namespace:<br/>  - `sku`                      = (Required) The SKU for the Event Hub namespace (e.g., Basic, Standard).<br/>  - `capacity`                 = (Required) The capacity for the Event Hub namespace.<br/>  - `minimum_tls_version`      = (Required) The minimum TLS version for the Event Hub namespace.<br/>  - `auto_inflate_enabled`     = (Required) Indicates if Auto Inflate is enabled for the Event Hub namespace.<br/>  - `maximum_throughput_units` = (Required) Maximum throughput units for Auto Inflate.<br/><br/>Example Input:<pre>hcl<br/>event_hub_namespace = {<br/>  name   = "example-namespace"<br/>  config = {<br/>    sku                      = "Standard"<br/>    capacity                 = 1<br/>    minimum_tls_version      = "1.2"<br/>    auto_inflate_enabled     = true<br/>    maximum_throughput_units = 2<br/>  }<br/>}</pre> | <pre>object({<br/>    name   = string<br/>    config = object({<br/>      sku                      = string<br/>      capacity                 = number<br/>      minimum_tls_version      = string<br/>      auto_inflate_enabled     = bool<br/>      maximum_throughput_units = number<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | The configuration for the resource group in which to create the resources.<br/><br/>- `name`     = (Required) The name of the resource group.<br/>- `location` = (Required) The location/region of the resource group.<br/><br/>Example Input:<pre>hcl<br/>resource_group = {<br/>  name     = "my-resource-group"<br/>  location = "eastus"<br/>}</pre> | <pre>object({<br/>    name     = string<br/>    location = string<br/>  })</pre> | <pre>{<br/>  "location": null,<br/>  "name": null<br/>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource.<br/><br/>Example Input:<pre>hcl<br/>tags = {<br/>  Environment = "Production"<br/>  Project     = "MyProject"<br/>}</pre> | `map(string)` | `{}` | no |
| <a name="input_user_assigned_identity_id"></a> [user\_assigned\_identity\_id](#input\_user\_assigned\_identity\_id) | The ID of the user-assigned identity for the EventHub Namespace.<br/><br/>Example Input:<pre>hcl<br/>user_assigned_identity_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourcegroups/my-resource-group/providers/Microsoft.ManagedIdentity/userAssignedIdentities/my-identity"</pre> | `string` | n/a | yes |

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

<!-- END_TF_DOCS -->