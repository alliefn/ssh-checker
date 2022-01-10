echo "Deploying..."
ansible-playbook deployrepo.yaml
ansible-playbook deployserver.yaml -K
ansible-playbook deployclient.yaml -K
echo "Deployed!"