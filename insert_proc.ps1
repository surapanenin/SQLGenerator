$procContent = Get-Content 'C:\GIT\SQLGenerator\SQLSource\usp_test.sql' -Raw
$mainContent = Get-Content 'C:\GIT\SQLGenerator\SQLSource\SQLCode.sql' -Raw
$mainContent = $mainContent -replace '(USE \[master\]\s+GO)', ($procContent + "`r`n`r`n`$1")
Set-Content 'C:\GIT\SQLGenerator\SQLSource\SQLCode.sql' -Value $mainContent -NoNewline

