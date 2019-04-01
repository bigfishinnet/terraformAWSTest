# Create the vpc

resource "aws_vpc" "main" {
	cidr_block = "${var.cidr_block}"

	tags = {
		Name = "stephen"
		}
} # end resource

# create the Private Subnet
resource "aws_subnet" "stephen-subnetprivate" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${var.subnetprivateCIDRblock}"

tags = {
   Name = "stephen-subnetprivate"
  }
} # end resource

# create the Public Subnet
resource "aws_subnet" "stephen-subnetpublic" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${var.subnetpublicCIDRblock}"

tags = {
   Name = "stephen-subnetpublic"
  }
} # end of resource

# Create the Public Route Table
resource "aws_route_table" "stephen_public_route_table" {
    vpc_id = "${aws_vpc.main.id}"

tags {
        Name = "stephen VPC Public Route Table"
    }
} # end resource

# Create the Private Route Table
resource "aws_route_table" "stephen_private_route_table" {
    vpc_id = "${aws_vpc.main.id}"

tags {
        Name = "stephen VPC Private Route Table"
    }
} # end resource

# Associate the Public Route Table with the Public Subnet
resource "aws_route_table_association" "stephen_Public_VPC_association" {
    subnet_id      = "${aws_subnet.stephen-subnetpublic.id}"
    route_table_id = "${aws_route_table.stephen_public_route_table.id}"
} # end resource

# Associate the Private Route Table with the Private Subnet
resource "aws_route_table_association" "stephen_Private_VPC_association" {
    subnet_id      = "${aws_subnet.stephen-subnetprivate.id}"
    route_table_id = "${aws_route_table.stephen_private_route_table.id}"
} # end resource

# Create the Internet Access
resource "aws_route" "stephen_VPC_internet_access" {
  route_table_id        = "${aws_route_table.stephen_public_route_table.id}"
  destination_cidr_block = "${var.subnetdestinationCIDRblock}"
  gateway_id             = "${aws_internet_gateway.stephen_VPC_GW.id}"
} # end resource

# Create the Internet Gateway
resource "aws_internet_gateway" "stephen_VPC_GW" {
  vpc_id = "${aws_vpc.main.id}"

tags {
        Name = "stephen VPC Internet Gateway"
    }
} # end resource