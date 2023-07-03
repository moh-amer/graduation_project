# Mysql secrets
resource "kubernetes_secret_v1" "mysql_secret" {
  metadata {
    name      = "mysql-secret"
    namespace = kubernetes_namespace.dev.metadata[0].name

  }

  data = {
    MYSQL_ROOT_PASSWORD = "bW9oMTIz"
    MYSQL_DATABASE      = "mydb"
  }

  type = "Opaque"
}

# NodeJs App Secrets
resource "kubernetes_secret_v1" "app_secret" {
  metadata {
    name      = "app-secret"
    namespace = kubernetes_namespace.dev.metadata[0].name

  }

  data = {
    HOST     = "mysql-svc"
    USERNAME = "root"
    PASSWORD = "bW9oMTIz"
    DATABASE = "mydb"
  }

  type = "Opaque"
}

# kubectl create secret generic regcred \
#     --from-file=.dockerconfigjson=/home/fedora/.docker/config.json \
#     --type=kubernetes.io/dockerconfigjson --namespace=dev

resource "kubernetes_secret_v1" "nexus-cred" {
  metadata {
    name      = "regcred"
    namespace = kubernetes_namespace.dev.metadata[0].name
  }

  data = {
    ".dockerconfigjson" = "${file("/home/fedora/.docker/config.json")}"
  }

  type = "kubernetes.io/dockerconfigjson"
}

#  kubectl create secret generic kaniko-secret --from-file=/home/fedora/config.json --namespace=tools

resource "kubernetes_secret_v1" "kaniko_secret" {
  metadata {
    name      = "kaniko-secret"
    namespace = kubernetes_namespace.tools.metadata[0].name
  }

  data = {
    "config.json" = "${file("/home/fedora/config.json")}"
  }

  type = "Opaque"
}
