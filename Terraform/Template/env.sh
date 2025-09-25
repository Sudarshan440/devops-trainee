# env.sh
# export TF_VAR_vpc_name="dev-vpc"
export TF_VAR_region="ap-northeast-1" #tokyo
export TF_VAR_tags='{"Environment":"dev","Project":"vpc-practice-55"}'

# Single quotes are important in bash to avoid problems with " inside the JSON.
# Terraform automatically converts this string into a map for var.tags.
