terraform {
  required_version = ">=0.13.5"
}

provider "azurerm" {
    version = "=2.37.0"
    features {}
}

resource "azurerm_resource_group" "OPA-ResourceGroup" {
    name = "opa-testing"
    location = "West Europe"
}

resource "azurerm_resource_group" "OPA-ResourceGroup2" {
    name = "opa-testing2"
    location = "North Europe"
}

resource "azurerm_storage_account" "example" {
  name                     = "storageaccountname"
  resource_group_name      = azurerm_resource_group.OPA-ResourceGroup.name
  location                 = azurerm_resource_group.OPA-ResourceGroup.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_account" "example2" {
  name                     = "storageaccountname"
  resource_group_name      = azurerm_resource_group.OPA-ResourceGroup2.name
  location                 = azurerm_resource_group.OPA-ResourceGroup2.location
  account_tier             = "Premium"
  account_replication_type = "GRS"
}