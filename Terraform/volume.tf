resource "kubernetes_persistent_volume" "example" {
  metadata {
    name = "terraform-example"

  }
  spec {
    capacity = {
      storage = "2Gi"
    }
    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
      vsphere_volume {
        volume_path = "/home/mansour/my-data"
      }
    }
  }
}


resource "kubernetes_persistent_volume_claim" "example_pvc" {
  metadata {
    name = "terraform-example-pvc"
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
