#!/usr/bin/env pwsh

#Requires -PSEdition Core
#Requires -Modules @{ ModuleName="Pester"; ModuleVersion="5.0.0" }

Describe "azure-in-storage-module" {

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
    # Examples
    # It "returns name of created resource group" {
    #     terraform output --json "resource_group_name" | 
    #     ConvertFrom-Json |
    #     Should -Be "azure-rg-e2e-tests_rg"
    # }


    It "returns an The ID of the storage account." {
        terraform output --json "storage_id" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns The name of the storage account" {
        terraform output --json "storage_name" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }

    It "returns The Principal ID of the managed identity" {
        terraform output --json "storage_identity_principal_id" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }

    It "returns The primary connection string for the storage account." {
        terraform output --json "storage_primary_connection_string" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }

    It "returns The primary access key for the storage account" {
        terraform output --json "storage_primary_access_key" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }

    It "returns The endpoint URL for blob storage in the primary location." {
        terraform output --json "primary_blob_endpoint" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }

    It "returns The connection string associated with the primary blob location." {
        terraform output --json "primary_blob_connection_string" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns The name of the privateendpoint ID storageblob" {
        terraform output --json "storageblobprivateendpoint_id" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns The name of the privateendpoint ID storagefile" {
        terraform output --json "storagefileprivateendpoint_id" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns The name of the privateendpoint IP" {
        terraform output --json "storagefileprivateendpoint_ip" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns The name of the privateendpoint IP" {
        terraform output --json "storageblobprivateendpoint_ip" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }

    It "returns The tupel of the subnet IDs." {
        terraform output --json "storage_virtual_network_subnet_ids" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }

    It "returns The IP list of IPv4 address having access through the firewall to the storage account." {
        terraform output --json "storage_ip_rules" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    
    ## Static Website
    It "returns The indicator whether the storage account activates static website hosting." {
        terraform output --json "static_website_enabled_staticwebsite" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns The endpoint URL for web storage in the primary location." {
        terraform output --json "primary_web_endpoint_staticwebsite" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns The hostname with port if applicable for web storage in the primary location." {
        terraform output --json "primary_web_host_staticwebsite" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns The name of the privateendpoint ID storagestaticwebsite" {
        terraform output --json "storageswebprivateendpoint_id" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
    It "returns The name of the privateendpoint IP storagestaticwebsite" {
        terraform output --json "storageswebprivateendpoint_ip" | 
        ConvertFrom-Json |
        Should -Not -BeNullOrEmpty
    }
   
}