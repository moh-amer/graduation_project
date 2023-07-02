resource "kubernetes_service" "mysql_svc" {
  depends_on = [kubernetes_deployment.mysql_deployment]
  metadata {
    name      = "mysql-svc"
    namespace = kubernetes_namespace.dev.metadata[0].name
  }

  spec {
    selector = {
      app = "mysql"
    }

    port {
      protocol    = "TCP"
      port        = 3306
      target_port = 3306
    }

    type = "ClusterIP"
  }
}

