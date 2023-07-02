resource "kubernetes_service" "jenkins_service" {
  metadata {
    name      = "jenkins-service"
    namespace = kubernetes_namespace.tools.metadata[0].name
  }

  spec {
    selector = {
      app = kubernetes_deployment.jenkins.spec[0].template[0].metadata[0].labels["app"]
    }

    type = "ClusterIP"

    port {
      name        = "htpport"
      port        = 8080
      target_port = 8080
    }
    port {
      name        = "jnlpport"
      port        = 50000
      target_port = 50000
    }
  }
}

