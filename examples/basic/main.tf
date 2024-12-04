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

  
resource_group = {
  name     = "example-rg"
  location = "West Europe"
}

event_hub_namespace = {
  name = "test-eventhub-namespace"
  config = {
    sku                      = "Standard"
    capacity                 = 1
    auto_inflate_enabled     = true
    maximum_throughput_units = 2 # This value must be greater than `capacity`

  }
}

tags = {
  Environment = "Production"
}

managed_identities = {
  "user_assigned_resource_ids" = ["xxxxx-xxxxx"]
}

}