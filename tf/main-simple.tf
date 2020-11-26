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