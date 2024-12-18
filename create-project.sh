#!/bin/bash

# Check if solution name is provided
if [ -z "$1" ]
then
    echo "Please provide a solution name"
    echo "Usage: ./create-project.sh MySolution"
    exit 1
fi

SOLUTION_NAME=$1

# Create solution
mkdir $SOLUTION_NAME
cd $SOLUTION_NAME
dotnet new sln

# Create projects
dotnet new webapi -n "$SOLUTION_NAME.Api"
dotnet new classlib -n "$SOLUTION_NAME.Core"
dotnet new classlib -n "$SOLUTION_NAME.Infrastructure"

# Add to solution
dotnet sln add "$SOLUTION_NAME.Api"
dotnet sln add "$SOLUTION_NAME.Core"
dotnet sln add "$SOLUTION_NAME.Infrastructure"

# Add references
dotnet add "$SOLUTION_NAME.Api" reference "$SOLUTION_NAME.Core"
dotnet add "$SOLUTION_NAME.Api" reference "$SOLUTION_NAME.Infrastructure"
dotnet add "$SOLUTION_NAME.Infrastructure" reference "$SOLUTION_NAME.Core"

# Create basic folders
cd "$SOLUTION_NAME.Core"
mkdir -p Models Interfaces Services

cd "../$SOLUTION_NAME.Infrastructure"
mkdir -p Data Services

cd ..

echo "✅ Done! Solution created at ./$SOLUTION_NAME"