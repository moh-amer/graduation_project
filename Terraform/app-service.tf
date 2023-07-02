resource "kubernetes_service" "app_svc" {
  depends_on = [kubernetes_deployment.app_deployment]
  metadata {
    name      = "app-svc"
    namespace = kubernetes_namespace.dev.metadata[0].name
  }

  spec {
    selector = {
      app = "nodejs"
    }

    port {
      protocol    = "TCP"
      port        = 3000
      target_port = 3000
    }

    type = "ClusterIP"
  }
}
