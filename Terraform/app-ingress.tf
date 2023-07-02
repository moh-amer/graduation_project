resource "kubernetes_ingress_v1" "app_ingress" {
  metadata {
    name      = "nexus"
    namespace = kubernetes_namespace.dev.metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class"                    = "nginx",
      "nginx.ingress.kubernetes.io/proxy-body-size"    = "0",
      "nginx.ingress.kubernetes.io/proxy-read-timeout" = "600",
      "nginx.ingress.kubernetes.io/proxy-send-timeout" = "600"

    }
  }
  spec {
    rule {
      host = "app.local.com"
      http {
        path {
          path = "/"

          backend {
            service {
              name = kubernetes_service.app_svc.metadata.0.name
              port {
                number = 3000
              }
            }
          }
        }

      }
    }

  }
}
