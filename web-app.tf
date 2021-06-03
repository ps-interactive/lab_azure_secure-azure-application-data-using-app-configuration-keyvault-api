
# # add null resource to deploy code into that webapp, since deploy requires scm info generated after webapp created
# resource "null_resource" "mywebappcode" {
# # make a local git repo of the code we want to deploy
# # using ... || true to ignore errors, refer https://stackoverflow.com/questions/11231937/bash-ignoring-error-for-a-particular-command
#   provisioner "local-exec" {
#    command = "rm -rf ./app-service-web-html-get-started/ || true"
#   }
#     provisioner "local-exec" {
#    command = "git clone ${local.github_repo_url}"
#   }
# # deploy code to the scm of the webapp  
#   provisioner "local-exec" {
#    command = "git remote remove azure || true"
#   }  
#   provisioner "local-exec" {
#    command = "git remote add azure '${local.repository_cred_url}'"
#   }  
#   provisioner "local-exec" {
#    command = "cd ${local.github_repo_folder}"
#   }  
#   provisioner "local-exec" {
#    command = "git config --global push.default simple && git push azure"
#   }        

# }