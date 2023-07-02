resource "kubernetes_deployment" "app_deployment" {
  metadata {
    name      = "nodejs"
    namespace = kubernetes_namespace.dev.metadata[0].name

    labels = {
      app = "nodejs"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nodejs"
      }
    }

    template {
      metadata {
        labels = {
          app = "nodejs"
        }
      }

      spec {
        image_pull_secrets {
          name = "regcred"
        }
        container {
          name  = "nodejs"
          image = "docker.nexus.local.com/nodejs-app:12"

          port {
            container_port = 3000
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map_v1.app_config_map.metadata[0].name
            }
          }

        }

      }
    }
  }
}

