## Installing Python libraries using Poetry and a little Bash
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

Be careful how you share or record your authentication information above. Do not include your secrets in a git repo or anything shared.

For authentication to azure you must first ensure you have the following setup in your `~/.azure/credentials` file:

```bash
[default]
subscription_id=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
client_id=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
secret=xxxxxxxxxxxxxxxxx
tenant=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

Alternatively, you could export via .bashrc or directly in terminal if needed:

```bash
export AZURE_TENANT="<azure_tenant_id>"
export AZURE_SUBSCRIPTION_ID="<azure_subscription_id>"
export AZURE_CLIENT_ID="<service_principal_app_id>"
export AZURE_SECRET="<service_principal_password>"
```

### Subscription ID

To grab your subscription id you may use az-cli to retrieve this information as follows:

```bash
subscriptionID=$(az account show --query id -o tsv)
echo $subscriptionID
```

### Tenant ID 

* [Azure AD](https://learn.microsoft.com/en-us/microsoft-365/education/deploy/intro-azure-active-directory)

An Azure AD tenant provides identity and access management (IAM) capabilities to applications and resources used by your organization. An identity is a directory object that can be authenticated and authorized for access to a resource. Identity objects exist for human identities such as students and teachers, and non-human identities like classroom and student devices, applications, and service principles. Make sure you are using the correct `tenantId` if you have multiple accounts. 

```bash
az account list
```
### Resource group for new Application
The below are some quick reference commands for creating a new resource group for this app. If you already have a resource group you can use ignore this section.

#### List resource groups

```bash
az group list
```

#### To create a new resource 
Run the below command with `az` only if you need to create a resource group 

```bash
az group create --name demoResourceGroup --location eastus
```
#### Delete a resource group
If you no longer need a resource group you can delete it as follows:

```bash
az group delete --resource-group exampleGroup
```

### Service Principle Secret

* [app-objects-and-service-principals](https://learn.microsoft.com/en-us/azure/active-directory/develop/app-objects-and-service-principals)

An Azure AD application is defined by its one and only application object, which resides in the Azure AD tenant where the application was registered (known as the application's "home" tenant):
* An `application object` is used as a template or blueprint to create one or more service principal objects. 
* A `service principal` is created in every tenant where the application is used. 
* To access resources that are secured by an Azure AD tenant, the entity that requires access must be represented by a `security principal`.
 
In this particular case we are using an `Application` type of service principle vs a `Managed Identity` or `Legacy App` types. If you do not already have a application type service principle you may create one using the following commands:

```bash
let "randomIdentifier=$RANDOM*$RANDOM"  
servicePrincipalName="msdocs-sp-$randomIdentifier"
roleName="Contributor"
subscriptionID=$(az account show --query id -o tsv)
# Verify the ID of the active subscription
echo "Using subscription ID $subscriptionID"
resourceGroup="myResourceGroupName"

echo "Creating SP for RBAC with name $servicePrincipalName, with role $roleName and in scopes /subscriptions/$subscriptionID/resourceGroups/$resourceGroup"
az ad sp create-for-rbac --name $servicePrincipalName --role $roleName --scopes /subscriptions/$subscriptionID/resourceGroups/$resourceGroup
```


### Client ID

The client ID is the unique Application (client) ID assigned to your app by Azure AD when the app was registered. You can find the Application (Client) ID in your Azure subscription by Azure AD => Enterprise applications => Application ID.

```bash
az ad app list
```
