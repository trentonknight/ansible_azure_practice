# Installing Python libraries using Poetry and a little Bash
* [Python Poetry](https://python-poetry.org/)

To install the appropriate python libraries ensure you have poetry installed in your environment.

```bash
curl -sSL https://install.python-poetry.org | python3 -
```

Enter the poetry environment within the repository directory:

```bash
cd ansible_azure_practice/ansible_azure/
```

Install the Python dependancies using Poetry

```bash
poetry install
```

Install remaining dependancies using bash script.

```bash
sh ./runme.sh
```

Or run manually via cli:

```bash
poetry run pip3 install --upgrade pip; \
	poetry run pip3 install --upgrade virtualenv; \
	poetry run ansible-galaxy collection install azure.azcollection; \
	poetry run pip3 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt
```

# Read this before attempting to authenticate with Azure
* [Authenticating with Azure](https://docs.ansible.com/ansible/latest/scenario_guides/guide_azure.html)
* [Connect to Azure from the Ansible container](https://learn.microsoft.com/en-us/azure/developer/ansible/configure-in-docker-container?tabs=azure-cli)

For authentication to azure you must first ensure you have the following setup in your `~/.azure/credentials` file:

```bash
[default]
subscription_id=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
client_id=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
secret=xxxxxxxxxxxxxxxxx
tenant=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

## To grab your subscrition id you may use az-cli to retrieve this information as follows:

```bash
subscriptionID=$(az account show --query id -o tsv)
echo $subscriptionID
```
## Client ID

The client ID is the unique Application (client) ID assigned to your app by Azure AD when the app was registered. You can find the Application (Client) ID in your Azure subscription by Azure AD => Enterprise applications => Application ID.

```bash
az ad app list
```
## Resource group quick cli commands
### List resource groups

```bash
az group list
```

### To create a new resource 
Run the below command with `az` only if you need to create a resource group 

```bash
az group create --name demoResourceGroup --location eastus
```
### Delete a resource group
If you no longer need a resource group you can delete it as follows:

```bash
az group delete --name exampleGroup
```

# List your Tenants 

* [Azure AD](https://learn.microsoft.com/en-us/microsoft-365/education/deploy/intro-azure-active-directory)

An Azure AD tenant provides identity and access management (IAM) capabilities to applications and resources used by your organization. An identity is a directory object that can be authenticated and authorized for access to a resource. Identity objects exist for human identities such as students and teachers, and non-human identities like classroom and student devices, applications, and service principles. Make sure you are using the correct `tenantId` if you have multiple accounts. 

```bash
az account list
```


