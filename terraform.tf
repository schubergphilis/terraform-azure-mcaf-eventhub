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
  subscription_id = "b5f5e722-d325-4261-98e1-81d2d707bd86"
  features {}
}
