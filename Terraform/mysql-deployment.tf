resource "kubernetes_deployment" "mysql_deployment" {
  metadata {
    name      = "mysql"
    namespace = kubernetes_namespace.dev.metadata[0].name

    labels = {
      app = "mysql"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "mysql"
      }
    }

    template {
      metadata {
        labels = {
          app = "mysql"
        }
      }

      spec {
        container {
          name  = "mysql"
          image = "mysql:5.7"

          port {
            container_port = 3306
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map_v1.mysql_config_map.metadata[0].name
            }
          }

        }

      }
    }
  }
}

