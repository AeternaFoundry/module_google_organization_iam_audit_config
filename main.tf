resource "google_organization_iam_audit_config" "organization_iam_audit_configs" {
  for_each = var.organization_iam_audit_configs

  org_id  = each.value.org_id
  service = each.value.service

  dynamic "audit_log_config" {
    for_each = each.value.audit_log_config
    content {
      exempted_members = audit_log_config.value.exempted_members
      log_type         = audit_log_config.value.log_type
    }
  }
}

