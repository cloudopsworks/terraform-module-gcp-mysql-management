##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

locals {
  cloudsql_enabled    = try(var.cloudsql.enabled, false)
  from_secret_enabled = local.cloudsql_enabled && try(var.cloudsql.from_secret, false)
  mysql_conn = local.cloudsql_enabled && local.from_secret_enabled ? {
    host        = jsondecode(data.google_secret_manager_secret_version.cloudsql_creds[0].secret_data)["host"]
    port        = jsondecode(data.google_secret_manager_secret_version.cloudsql_creds[0].secret_data)["port"]
    username    = jsondecode(data.google_secret_manager_secret_version.cloudsql_creds[0].secret_data)["username"]
    password    = jsondecode(data.google_secret_manager_secret_version.cloudsql_creds[0].secret_data)["password"]
    server_name = try(var.cloudsql.server_name, var.cloudsql.instance_name)
    } : local.cloudsql_enabled ? {
    host        = data.google_sql_database_instance.this[0].ip_address[0].ip_address
    port        = 3306
    username    = try(var.cloudsql.admin_username, "root")
    password    = try(var.cloudsql.admin_password, "")
    server_name = try(var.cloudsql.server_name, var.cloudsql.instance_name)
    } : try(var.hoop.enabled, false) ? {
    host        = "127.0.0.1"
    port        = try(var.hoop.port, 3306)
    username    = try(var.hoop.username, "noop")
    password    = try(var.hoop.password, "noop")
    server_name = try(var.hoop.server_name, "")
    } : {
    host        = try(var.direct.host, "")
    port        = try(var.direct.port, 3306)
    username    = try(var.direct.username, "")
    password    = try(var.direct.password, "")
    server_name = try(var.direct.server_name, "")
  }
}

data "google_sql_database_instance" "this" {
  count   = local.cloudsql_enabled && !local.from_secret_enabled ? 1 : 0
  name    = var.cloudsql.instance_name
  project = try(var.cloudsql.project_id, data.google_project.current.project_id)
}

data "google_secret_manager_secret_version" "cloudsql_creds" {
  count   = local.from_secret_enabled ? 1 : 0
  secret  = var.cloudsql.secret_id
  project = try(var.cloudsql.project_id, data.google_project.current.project_id)
}
