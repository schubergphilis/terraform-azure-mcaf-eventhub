resource "azurerm_resource_group" "this" {
  name     = var.resource_group.name
  location = var.resource_group.location
  tags = merge(
    var.tags,
    {
      "Resource Type" = "Resource Group"
    }
  )
}

resource "azurerm_eventhub_namespace" "this" {
  name                = var.event_hub_namespace.name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = var.event_hub_namespace.config.sku
  capacity            = var.event_hub_namespace.config.capacity
  tags = merge(
    var.tags,
    {
      "Resource Type" = "Event Hub"
    }
  )
  minimum_tls_version           = var.event_hub_namespace.config.minimum_tls_version
  maximum_throughput_units      = var.event_hub_namespace.config.maximum_throughput_units
  auto_inflate_enabled          = var.event_hub_namespace.config.auto_inflate_enabled
  public_network_access_enabled = false

  identity {
    type         = "UserAssigned"
    identity_ids = [var.user_assigned_identity_id]
  }
}
