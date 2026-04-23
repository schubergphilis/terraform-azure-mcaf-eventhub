output "eventhub_namespace_id" {
  description = "The ID of the EventHub Namespace."
  value       = azurerm_eventhub_namespace.this.id
}

output "eventhub_namespace_name" {
  description = "The name of the EventHub Namespace."
  value       = azurerm_eventhub_namespace.this.name
}

output "event_hubs" {
  description = "A map of deployed EventHubs, keyed by name, each containing the resource id and name."
  value = {
    for name, hub in azurerm_eventhub.this : name => {
      id   = hub.id
      name = hub.name
    }
  }
}
