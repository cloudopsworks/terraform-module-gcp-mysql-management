## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 7.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 7.0 |
| <a name="requirement_mysql"></a> [mysql](#requirement\_mysql) | ~> 1.10 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 7.0 |
| <a name="provider_mysql"></a> [mysql](#provider\_mysql) | ~> 1.10 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.4 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tags"></a> [tags](#module\_tags) | cloudopsworks/tags/local | 1.0.9 |

## Resources

| Name | Type |
|------|------|
| [google_secret_manager_secret.hoop_user_db](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.hoop_user_host](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.hoop_user_pass](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.hoop_user_port](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.hoop_user_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.owner](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_version.hoop_user_db](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_secret_manager_secret_version.hoop_user_host](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_secret_manager_secret_version.hoop_user_pass](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_secret_manager_secret_version.hoop_user_port](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_secret_manager_secret_version.hoop_user_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_secret_manager_secret_version.owner](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_secret_manager_secret_version.user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [mysql_database.this](https://registry.terraform.io/providers/winebarrel/mysql/latest/docs/resources/database) | resource |
| [mysql_grant.owner](https://registry.terraform.io/providers/winebarrel/mysql/latest/docs/resources/grant) | resource |
| [mysql_grant.role](https://registry.terraform.io/providers/winebarrel/mysql/latest/docs/resources/grant) | resource |
| [mysql_grant.user](https://registry.terraform.io/providers/winebarrel/mysql/latest/docs/resources/grant) | resource |
| [mysql_user.owner](https://registry.terraform.io/providers/winebarrel/mysql/latest/docs/resources/user) | resource |
| [mysql_user.user](https://registry.terraform.io/providers/winebarrel/mysql/latest/docs/resources/user) | resource |
| [random_password.owner](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.user](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [google_client_config.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_project.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |
| [google_secret_manager_secret_version.cloudsql_creds](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/secret_manager_secret_version) | data source |
| [google_sql_database_instance.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/sql_database_instance) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudsql"></a> [cloudsql](#input\_cloudsql) | Cloud SQL MySQL instance connection — see inline docs. | `any` | `{}` | no |
| <a name="input_databases"></a> [databases](#input\_databases) | Map of MySQL databases — see inline docs. | `any` | `{}` | no |
| <a name="input_direct"></a> [direct](#input\_direct) | Direct MySQL connection — see inline docs. | `any` | `{}` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add to the resources | `map(string)` | `{}` | no |
| <a name="input_force_reset"></a> [force\_reset](#input\_force\_reset) | (Optional) Force reset all passwords. Default: false. | `bool` | `false` | no |
| <a name="input_hoop"></a> [hoop](#input\_hoop) | Hoop connection settings — see inline docs. | `any` | `{}` | no |
| <a name="input_is_hub"></a> [is\_hub](#input\_is\_hub) | Is this a hub or spoke configuration? | `bool` | `false` | no |
| <a name="input_org"></a> [org](#input\_org) | Organization details | <pre>object({<br/>    organization_name = string<br/>    organization_unit = string<br/>    environment_type  = string<br/>    environment_name  = string<br/>  })</pre> | n/a | yes |
| <a name="input_password_rotation_period"></a> [password\_rotation\_period](#input\_password\_rotation\_period) | (Optional) Password rotation period in days. Default: 90. | `number` | `90` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | Map of MySQL roles/privilege sets — see inline docs. | `any` | `{}` | no |
| <a name="input_secrets_kms_key_name"></a> [secrets\_kms\_key\_name](#input\_secrets\_kms\_key\_name) | (Optional) GCP KMS key name for encrypting secrets. | `string` | `null` | no |
| <a name="input_spoke_def"></a> [spoke\_def](#input\_spoke\_def) | Spoke ID Number, must be a 3 digit number | `string` | `"001"` | no |
| <a name="input_users"></a> [users](#input\_users) | Map of MySQL users — see inline docs. | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_databases"></a> [databases](#output\_databases) | Map of created MySQL databases. |
| <a name="output_hoop_connections"></a> [hoop\_connections](#output\_hoop\_connections) | Hoop connection definitions (enterprise only; community returns null). |
| <a name="output_users"></a> [users](#output\_users) | Map of created MySQL users with their GCP Secret Manager secret IDs. |
