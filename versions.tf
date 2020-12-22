
# required helm provider for this module 
provider "helm" { 
    version = "0.10.6"
}

# Required provider for local files 
provider "local" {
    version = "1.4.0"
}

# We are using 2.1.2 for helm deplpoy 
provider "template" {
    version  = "2.1.2"
}

