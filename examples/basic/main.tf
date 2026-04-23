terraform {
  required_version = ">= 1.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "xxxx-xxxxx"
}

module "event_hub" {
  source = "../.."

  resource_group_name = "example-rg"
  location            = "West Europe"

  eventhub_namespace_name     = "test-eventhub-namespace"
  eventhub_namespace_sku      = "Premium"
  eventhub_namespace_capacity = 2

  eventhub_namespace_user_assigned_identity_ids = ["xxxxx-xxxxx"]

  eventhub_namespace_customer_managed_key = {
    key_vault_key_id          = "https://example-vault.vault.azure.net/keys/cmkrsa"
    user_assigned_identity_id = "xxxxx-xxxxx"
  }

  eventhub_namespace_network_ruleset = {
    trusted_service_access_enabled = true
  }

  event_hubs = {
    "test-eventhub" = {
      partition_count   = 4
      message_retention = 7
      consumer_groups   = ["consumer-a", "consumer-b"]
      authorization_rules = {
        sender = {
          listen = false
          send   = true
          manage = false
        }
      }
    }
  }

  tags = {
    Environment = "Production"
  }
}