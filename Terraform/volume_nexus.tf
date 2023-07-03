resource "kubernetes_persistent_volume" "nexus_pv" {
  metadata {
    name = "nexus-pv"

  }
  spec {
    capacity = {
      storage = "2Gi"
    }
    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
      vsphere_volume {
        volume_path = "/home/fedora/nexus-data"
      }
    }
  }
}


resource "kubernetes_persistent_volume_claim" "nexus_pvc" {
  metadata {
    name      = "nexus-pvc"
    namespace = kubernetes_namespace.tools.metadata[0].name


  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "2Gi"
      }
    }
  }
}


