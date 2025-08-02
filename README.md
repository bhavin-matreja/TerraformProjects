# Terraform AWS Examples 🚀

A curated collection of **Terraform projects for AWS infrastructure**. Each folder in this repository represents an **independent Terraform project**, complete with `main.tf`, variables, and output files.

---

## 📂 Project Structure

| Folder                          | Description |
|---------------------------------|-------------|
| `aws-ec2/`                      | Deploys a basic EC2 instance |
| `aws-s3/`                       | Creates an S3 bucket with example config |
| `aws-vpc/`                      | Builds a custom VPC with subnets and routing |
| `aws-vpc-ec2-nginx/`           | Provisions a VPC, EC2 instance, and installs NGINX |
| `project-static-website/`      | Hosts a static website using S3 and CloudFront |
| `tf-data-sources/`             | Demonstrates use of Terraform data sources |
| `tf-backend/`                  | Configures remote backend (e.g., S3) for state storage |
| `tf-variables/`                | Shows how to use input variables and `terraform.tfvars` |
| `tf-operators-expressions/`    | Examples of conditionals, functions, and expressions |

---

## 🛠 How to Use

Each project is self-contained. You can use any by navigating to the folder and running standard Terraform commands:

```bash
cd aws-ec2  # or any other project
terraform init
terraform plan
terraform apply
