resource "kubernetes_ingress_v1" "nexus_ingress" {
  metadata {
    name      = "nexus"
    namespace = kubernetes_namespace.tools.metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class"                    = "nginx",
      "nginx.ingress.kubernetes.io/proxy-body-size"    = "0",
      "nginx.ingress.kubernetes.io/proxy-read-timeout" = "600",
      "nginx.ingress.kubernetes.io/proxy-send-timeout" = "600"

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
    }
    rule {
      host = "docker.nexus.local.com"
      http {
        path {
          path = "/"

          backend {
            service {
              name = kubernetes_service.nexus_svc.metadata.0.name
              port {
                number = 5000
              }
            }
          }
        }

      }
    }

    rule {
      host = "jenkins.local.com"
      http {
        path {
          path = "/"

          backend {
            service {
              name = kubernetes_service.jenkins_service.metadata.0.name
              port {
                number = 8080
              }
            }
          }
        }

      }
    }



  }
}
