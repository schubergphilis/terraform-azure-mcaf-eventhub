output "resource_group_id" {
  description = "The ID of the Resource Group"
  value       = azurerm_resource_group.this.id
}

output "eventhub_namespace_id" {
  description = "The ID of the EventHub Namespace"
  value       = azurerm_eventhub_namespace.this.id
}