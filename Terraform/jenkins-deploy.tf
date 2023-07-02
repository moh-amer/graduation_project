resource "kubernetes_deployment" "jenkins" {
  metadata {
    name      = "jenkins"
    namespace = kubernetes_namespace.tools.metadata[0].name

    labels = {
      app = "jenkins"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "jenkins"
      }
    }

    template {
      metadata {
        labels = {
          app = "jenkins"
        }
      }

      spec {
        container {
          name  = "jenkins"
          image = "jenkins/jenkins:lts"
          port {
            name           = "httpport"
            container_port = 8080
          }
          port {
            name           = "jnlpport"
            container_port = 50000
          }

          volume_mount {
            name       = "jenkins-data"
            mount_path = "/var/jenkins_home"
          }
        }

        service_account_name = "jenkins-admin"
        security_context {
          run_as_user = 1000
          fs_group    = 1000
        }
        volume {
          name = "jenkins-data"

          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.jenkins_pvc.metadata[0].name
          }
        }
      }
    }
  }
}

