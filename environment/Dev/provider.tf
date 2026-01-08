terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.57.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "4bd63c00-983e-45d2-ab5b-452b7cd8779d"
  # Configuration options
}
