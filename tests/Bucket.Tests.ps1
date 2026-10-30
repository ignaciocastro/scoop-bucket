#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.2.0' }

BeforeDiscovery {
    if (!$env:SCOOP_HOME) { $env:SCOOP_HOME = Resolve-Path (scoop prefix scoop) }
    $test_list = Get-ChildItem "$PSScriptRoot/../bucket" -Filter '*.json'
}

Describe "Manifest Validator" {
    It "<_.BaseName>" -ForEach $test_list {
        $json = Get-Content $_.FullName -Raw | ConvertFrom-Json -ErrorAction Stop
        $json.version | Should -Not -BeNullOrEmpty
        $json.url | Should -Not -BeNullOrEmpty
        $json.hash | Should -Not -BeNullOrEmpty
    }
}
