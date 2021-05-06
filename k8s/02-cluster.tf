resource "scaleway_k8s_cluster" "monadial_k8s_cluster" {
  name        = "monadial-k8s-cluster"
  description = "Monadial K8S production cluster"
  version     = "1.21.0"
  cni         = "cilium"

  autoscaler_config {
    scale_down_delay_after_add    = "5m"
    ignore_daemonsets_utilization = true
    balance_similar_node_groups   = true
  }
}

resource "scaleway_k8s_pool" "monadial_k8s_pool" {
  cluster_id  = scaleway_k8s_cluster.monadial_k8s_cluster.id
  name        = "monadial-k8s-pool"
  node_type   = "DEV1-M"
  size        = 2
  autohealing = true
  autoscaling = true
  min_size    = 2
  max_size    = 6
}