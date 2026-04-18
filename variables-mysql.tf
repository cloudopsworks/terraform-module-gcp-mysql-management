##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

## users:
#   <user_ref>:
#     name: "username"               # (Required) MySQL username.
#     grant: "owner"                 # (Required) Grant type: owner, readwrite, readonly.
#     db_ref: "db_ref"               # (Optional) Reference to databases key.
#     database_name: "dbname"        # (Optional) Database name when db_ref not set.
#     host: "%"                      # (Optional) MySQL host for user. Default: %.
#     tls_option: "NONE"             # (Optional) NONE, SSL, X509. Default: NONE.
#     import: false                  # (Optional) Import existing user. Default: false.
#     hoop:
#       access_control: []
variable "users" {
  description = "Map of MySQL users — see inline docs."
  type        = any
  default     = {}
}

## roles (privilege sets):
#   <role_ref>:
#     name: "rolename"
#     db_ref: "db_ref"
#     database_name: "dbname"
#     table_name: "*"                # (Optional) Default: *.
#     grant_option: false            # (Optional) Default: false.
#     grants: ["ALL PRIVILEGES"]     # (Optional) Default: ALL PRIVILEGES.
variable "roles" {
  description = "Map of MySQL roles/privilege sets — see inline docs."
  type        = any
  default     = {}
}

## databases:
#   <db_ref>:
#     name: "dbname"                 # (Required) Database name.
#     create_owner: false            # (Optional) Create owner user. Default: false.
#     owner: "ownername"             # (Optional) Owner username when create_owner=false.
#     default_character_set: "utf8mb4" # (Optional) Default: utf8mb4.
#     default_collation: "utf8mb4_unicode_ci" # (Optional) Default: utf8mb4_unicode_ci.
#     host: "%"                      # (Optional) Host for owner user. Default: %.
#     tls_option: "NONE"             # (Optional) Default: NONE.
variable "databases" {
  description = "Map of MySQL databases — see inline docs."
  type        = any
  default     = {}
}

## hoop:
#   enabled: false
#   agent_id: ""
#   community: true                  # true=null (no GCP sub-key); false=enterprise
#   import: false
#   tags: {}
#   access_control: []
variable "hoop" {
  description = "Hoop connection settings — see inline docs."
  type        = any
  default     = {}
}

## cloudsql:
#   enabled: false
#   instance_name: ""
#   project_id: ""
#   from_secret: false
#   secret_id: ""
#   server_name: ""
#   admin_username: "root"
#   admin_password: ""
#   db_name: "mysql"
variable "cloudsql" {
  description = "Cloud SQL MySQL instance connection — see inline docs."
  type        = any
  default     = {}
}

## direct:
#   server_name: ""
#   host: ""
#   port: 3306
#   username: ""
#   password: ""
#   db_name: "mysql"
variable "direct" {
  description = "Direct MySQL connection — see inline docs."
  type        = any
  default     = {}
}

variable "password_rotation_period" {
  description = "(Optional) Password rotation period in days. Default: 90."
  type        = number
  default     = 90
}

variable "force_reset" {
  description = "(Optional) Force reset all passwords. Default: false."
  type        = bool
  default     = false
}

variable "secrets_kms_key_name" {
  description = "(Optional) GCP KMS key name for encrypting secrets."
  type        = string
  default     = null
}
