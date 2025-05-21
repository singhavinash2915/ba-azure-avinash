#!/usr/bin/env pwsh

#Requires -PSEdition Core
#Requires -Modules @{ ModuleName="Pester"; ModuleVersion="5.0.0" }

Describe "azure-app-service-module" {

    BeforeAll {
        # In an ideal world (where time plays no role) we would
        # execute the Code under Test or System under Test (SUT) each time from a clean state
        # for any fact we want to ensure (every "It" part below).
        # Yet for long running stuff that needs configuration up 
        # front - like these end-to end-tests - we run the SUT just
        # once (in this BeforeAll-Block) and then the indidual "Tests"
        # in the "It"-Parts check the different aspects (facts) we want
        # to make sure are correct. If we need different runs with 
        # different params we use different Describe-Blocks (or maybe Scenarios).
        Push-Location 
        Set-Location "$PSScriptRoot/fixture"
        Write-Host "== Arrange: Prepare the test, in this case initialize Terraform, apply any additional prereqs." # In this case make sure we have something to delete and some other things that should be spared.
        terraform init | Out-Host
        ##$env:TF_LOG="DEBUG"
        Write-Host "== Act: Execute our SUT. In this case do the terraform apply."
        terraform apply --auto-approve | Out-Host
        Write-Host "== Assert: Examining the results."
    }

    AfterAll {
        Write-Host "== Tear-Down: Delete everything we created and that is still left over."
        # do not destroy if env DONOTDESTROYTF is set to True
        if ($env:DONOTDESTROYTF -eq $null -or $env:DONOTDESTROYTF.ToUpper() -ne "TRUE") {    
            Write-Host "DONOTDESTROYTF: $($env:DONOTDESTROYTF)"
            Write-Host "== Destroy: Destroying terraform applied resources."
            terraform destroy --auto-approve
        }
        else {
            Write-Host "DONOTDESTROYTF: $($env:DONOTDESTROYTF)"
            Write-Host "== No Destroy: Not Destroying terraform applied resources. Please take care of the resources."
        }
        Write-Host "== Remove: Remove local terraform artifacts."
        Remove-Item -Recurse -Force .\.terraform -ErrorAction "SilentlyContinue"
        Remove-Item -Force .\.terraform.lock.hcl -ErrorAction "SilentlyContinue"
        Remove-Item -Force .\terraform.tfstate -ErrorAction "SilentlyContinue"
        Pop-Location
    }
    # see https://pester.dev/docs/assertions/
    # Examples
    # It "returns name of created resource group" {
    #     terraform output --json "resource_group_name" | 
    #     ConvertFrom-Json |
    #     Should -Be "azure-rg-e2e-tests_rg"
    # }

    It "returns object of the created App Service Linux" {
        terraform output --json "app_service_linux" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns object of the created App Service Container" {
        terraform output --json "app_service_container" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns object of the created App Service Windows" {
        terraform output --json "app_service_windows" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns Id of the created App Service Linux" {
        terraform output --json "app_service_id_linux_root" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns Id of the created App Service Windows" {
        terraform output --json "app_service_id_windows_root" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns Id of the created App Service Container" {
        terraform output --json "app_service_id_container_root" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns Id of the created App Service Linux Plan" {
        terraform output --json "app_service_plan_id_linux_root" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns Id of the created App Service Plan Windows Plan" {
        terraform output --json "app_service_plan_id_windows_root" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns Id of the created App Service Container Plan" {
        terraform output --json "app_service_plan_id_container_root" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns domain ownership verification windows" {
        terraform output --json "app_service_custom_domain_verification_id_windows_root" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns domain ownership verification linux" {
        terraform output --json "app_service_custom_domain_verification_id_linux_root" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns domain ownership verification linux Container" {
        terraform output --json "app_service_custom_domain_verification_id_container_root" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }

    It "returns object of the created App Service Linux with easyauth" {
        terraform output --json "app_service_linux_easyauth_root" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns object of the created App Service Container with easyauth" {
        terraform output --json "app_service_container_easyauth_root" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns object of the created App Service Windows with easyauth" {
        terraform output --json "app_service_win_easyauth_root" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns object of the created App Service Linux with easyauth and Slots" {
        terraform output --json "app_service_linux_easyauth_with_slots_root" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }    
    
}

  