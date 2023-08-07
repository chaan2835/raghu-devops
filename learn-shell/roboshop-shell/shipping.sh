script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
shipping_password=#1

if [ -z "$shipping_password" ]; then
    heading_func "Input roboshop sipping password is missing"
    Exit
fi

component="shipping"
func_java()