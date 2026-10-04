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

# Existing Storage Account
resource "azurerm_storage_account" "example" {
  name                     = "stterraformexample123"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version = "TLS1_2"

  tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}

# Existing Blob Container
resource "azurerm_storage_container" "example" {
  name                  = "example-container"
  storage_account_id    = azurerm_storage_account.example.id
  container_access_type = "private"
}

# New Blob Storage Account (BlobStorage kind) in East US
resource "azurerm_storage_account" "blob_storage" {
  name                     = "blobstoragepavstack1"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "BlobStorage"

  min_tls_version = "TLS1_2"

  tags = {
    environment = "blob-storage-pavstack-1"
    managed_by  = "terraform"
  }
}

# New Blob Container within the new storage account
resource "azurerm_storage_container" "blob_storage_container" {
  name                  = "blob-storage-pavstack-1"
  storage_account_id    = azurerm_storage_account.blob_storage.id
  container_access_type = "private"
}