
resource "random_password" "houston_key" {
  length  = 32
  special = false
}

# Form an HTTP POST request to the Houston service to create a new API key
data "http" "api_create_key" {
  url    = "${var.houston_base_url}/key"
  method = "POST"

  request_headers = {
    Authorization = "Basic ${base64encode("admin:${var.houston_password}")}"
  }

  # Optional request body
  request_body = jsonencode({
    "id" = random_password.houston_key.result
    "name" = var.name
  })

}

# Force api request to create key to run every time
resource "null_resource" "api_create_key" {
  # On failure, this will attempt to execute the false command in the
  # shell environment running terraform, causing an error
  provisioner "local-exec" {
    command = "echo \"status code: ${data.http.api_create_key.status_code}\" && ${contains([200, 201], data.http.api_create_key.status_code)}"
  }
  triggers = {
    always_run = timestamp()
  }
}

resource "google_secret_manager_secret" "houston_key" {
  secret_id =  var.secret_name
  replication {
    automatic = true
  }
}
resource "google_secret_manager_secret_version" "houston_key" {
  secret =  google_secret_manager_secret.houston_key.id
  secret_data = random_password.houston_key.result
}

output "id" {
  description = "The key's ID, which is used to authenticate with the API"
  value = google_secret_manager_secret_version.houston_key.secret_data
  sensitive = true
}
