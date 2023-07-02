resource "kubernetes_service_account_v1" "jenkins_admin" {
  metadata {
    name      = "jenkins-admin"
    namespace = kubernetes_namespace.tools.metadata[0].name

  }
}

resource "kubernetes_cluster_role_v1" "cluster_role" {
  metadata {
    name = "jenkins-admin"
  }

  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["*"]
  }
}

resource "kubernetes_cluster_role_binding_v1" "cluster_role_binding" {
  metadata {
    name = "jenkins-admin"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "jenkins-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "jenkins-admin"
    namespace = kubernetes_namespace.tools.metadata[0].name
  }
}
