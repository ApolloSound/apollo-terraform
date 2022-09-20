variable "tags" {
  type = object({
    application = string,
    environment = string
  })
}
