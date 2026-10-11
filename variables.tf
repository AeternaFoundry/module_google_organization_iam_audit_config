variable "organization_iam_audit_configs" {
  description = <<EOT
Map of organization_iam_audit_configs, attributes below
Required:
    - org_id
    - service
    - audit_log_config (block):
        - exempted_members (optional)
        - log_type (required)
EOT

  type = map(object({
    org_id  = string
    service = string
    audit_log_config = list(object({
      exempted_members = optional(set(string))
      log_type         = string
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.organization_iam_audit_configs : (
        length(v.audit_log_config) >= 1
      )
    ])
    error_message = "Each audit_log_config list must contain at least 1 items"
  }
}

