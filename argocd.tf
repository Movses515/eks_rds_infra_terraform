resource "helm_release" "argocd" {
  chart            = "argo-cd"
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  namespace        = "argocd"
  create_namespace = true

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "server.service.servicePortHttp"
    value = "80"
  }

  set {
    name  = "server.service.servicePortHttps"
    value = "443"
  }
}