resource "kubernetes_ingress_v1" "nexus_ingress" {
  metadata {
    name      = "nexus"
    namespace = kubernetes_namespace.tools.metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      host = "nexus.local.com"
      http {
        path {
          path = "/"
          backend {
            service {
              name = kubernetes_service.nexus_svc.metadata.0.name
              port {
                number = 8081
              }
            }
          }
        }
      }

      # rule {
      #   host = "docker.nexus.local.com"
      #   http {
      #     path {
      #       path = "/"
      #       backend {
      #         service_name = kubernetes_service.nexus_svc.metadata[0].name
      #         service_port = 5000
      #       }
      #     }
      #   }
    }

  }
}
