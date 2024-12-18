param(
    [Parameter(Mandatory=$true)]
    [string]$solutionName
)

# Create solution
New-Item -ItemType Directory -Force -Path $solutionName
Set-Location $solutionName
dotnet new sln

# Create projects
dotnet new webapi -n "$solutionName.Api"
dotnet new classlib -n "$solutionName.Core"
dotnet new classlib -n "$solutionName.Infrastructure"

# Add to solution
dotnet sln add "$solutionName.Api"
dotnet sln add "$solutionName.Core"
dotnet sln add "$solutionName.Infrastructure"

# Add references
dotnet add "$solutionName.Api" reference "$solutionName.Core"
dotnet add "$solutionName.Api" reference "$solutionName.Infrastructure"
dotnet add "$solutionName.Infrastructure" reference "$solutionName.Core"

# Create basic folders
Set-Location "$solutionName.Core"
New-Item -ItemType Directory -Force -Path "Models"
New-Item -ItemType Directory -Force -Path "Interfaces"
New-Item -ItemType Directory -Force -Path "Services"

Set-Location "..\$solutionName.Infrastructure"
New-Item -ItemType Directory -Force -Path "Data"
New-Item -ItemType Directory -Force -Path "Services"

Write-Host "Done! Solution created at ./$solutionName" -ForegroundColor Green