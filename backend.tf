terraform {
  backend "pg" {
    conn_str = var.pg_backend
  }
}