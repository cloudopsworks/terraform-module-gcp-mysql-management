##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

resource "mysql_grant" "role" {
  for_each   = var.roles
  user       = try(each.value.name, each.key)
  host       = "%"
  database   = try(each.value.db_ref, "") != "" ? mysql_database.this[each.value.db_ref].name : each.value.database_name
  table      = try(each.value.table_name, "*")
  privileges = try(each.value.grants, ["ALL PRIVILEGES"])
  grant      = try(each.value.grant_option, false)
}
