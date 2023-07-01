resource "kubernetes_service" "nexus_svc" {
  depends_on = [kubernetes_deployment.nexus]
  metadata {
    name      = "nexus"
    namespace = kubernetes_namespace.tools.metadata[0].name
  }

  spec {
    selector = {
      app = "nexus"
    }

    port {
      name        = "http"
      protocol    = "TCP"
      port        = 8081
      target_port = 8081
    }
    port {
      name        = "docker"
      protocol    = "TCP"
      port        = 5000
      target_port = 5000
    }

    type = "ClusterIP"
  }
}

