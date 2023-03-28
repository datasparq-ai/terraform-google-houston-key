
# Houston Key Terraform Module

Generates a random API key for an existing Houston instance. Saves the generated key to Google Secret Manager. 


### Usage

```hcl-terraform
provider "google" {
  project = "<your Google Cloud project ID>"
}

// Houston API service
module "houston" {
  source = "datasparq-ai/houston/google"
  zone   = "europe-west2-a"
}

// create a Houston key - will be saved to Secret Manager as 'houston-key'
module "houston_key" {
  source = "datasparq-ai/houston-key/google"
  name = "My New Project"
  houston_base_url = module.houston.houston_base_url
  houston_password = module.houston.houston_password
}
```
