# Jenkins admin service account and cluster role and cluster role binding used by jenkins pod
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
    api_groups = [""]
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

# kube-deployer service account and cluster role and cluster role binding used by deployer pod
resource "kubernetes_service_account_v1" "kube_deployer" {
  metadata {
    name      = "kube-deployer"
    namespace = kubernetes_namespace.tools.metadata[0].name

  }
}

resource "kubernetes_cluster_role_v1" "deployer_cluster_role" {
  metadata {
    name = "kube-deployer"
  }

  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "replicasets"]
    verbs      = ["*"]
  }

  rule {
    api_groups = [""]
    resources  = ["services", "pods"]
    verbs      = ["*"]
  }
  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses", "ingresses/status"]
    verbs      = ["*"]
  }
}

resource "kubernetes_cluster_role_binding_v1" "deployer_cluster_role_binding" {
  metadata {
    name = "kube-deployer"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "kube-deployer"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "kube-deployer"
    namespace = kubernetes_namespace.tools.metadata[0].name
  }
}
