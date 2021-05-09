resource "scaleway_k8s_cluster" "mcluster" {
  name        = "monadial-k8s-cluster"
  description = "Monadial K8s cluster."
  version     = "1.21.0"
  cni         = "cilium"

  autoscaler_config {
    disable_scale_down              = false
    scale_down_delay_after_add      = "5m"
    ignore_daemonsets_utilization   = true
    balance_similar_node_groups     = true
    expendable_pods_priority_cutoff = -5
  }
}

resource "scaleway_k8s_pool" "mpool" {
  cluster_id  = scaleway_k8s_cluster.mcluster.id
  name        = "monadial-k8s-pool"
  node_type   = "DEV1-M"
  size        = 2
  autoscaling = true
  autohealing = true
  min_size    = 2
  max_size    = 6
}

resource "null_resource" "kubeconfig" {
  depends_on = [scaleway_k8s_pool.mpool]
  triggers = {
    host                   = scaleway_k8s_cluster.mcluster.kubeconfig[0].host
    token                  = scaleway_k8s_cluster.mcluster.kubeconfig[0].token
    cluster_ca_certificate = scaleway_k8s_cluster.mcluster.kubeconfig[0].cluster_ca_certificate
  }
}


provider "kubernetes" {
  host             = null_resource.kubeconfig.triggers.host
  token            = null_resource.kubeconfig.triggers.token
  cluster_ca_certificate = base64decode(
    null_resource.kubeconfig.triggers.cluster_ca_certificate
  )
}

provider "helm" {
  kubernetes {
    host             = null_resource.kubeconfig.triggers.host
    token            = null_resource.kubeconfig.triggers.token
    cluster_ca_certificate = base64decode(
      null_resource.kubeconfig.triggers.cluster_ca_certificate
    )
  }
}