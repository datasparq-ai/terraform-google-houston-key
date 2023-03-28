
variable "name" {
  type = string
  description = "Name for the Houston Key. It is recommended to use one key per project/environment."
}

variable "secret_name" {
  type = string
  default = "houston-key"
  description = "Secret ID to use for storing the new key in Secret Manager. Note that the default value 'houston-key' is what the Houston client looks for by default in Google Cloud Functions."
}

variable "houston_base_url" {
  type = string
  description = "URL of a Houston API service, including the API prefix, e.g. 'http://127.0.0.1/api/v1'."
}

variable "houston_password" {
  type = string
  description = "Admin password for the Houston API service."
}
