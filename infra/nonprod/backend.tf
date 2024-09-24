terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.111.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-biudw-devopsir-nonprod-001"
    storage_account_name = "stbiudwdevopsnonprod001"
    container_name       = "tf-state"
    key                  = "nonprod.terraform.tfstate"
    access_key           = ""
    subscription_id      = "f15443ef-35ac-4259-9d63-6f7a63404171"
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = "true"
  subscription_id            = "1bc64a42-dfb8-475c-9876-e8c00ed473e8"
}

data "azurerm_client_config" "current" {}
