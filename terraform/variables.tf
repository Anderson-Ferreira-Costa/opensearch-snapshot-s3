variable "region" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "route_table_id" {
  type = string
}
variable "subnet_ids" {
  type = list(any)
}
variable "schedule_expression" {
  type = string
}


