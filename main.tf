##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

resource "mysql_database" "this" {
  for_each              = var.databases
  name                  = each.value.name
  default_character_set = try(each.value.default_character_set, "utf8mb4")
  default_collation     = try(each.value.default_collation, "utf8mb4_unicode_ci")
}

resource "random_password" "owner" {
  for_each         = { for k, db in var.databases : k => db if try(db.create_owner, false) }
  length           = 20
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  min_lower        = 2
  min_upper        = 2
  min_numeric      = 2
  min_special      = 2
}

resource "mysql_user" "owner" {
  for_each           = { for k, db in var.databases : k => db if try(db.create_owner, false) }
  user               = try(each.value.owner, "${each.value.name}_owner")
  host               = try(each.value.host, "%")
  plaintext_password = random_password.owner[each.key].result
  tls_option         = try(each.value.tls_option, "NONE")
}

resource "mysql_grant" "owner" {
  for_each   = { for k, db in var.databases : k => db if try(db.create_owner, false) }
  user       = mysql_user.owner[each.key].user
  host       = mysql_user.owner[each.key].host
  database   = mysql_database.this[each.key].name
  table      = "*"
  privileges = ["ALL PRIVILEGES"]
  grant      = true
}
