#!/usr/bin/env pwsh

#Requires -PSEdition Core
#Requires -Modules @{ ModuleName="Pester"; ModuleVersion="5.0.0" }

Describe "azure-app-insights-module" {

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

    # Log Analytics workspace
    It "returns the ID of the Application Insights component" {
        terraform output --json "application_insights_id" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns Id of the Application Insights associated to the App Service" {
        terraform output --json "application_insights_app_id" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns Instrumentation key of the Application Insights associated to the App Service" {
        terraform output --json "application_insights_instrumentation_key" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    } 
    It "returns Connection string of the Application Insights associated to the App Service" {
        terraform output --json "application_insights_connection_string" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns the Log Analytics Workspace ID." {
        terraform output --json "log_analytics_workspace_id" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns the Primary shared key for the Log Analytics Workspace." {
        terraform output --json "log_analytics_workspace_primary_shared_key" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns the Secondary shared key for the Log Analytics Workspace." {
        terraform output --json "log_analytics_workspace_secondary_shared_key" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns the ID of the Diagnostic Setting for the Application Insights component" {
        terraform output --json "app_insights_azurerm_monitor_diagnostic_setting" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }

    # Storage Account
    It "returns the ID of the Application Insights component" {
        terraform output --json "application_insights_id_sa" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns Id of the Application Insights associated to the App Service" {
        terraform output --json "application_insights_app_id_sa" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns Instrumentation key of the Application Insights associated to the App Service" {
        terraform output --json "application_insights_instrumentation_key_sa" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    } 
    It "returns Connection string of the Application Insights associated to the App Service" {
        terraform output --json "application_insights_connection_string_sa" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns the Storage Account ID." {
        terraform output --json "storage_account_id_sa" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns the Storage Account Name." {
        terraform output --json "storage_account_name_sa" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns the ID of the Diagnostic Setting for the Application Insights component" {
        terraform output --json "app_insights_sa_azurerm_monitor_diagnostic_setting" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
}
