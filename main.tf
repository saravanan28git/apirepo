terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
    backend "azurerm" {
        resource_group_name  = "together-money-saravanan"
        storage_account_name = "tfstorageapi"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

provider "azurerm" {
  features {}
}

variable "imagebuild" {
  type        = string
  description = "Latest Image Build"
}


resource "azurerm_resource_group" "tf_test" {
  name = "tfmainrg"
  location = "Australia East"
}

resource "azurerm_container_group" "tfcg_test" {
  name                      = "weatherapi"
  location                  = azurerm_resource_group.tf_test.location
  resource_group_name       = azurerm_resource_group.tf_test.name

  ip_address_type     = "Public"
  dns_name_label      = "weatherapinewß"
  os_type             = "Linux"

  container {
      name            = "weatherapi"
      image           = "sa28docker/weatherapi:${var.imagebuild}"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
}