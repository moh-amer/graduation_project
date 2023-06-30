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

    type = "NodePort"

    port {
      port        = 8081
      target_port = 8081
      node_port   = 30005
    }
  }
}

resource "kubernetes_service" "nexus_svcIP" {
  metadata {
    name = "nexus-service"
    namespace = kubernetes_namespace.tools.metadata[0].name
  }

  spec {
    selector = {
      app = "nexus"
    }

    port {
      port        = 8081
      target_port = 8081
    }

    type = "ClusterIP"
  }
}

