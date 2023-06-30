resource "kubernetes_deployment" "nexus" {
  metadata {
    name      = "nexus"
    namespace = kubernetes_namespace.tools.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nexus"
      }
    }

    template {
      metadata {
        labels = {
          app = "nexus"
        }
      }

      spec {
        container {
          name  = "nexus"
          image = "sonatype/nexus3:latest"
          port {
            container_port = 8081
          }
          volume_mount {
            mount_path = "/nexus-data"
            name       = kubernetes_persistent_volume_claim.nexus_pvc.metadata[0].name
          }
        }
        volume {
          name = kubernetes_persistent_volume_claim.nexus_pvc.metadata[0].name
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.nexus_pvc.metadata[0].name
          }
        }
      }
    }
  }
}
