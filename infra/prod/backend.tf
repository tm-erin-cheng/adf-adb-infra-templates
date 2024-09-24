terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.111.0"
    }

    azapi = {
      source  = "azure/azapi"
      version = "~>1.15.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-biudw-devopsir-prod-001"
    storage_account_name = "stbiudwdevopsprod001"
    container_name       = "tf-state"
    key                  = "prod.terraform.tfstate"
    access_key           = ""
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = "true"
}

provider "azapi" {
  skip_provider_registration = "true"
}

data "azurerm_client_config" "current" {}
