#enforce default trusted images constraint?
resource "google_org_policy_policy" "trusted_images" {
  count  = var.enforce_trusted_images ? 0 : 1
  name   = "projects/${var.project_name}/policies/compute.trustedImageProjects"
  parent = "projects/${var.project_name}"

  spec {
    rules {
      allow_all = "TRUE"
    }
  }
}

#enfore shielded vm constraint?
resource "google_org_policy_policy" "shielded_vm" {
  count  = var.enforce_shielded_vms ? 0 : 1
  name   = "projects/${var.project_name}/policies/compute.requireShieldedVm"
  parent = "projects/${var.project_name}"

  spec {
    rules {
      enforce = "FALSE"
    }
  }
}
