resource "azurerm_eventhub_namespace" "this" {
  name                = var.event_hub_namespace.name
  location            = azurerm_resource_group.this.location
  resource_group_name = var.resource_group.name
  sku                 = var.event_hub_namespace.config.sku
  capacity            = var.event_hub_namespace.config.capacity
  tags = merge(
    var.tags,
    {
      "Resource Type" = "Event Hub"
    }
  )
  minimum_tls_version           = "1.2"
  maximum_throughput_units      = var.event_hub_namespace.config.maximum_throughput_units
  auto_inflate_enabled          = var.event_hub_namespace.config.auto_inflate_enabled
  public_network_access_enabled = false

  ## Resources supporting both SystemAssigned and UserAssigned
  dynamic "identity" {
    for_each = local.managed_identities.system_assigned_user_assigned == null ? {} : local.managed_identities.system_assigned_user_assigned

    content {
      type         = identity.value.type
      identity_ids = identity.value.user_assigned_resource_ids
    }
  }
}
