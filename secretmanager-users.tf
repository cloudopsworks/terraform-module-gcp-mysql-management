##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

locals {
  user_secret_ids = {
    for k, user in var.users : k => lower(replace(
      format("%s/mysql/%s/%s/%s-credentials", local.secret_store_path, local.mysql_conn.server_name,
        try(user.db_ref, "") != "" ? var.databases[user.db_ref].name : user.database_name,
        replace(user.name, "_", "-")
      ),
      "/[^a-zA-Z0-9_-]/", "-"
    ))
  }
  user_credentials = {
    for k, user in var.users : k => {
      username    = user.name
      password    = random_password.user[k].result
      host        = local.mysql_conn.host
      port        = local.mysql_conn.port
      dbname      = try(user.db_ref, "") != "" ? var.databases[user.db_ref].name : user.database_name
      engine      = "mysql"
      server_name = local.mysql_conn.server_name
    }
  }
}

resource "google_secret_manager_secret" "user" {
  for_each  = var.users
  secret_id = local.user_secret_ids[each.key]
  project   = data.google_project.current.project_id
  labels = merge(local.all_tags, {
    "mysql-username" = each.value.name
    "mysql-database" = try(each.value.db_ref, "") != "" ? var.databases[each.value.db_ref].name : try(each.value.database_name, "")
    "mysql-server"   = local.mysql_conn.server_name
  })
  replication {
    auto {
      dynamic "customer_managed_encryption" {
        for_each = var.secrets_kms_key_name != null ? [1] : []
        content { kms_key_name = var.secrets_kms_key_name }
      }
    }
  }
}

resource "google_secret_manager_secret_version" "user" {
  for_each    = var.users
  secret      = google_secret_manager_secret.user[each.key].id
  secret_data = jsonencode(local.user_credentials[each.key])
  lifecycle { create_before_destroy = true }
}
