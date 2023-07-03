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
            secret_ref {
              name = kubernetes_secret_v1.mysql_secret.metadata[0].name
            }
          }


        }

      }
    }
  }
}

