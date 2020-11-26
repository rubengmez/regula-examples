package rules.advanced
import data.fugue # Se hará una llamada a la librería de fugue para poder usar las funciones

__rego__metadoc__ := {
  "id": "FG_R00192",
  "title": "Esto es una prueba de una regla avanzada",
  "description": "Se tiene que cumplir que los grupos de recursos tengan como localización WEST EUROPE y además que todas las cuentas de almacenamiento del grupo de recursos con nombre opa-testing sean de Tier Standard ",
  "custom": {
    "controls": {
      "CISAZURE": [
        "CISAZURE_6.3"
      ],
      "NIST": [
        "NIST-800-53_SC-7 (5)"
      ]
    },
    "severity": "High"
  }
}

resource_type = "MULTIPLE" # Indica que hay más de un recurso

# Recopila los grupos de recursos
resource_groups = fugue.resources("azurerm_resource_group")

# Los grupos de recursos con localización West Europe serán válidos
groupvalid(group) {
  group.location == "westeurope"
}

policy[r] {
   resource_group = resource_groups[_]
   groupvalid(resource_group) # Si la loc está dentro de las permitidas, se permitirá
   r = fugue.allow_resource(resource_group)
} {
   resource_group = resource_groups[_]
   not groupvalid(resource_group) # Si la loc está dentro de las permitidas, se denegará
   r = fugue.deny_resource(resource_group)
}

# Recopila las cuentas de almacenamiento
storage_accounts = fugue.resources("azurerm_storage_account")

# Las cuentas con Tier Standard serán las permitidas
storagevalid(acc) {
  acc.account_tier == "Standard"
}

policy[r] {
   storage_account = storage_accounts[_]
   storage_account.resource_group_name == "opa-testing" # Filtra por nombre de grupo de recursos (se centrará en los que pertenezcan a ese grupo de recursos)
   storagevalid(storage_account) # Si el Tier de la cuenta está dentro de los permitidos, se aceptará
   r = fugue.allow_resource(storage_account)
} {
   storage_account = storage_accounts[_]
   storage_account.resource_group_name == "opa-testing" # Filtra por nombre de grupo de recursos (se centrará en los que pertenezcan a ese grupo de recursos)
   not storagevalid(storage_account) # Si el Tier de la cuenta no está dentro de los permitidos, se denegará
   r = fugue.deny_resource(storage_account)
}