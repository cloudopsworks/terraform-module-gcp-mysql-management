##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

resource "random_password" "user" {
  for_each         = var.users
  length           = 20
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  min_lower        = 2
  min_upper        = 2
  min_numeric      = 2
  min_special      = 2
}

resource "mysql_user" "user" {
  for_each           = var.users
  user               = each.value.name
  host               = try(each.value.host, "%")
  plaintext_password = random_password.user[each.key].result
  tls_option         = try(each.value.tls_option, "NONE")
}

resource "mysql_grant" "user" {
  for_each   = var.users
  user       = mysql_user.user[each.key].user
  host       = mysql_user.user[each.key].host
  database   = try(each.value.db_ref, "") != "" ? mysql_database.this[each.value.db_ref].name : each.value.database_name
  table      = "*"
  privileges = each.value.grant == "owner" || each.value.grant == "readwrite" ? ["ALL PRIVILEGES"] : ["SELECT"]
  grant      = each.value.grant == "owner"
}
