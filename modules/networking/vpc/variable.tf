variable "tags" {
  type = object({
    application = string,
    environment = string
  })
}

variable "cidr_block" {
  type = string
}
