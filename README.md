# Cloud Modularization: Terraform-Powered AWS Environment Deployment

## Introduction
All the Modules code and tf files are available in the [Terraform](https://github.com/ashwaq06/terraform_module_creation/tree/main/Terraform) directory.

## Folder Structure and Files
<img width="171" alt="Screenshot 2024-03-03 at 8 45 03 PM" src="https://github.com/ashwaq06/terraform_module_creation/assets/80192952/37956767-09d3-4379-9ec8-ffae4fb16a02">


## Terraform Commands

### Initialization
```bash
terraform init
```
![image](https://github.com/ashwaq06/terraform_module_creation/assets/80192952/759812b4-39c2-4649-9a34-102ea5ccc534)


### Plan
```bash
terraform plan
```
![image](https://github.com/ashwaq06/terraform_module_creation/assets/80192952/be1f2c37-1715-4216-9568-b5610751d284)
![image](https://github.com/ashwaq06/terraform_module_creation/assets/80192952/28cfcd00-0841-4cc2-8d30-84877acaf4f0)


### Apply
```bash
terraform apply
```
![image](https://github.com/ashwaq06/terraform_module_creation/assets/80192952/c00d646e-899d-41b8-94fe-95ab241e14f9)

After Apply, save the SSH key as `BastionSSHKey.pem` to access the jumphost through SSH.

### Storing SSH Keys
To securely manage SSH access to instances, we can store the public SSH key in the `authorized_keys` file on each instance. This ensures that only users with the corresponding private key can access the instance via SSH.

Here's an example of how you can add your SSH public key to the `authorized_keys` file on an instance:

```bash
ssh-copy-id -i /path/to/public_key.pem user@instance_ip
```

Replace `/path/to/public_key.pem` with the path to your SSH public key file and `user@instance_ip` with the username and IP address of the instance.

## Conclusion
By organizing our Terraform module as described above and executing the provided commands, we'll be able to create a robust AWS infrastructure that meets the specified requirements. 
Below I'm sharing some of the Output Images from AWS
![image](https://github.com/ashwaq06/terraform_module_creation/assets/80192952/6d76ddd9-2c30-40a6-8ec1-ec3d9145187a)
![image](https://github.com/ashwaq06/terraform_module_creation/assets/80192952/30685559-2542-44e0-a6f4-f79592252e15)
![image](https://github.com/ashwaq06/terraform_module_creation/assets/80192952/50d3ed48-8ed5-41a3-b35e-5e8c555894eb)
![image](https://github.com/ashwaq06/terraform_module_creation/assets/80192952/76a69ee4-8c96-4e64-a3b9-ec5519b2376d)

To avoid unnecessary charges, I've destroyed the infrastructure using the command:
```bash
terraform destroy
```

```

This addition provides important information on how to securely manage SSH access to instances, enhancing the overall completeness and security of your README.
