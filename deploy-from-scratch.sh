#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VALUES_FILE="${VALUES_FILE:-$SCRIPT_DIR/values.bitnami-postgresql.yaml}"
KUBECONFIG_PATH="${KUBECONFIG_PATH:-/home/oleg/Documents/hse-llm-project/cluster-config/llm_proj_talos/kubeconfig}"
NAMESPACE="${NAMESPACE:-hse-llm-project}"
RELEASE_NAME="${RELEASE_NAME:-postgresql}"
CHART_VERSION="${CHART_VERSION:-18.5.14}"
CHART_NAME="bitnami/postgresql"

log() {
  echo "[postgresql] $*"
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "[postgresql] ERROR: command not found: $1" >&2
    exit 1
  }
}

log "Starting deploy from scratch"
log "Namespace: $NAMESPACE | Release: $RELEASE_NAME"
log "Chart: $CHART_NAME:$CHART_VERSION"
log "Values file: $VALUES_FILE"
log "Kubeconfig: $KUBECONFIG_PATH"

log "Checking required commands..."
need_cmd helm
need_cmd kubectl
log "Commands OK"

[[ -f "$KUBECONFIG_PATH" ]] || {
  echo "[postgresql] ERROR: kubeconfig not found: $KUBECONFIG_PATH" >&2
  exit 1
}

[[ -f "$VALUES_FILE" ]] || {
  echo "[postgresql] ERROR: values file not found: $VALUES_FILE" >&2
  exit 1
}

export KUBECONFIG="$KUBECONFIG_PATH"

log "Updating Helm repository metadata..."
helm repo add bitnami https://charts.bitnami.com/bitnami >/dev/null 2>&1 || true
helm repo update >/dev/null

log "Running helm upgrade --install..."
helm upgrade --install "$RELEASE_NAME" "$CHART_NAME" \
  --version "$CHART_VERSION" \
  --namespace "$NAMESPACE" \
  --create-namespace \
  -f "$VALUES_FILE"

log "Deployment finished. Current resources:"
kubectl get pods,svc,pvc -n "$NAMESPACE"
