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

  set {
    name  = "server.extraArgs[0]"
    value = "--insecure"
  }

  depends_on = [module.eks]
}

resource "kubectl_manifest" "argocd_app" {
  yaml_body = file("${path.module}/argocd/application.yaml")

  depends_on = [module.eks, helm_release.argocd]
}