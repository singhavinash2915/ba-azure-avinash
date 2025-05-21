#!/usr/bin/env pwsh

#Requires -PSEdition Core
#Requires -Modules @{ ModuleName="Pester"; ModuleVersion="5.0.0" }

Describe "azure-in-acr-module" {

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
        Write-Host "== Destroy: Destroying terrafrom applied resources."
        terraform destroy --auto-approve | Out-Host
        Write-Host "== Remove: Remove local terraform artifacts."
        Remove-Item -Recurse -Force .\.terraform -ErrorAction "SilentlyContinue"
        Remove-Item -Force .\.terraform.lock.hcl -ErrorAction "SilentlyContinue"
        Remove-Item -Force .\terraform.tfstate -ErrorAction "SilentlyContinue"
        Pop-Location
    }
    # see https://pester.dev/docs/assertions/
    It "returns an id of created acr" {
        terraform output --json "acr_id" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns a full qualified name of created acr" {
        terraform output --json "acr_fqdn" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns a name of created acr" {
        terraform output --json "acr_name" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns a admin password of created acr" {
        terraform output --json "admin_password" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns a admin username of created acr" {
        terraform output --json "admin_username" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns a login server of created acr" {
        terraform output --json "login_server" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
     It "returns The name of the privateendpoint IP" {
         terraform output --json "privateendpointacr_id" | 
         ConvertFrom-Json |
         Should -Not -BeNullOrEmpty
     }
       It "returns The name of the privateendpoint IP" {
         terraform output --json "privateendpointacr_ip" | 
         ConvertFrom-Json |
         Should -Not -BeNullOrEmpty
     }
}