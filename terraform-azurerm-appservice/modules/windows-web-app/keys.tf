# 1024bit hex value
resource "random_bytes" "WEBSITE_AUTH_ENCRYPTION_KEY" {
  length = 32
}
resource "random_bytes" "WEBSITE_AUTH_SIGNING_KEY" {
  length = 32
}
