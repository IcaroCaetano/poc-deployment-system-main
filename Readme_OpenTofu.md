# OpenTofu Overview

## What is OpenTofu?
OpenTofu is an **open-source fork of Terraform**, maintained by the Linux Foundation and supported by major industry players such as AWS, Google Cloud, Oracle, GitHub, and RedHat. It emerged after HashiCorp changed Terraform’s license from **MPL 2.0** (fully open-source) to **BSL (Business Source License)** in August 2023.

OpenTofu keeps the same core purpose:
- An **Infrastructure as Code (IaC)** tool
- Uses declarative configuration files (`.tf`) to define and manage infrastructure
- Enables **automation, reproducibility, and version control** for infrastructure

---

## Why OpenTofu? (Problems it solves)
OpenTofu addresses two main challenges:

1. **Licensing concerns**  
   Terraform’s shift to BSL created restrictions, especially for competitors offering SaaS. This raised concerns for companies and the community depending on open-source infrastructure tooling.

2. **Need for community-driven continuity**  
   By forking Terraform, the community ensured the existence of a **vendor-neutral, transparent, and auditable** alternative that remains truly open source.

---

## How to Use OpenTofu
OpenTofu usage is **nearly identical to Terraform**.

### Installation
```bash
# macOS / Linux (Homebrew)
brew tap opentofu/opentofu
brew install opentofu

# Or download binary
download latest release from GitHub:
https://github.com/opentofu/opentofu/releases
```

### Example Configuration
`main.tf`
```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-opentofu-bucket"
  acl    = "private"
}
```

### Commands
```bash
tofu init     # Initialize project
tofu plan     # Preview changes
tofu apply    # Apply infrastructure changes
tofu destroy  # Tear down infrastructure
```

---

## Advantages
- ✅ **Fully Open Source** – Licensed under MPL 2.0 with no commercial restrictions
- ✅ **Strong Community** – Backed by Linux Foundation and major cloud providers
- ✅ **Terraform-Compatible** – Same syntax (HCL) and workflow
- ✅ **Neutral Governance** – Not tied to a single vendor
- ✅ **Security & Transparency** – Community-driven, auditable code
- ✅ **Future-Proof** – Ensures continuity of open IaC tooling

---

## Disadvantages
- ⚠️ **New Project** – Still building maturity compared to Terraform
- ⚠️ **Smaller Ecosystem** – Some providers and modules may lag initially
- ⚠️ **Community Still Growing** – Ecosystem and adoption are in early stages
- ⚠️ **Migration Effort** – Organizations using Terraform may hesitate to switch immediately
- ⚠️ **Commercial Support** – Less established than HashiCorp’s offerings

---

## Summary
- **Why?** → Created to ensure an open alternative after Terraform’s license change
- **What?** → A community-driven fork of Terraform, maintained by Linux Foundation
- **How?** → Works almost identically to Terraform with `tofu init/plan/apply`
- **Advantages** → Open-source, neutral, strong backing
- **Disadvantages** → Younger project, smaller ecosystem, limited commercial support

---

If you are already using Terraform, you can switch to OpenTofu with **minimal effort** — simply replace the binary and continue managing your infrastructure with the same workflow.
