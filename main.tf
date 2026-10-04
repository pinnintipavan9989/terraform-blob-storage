# main.tf

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "example" {
  name     = "rg-terraform-example"
  location = "Central India"
}

# Storage Account (Blob Storage)
resource "azurerm_storage_account" "example" {
  name                     = "blobstoragepavstack1"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version = "TLS1_2"

  tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}

# Blob Container
resource "azurerm_storage_container" "example" {
  name                  = "example-container"
  storage_account_id    = azurerm_storage_account.example.id
  container_access_type = "private"
}