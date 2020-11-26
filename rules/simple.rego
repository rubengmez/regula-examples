package rules.simple

__rego__metadoc__ := {
  "id": "FG_R00192",
  "title": "Esto es una prueba de una regla simple",
  "description": "Todos los grupos de recursos tienen que pertenecer a la misma localización, en este caso WEST EUROPE",
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

resource_type = "azurerm_resource_group" # Se revisará la regla únicamente en este tipo de recurso

default allow = false 

allow {
    input.location == "westeurope" # Únicamente se aceptarán los grupos de recursos que tengan esta localización
}