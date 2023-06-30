resource "kubernetes_persistent_volume" "jenkins_pv" {
  metadata {
    name = "terraform-example"

  }
  spec {
    capacity = {
      storage = "5Gi"
    }
    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
      vsphere_volume {
        volume_path = "/home/mansour/my-data"
      }
    }
  }
}


resource "kubernetes_persistent_volume_claim" "jenkins_pvc" {
  metadata {
    name = "terraform-example-pvc"
    namespace = kubernetes_namespace.tools.metadata[0].name


  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
  }
}




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
        volume_path = "/home/mansour/nexus-data"
      }
    }
  }
}


resource "kubernetes_persistent_volume_claim" "nexus_pvc" {
  metadata {
    name = "nexus-pvc"
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

