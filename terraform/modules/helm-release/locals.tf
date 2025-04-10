// ──────────────────────────────────────────────
// Local Values: Improve Maintainability and DRY
// ──────────────────────────────────────────────
locals {
  namespace       = var.namespace
  release_name    = "${var.release_name}-${var.environment}"
  helm_values     = compact([
    fileexists(var.values_file) ? file(var.values_file) : "",
    fileexists(var.environment_values_file) ? file(var.environment_values_file) : ""
  ])
}