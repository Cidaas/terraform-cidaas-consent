# Terraform Cidaas Consent Module

This Terraform module manages Cidaas consent groups, consents and consent versions.

## Features

- Creates a Cidaas consent group
- Creates multiple Cidaas consents within the group
- Creates multiple versions for each consent with localized content

## Requirements

- Terraform >= 1.1.0
- Cidaas Provider >= 3.2.0

## Usage

```hcl
provider "cidaas" {
  base_url = "https://cidaas.dev.de"
}

module "cidaas_consent_module" {
  source = "git@github.com:Cidaas/terraform-cidaas-consent.git"

  providers = {
    cidaas = cidaas
  }

  group_name  = "sample_consent_group"
  description = "creating sample consent group with terraform-cidaas-consent module" # optional
  enabled = false # optional, if not configured default value is set to true

  consents = [
    {
      name            = "consent1"
      consent_type    = "SCOPES"
      scopes          = ["developer"] # required when consent_type is SCOPES
      required_fields = ["name"] # required when consent_type is SCOPES
      consent_versions = [
        {
          version = 1
          consent_locales = [
            {
              content = "consent version in German"
              locale  = "de"
            },
            {
              content = "consent version in English"
              locale  = "en"
            }
          ]
        },
        {
          version = 2
          consent_locales = [
            {
              content = "consent version in French"
              locale  = "fr"
            }
          ]
        }
      ]
    },
    {
      name            = "consent2"
      consent_type    = "URL"
      consent_versions = [
        {
          version = 1
          consent_locales = [
            {
              content = "consent version in German"
              locale  = "de"
              url     = "https://cidaas.de/de" # required when consent_type is URL
            }
          ]
        }
      ]
    }
  ]
}
```

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| group_name | Name of the consent group | `string` | yes |
| description | Description for the consent group | `string` | No |
| consents | List of consents each containing multiple consent versions and locales | `list(object)` | yes |
| enabled | Flag to enable or disable a consent. Defualt value is `true`. | `bool` | No |

For detailed information about the `consents` variable structure, please refer to the `variables.tf` file.

## Outputs

| Name | Description |
|------|-------------|
| consent_group_id | ID of the created consent group |
| consents | Map of created consents |
| consent_versions | Map of created consent versions |
