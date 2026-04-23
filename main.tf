locals {
  # Azure requires default_action = "Allow" when public_network_access_enabled = false.
  # When public access is enabled, default to "Deny" for maximum security.
  network_ruleset_default_action = coalesce(
    var.eventhub_namespace_network_ruleset.default_action,
    var.eventhub_namespace_network_ruleset.public_network_access_enabled ? "Deny" : "Allow"
  )
}

resource "azurerm_eventhub_namespace" "this" {
  name                          = var.eventhub_namespace_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.eventhub_namespace_sku
  capacity                      = var.eventhub_namespace_capacity
  minimum_tls_version           = var.eventhub_namespace_minimum_tls_version
  maximum_throughput_units      = var.eventhub_namespace_maximum_throughput_units
  auto_inflate_enabled          = var.eventhub_namespace_auto_inflate_enabled
  public_network_access_enabled = var.eventhub_namespace_network_ruleset.public_network_access_enabled
  tags                          = var.tags

  network_rulesets {
    public_network_access_enabled  = var.eventhub_namespace_network_ruleset.public_network_access_enabled
    default_action                 = local.network_ruleset_default_action
    trusted_service_access_enabled = var.eventhub_namespace_network_ruleset.trusted_service_access_enabled

    ip_rule              = var.eventhub_namespace_network_ruleset.ip_rules
    virtual_network_rule = var.eventhub_namespace_network_ruleset.virtual_network_rules
  }

  identity {
    type         = length(var.eventhub_namespace_user_assigned_identity_ids) > 0 ? "SystemAssigned, UserAssigned" : "SystemAssigned"
    identity_ids = length(var.eventhub_namespace_user_assigned_identity_ids) > 0 ? var.eventhub_namespace_user_assigned_identity_ids : null
  }
}

data "azurerm_key_vault_key" "eventhub_namespace_cmk_key" {
  count        = var.eventhub_namespace_customer_managed_key != null ? 1 : 0
  key_vault_id = var.eventhub_namespace_customer_managed_key.key_vault_id
  name         = var.eventhub_namespace_customer_managed_key.key_name
}

resource "azurerm_eventhub_namespace_customer_managed_key" "this" {
  count                             = var.eventhub_namespace_customer_managed_key != null ? 1 : 0
  eventhub_namespace_id             = azurerm_eventhub_namespace.this.id
  key_vault_key_ids                 = [data.azurerm_key_vault_key.eventhub_namespace_cmk_key[0].versionless_id]
  user_assigned_identity_id         = var.eventhub_namespace_customer_managed_key.user_assigned_identity_id
  infrastructure_encryption_enabled = var.eventhub_namespace_customer_managed_key.infrastructure_encryption_enabled
}

resource "azurerm_eventhub_namespace_authorization_rule" "this" {
  for_each            = var.eventhub_namespace_authorization_rules
  name                = each.key
  namespace_name      = azurerm_eventhub_namespace.this.id
  resource_group_name = azurerm_eventhub_namespace.this.resource_group_name

  listen = each.value.listen
  send   = each.value.send
  manage = each.value.manage
}

resource "azurerm_eventhub" "this" {
  for_each          = var.event_hubs != null ? var.event_hubs : {}
  name              = each.key
  namespace_id      = azurerm_eventhub_namespace.this.id
  partition_count   = each.value.partition_count
  message_retention = each.value.message_retention

  depends_on = [azurerm_eventhub_namespace_customer_managed_key.this]
}

resource "azurerm_eventhub_authorization_rule" "this" {
  for_each = var.event_hubs != null ? merge([
    for hub_name, hub in var.event_hubs : {
      for rule_name, rule in hub.authorization_rules :
      "${hub_name}/${rule_name}" => merge(rule, { hub_name = hub_name, rule_name = rule_name })
    }
  ]...) : {}
  name                = each.value.rule_name
  namespace_name      = azurerm_eventhub_namespace.this.name
  eventhub_name       = azurerm_eventhub.this[each.value.hub_name].name
  resource_group_name = azurerm_eventhub.this[each.value.hub_name].resource_group_name

  listen = each.value.listen
  send   = each.value.send
  manage = each.value.manage
}

resource "azurerm_eventhub_consumer_group" "this" {
  for_each = var.event_hubs != null ? merge([
    for hub_name, hub in var.event_hubs : {
      for group_name in hub.consumer_groups :
      "${hub_name}/${group_name}" => { hub_name = hub_name, group_name = group_name }
    }
  ]...) : {}
  name                = each.value.group_name
  namespace_name      = azurerm_eventhub_namespace.this.name
  eventhub_name       = azurerm_eventhub.this[each.value.hub_name].name
  resource_group_name = azurerm_eventhub.this[each.value.hub_name].resource_group_name
}
