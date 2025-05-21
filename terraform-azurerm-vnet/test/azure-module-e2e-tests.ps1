#!/usr/bin/env pwsh

#Requires -PSEdition Core
#Requires -Modules @{ ModuleName="Pester"; ModuleVersion="5.0.0" }

Describe "azure-vnet-module" {

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
    # see https://pester.dev/docs/assertions/assertions
    It "returns an id of created vnet" {
        terraform output --json "virtual_network_id" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns a location westeurope of created vnet" {
        terraform output --json "virtual_network_location" | 
        ConvertFrom-Json |
        Should -Be "westeurope"
    }
    It "returns the name of created vnet" {
        terraform output --json "virtual_network_name" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns the address space of created vnet" {
        terraform output --json "virtual_network_space" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns the ids of subnets of created vnet" {
        terraform output --json "subnet_ids" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns the names of subnets of created vnet" {
        terraform output --json "subnet_names" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns the subnet address prefixes of created vnet" {
        terraform output --json "subnet_address_prefixes" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns the map of subnet names and ids of created vnet" {
        terraform output --json "named_subnet_ids" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns List of Network security group id" {
        terraform output --json "network_security_group_ids" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns List of Network security group name" {
        terraform output --json "network_security_group_names" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    
}
