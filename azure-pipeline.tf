# Starter pipeline
# Start with a minimal pipeline that you can customize to build and deploy your code.
# Add steps that build, run tests, deploy, and more:
# https://aka.ms/yaml

trigger:
- master

pool:
  vmImage: ubuntu-latest

stages:
  - stage: TerraformApply
    jobs:
      - job: AzureResourceCreation
        steps:
          - task: TerraformInstaller@1
            inputs:
              terraformVersion: 'latest'

          - task: TerraformTask@5
            inputs:
              provider: 'azurerm'
              command: 'init'
              backendServiceArm: '3-tier-app-devops-azure-connection'
              backendAzureRmResourceGroupName: 'tf-backend-rg'
              backendAzureRmStorageAccountName: 'commonstorageaccount6799'
              backendAzureRmContainerName: 'terraform-state-storage-container'
              backendAzureRmKey: '3tier.terraform.tfstate'

          - task: TerraformTask@5
            inputs:
              provider: 'azurerm'
              command: 'validate'

          - task: TerraformTask@5
            inputs:
              provider: 'azurerm'
              command: 'plan'
              commandOptions: '-out=tfplan'
              environmentServiceNameAzureRM: '3-tier-app-devops-azure-connection'

          - task: TerraformTask@5
            inputs:
              provider: 'azurerm'
              command: 'apply'
              commandOptions: 'tfplan'
              environmentServiceNameAzureRM: '3-tier-app-devops-azure-connection'

          - task: TerraformTask@5
            inputs:
              provider: 'azurerm'
              command: 'destroy'
              environmentServiceNameAzureRM: '3-tier-app-devops-azure-connection'
              