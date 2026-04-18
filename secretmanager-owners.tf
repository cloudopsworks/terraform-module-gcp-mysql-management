##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

locals {
  owner_secret_ids = {
    for k, db in var.databases : k => lower(replace(
      format("%s/mysql/%s/%s/%s-credentials", local.secret_store_path, local.mysql_conn.server_name, db.name, replace(try(db.owner, "${db.name}-owner"), "_", "-")),
      "/[^a-zA-Z0-9_-]/", "-"
    )) if try(db.create_owner, false)
  }
  owner_credentials = {
    for k, db in var.databases : k => {
      username    = mysql_user.owner[k].user
      password    = random_password.owner[k].result
      host        = local.mysql_conn.host
      port        = local.mysql_conn.port
      dbname      = db.name
      engine      = "mysql"
      server_name = local.mysql_conn.server_name
    } if try(db.create_owner, false)
  }
}

resource "google_secret_manager_secret" "owner" {
  for_each  = { for k, db in var.databases : k => db if try(db.create_owner, false) }
  secret_id = local.owner_secret_ids[each.key]
  project   = data.google_project.current.project_id
  labels = merge(local.all_tags, {
    "mysql-username" = mysql_user.owner[each.key].user
    "mysql-database" = each.value.name
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

resource "google_secret_manager_secret_version" "owner" {
  for_each    = { for k, db in var.databases : k => db if try(db.create_owner, false) }
  secret      = google_secret_manager_secret.owner[each.key].id
  secret_data = jsonencode(local.owner_credentials[each.key])
  lifecycle { create_before_destroy = true }
}
