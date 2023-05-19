variable "vpc_cidr" {}


variable "aws_subnet" {
  type    = number
  default = 2
}


# Define the subnets and their corresponding route tables
variable "subnets" {
  type = map(object({
    id           = string
    route_table_id = string
  }))
  default = {
    subnet1 = {
      id           = "subnet-1"
      route_table_id = "rtb-1"
    }
    subnet2 = {
      id           = "subnet-2"
      route_table_id = "rtb-2"
    }
  }
}




