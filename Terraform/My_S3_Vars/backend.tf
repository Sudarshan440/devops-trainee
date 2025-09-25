terraform {
  backend "s3"{
    # bucket = "my-terraform-xyz123_pumpkin007"
    # key = "dev/app/terraform.tfstate"
    # region = "us-east-1"
    # lock_table  = "terraform-locks"
    # encrypt = false #true recommended for production 
    use_lockfile = true  # dynamodb_table = "my-terraform-lock-table" is depricated
    
    # Terraform automatically uses dynamodb_table as the locking table
    # if you created it previously and specified it during terraform init -backend-config
    # profile = "default"
    # endpoint = "https://s3.amazonaws.com"
}
}