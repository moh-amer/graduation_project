resource "kubernetes_config_map_v1" "mysql_config_map" {
  metadata {
    name      = "mysql-config"
    namespace = kubernetes_namespace.dev.metadata[0].name
  }

  data = {
    MYSQL_ROOT_PASSWORD = "moh123"
    MYSQL_DATABASE      = "mydb"
  }

}

resource "kubernetes_config_map_v1" "app_config_map" {
  metadata {
    name      = "app-config"
    namespace = kubernetes_namespace.dev.metadata[0].name

  }

  data = {
    HOST     = "mysql-svc"
    USERNAME = "root"
    PASSWORD = "moh123"
    DATABASE = "mydb"
  }

}
