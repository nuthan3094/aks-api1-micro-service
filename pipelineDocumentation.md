# Technical Documentation: CI/CD Pipeline for .NET API Microservice Deployment in Azure Kubernetes Service (AKS)

## Overview

This document outlines the Jenkins pipeline developed for the automated deployment of a .NET API microservice in Azure Kubernetes Service (AKS), integrating with Azure Container Registry (ACR) for container management.

## Pipeline Structure

The pipeline is defined in a `Jenkinsfile` using Groovy syntax and is structured as follows:

### Environment Setup

- **Agent**: The pipeline runs on an agent specified as `dotnet-build-6`.
- **Environment Variables**:
  - `version`: Used to track the application version.
  - `registry`: Specifies the Azure Container Registry URL.
  - `framework`: Defines the .NET build framework.
- **Parameters**:
  - `service`: The name of the API service.
  - `helmenv`: Specifies the deployment environment (e.g., `npd01`, `npd02`).
  - `EastUs` and `WestUs`: Boolean flags to control the deployment region.

### Stages

#### Define Environment

Initializes the environment and sets the framework for the build.

#### Retrieve Branch Configuration

Checks out the latest commit from the specified branch in the API service repository and extracts the Git commit hash and version number from the `.csproj` file.

#### Nexus Configuration

Authenticates with Azure using service principal credentials and retrieves and configures NuGet package sources for the .NET build.

#### Build and Deploy

Consists of two sub-stages:

- **Build Docker Container**:
  - Builds the Docker container for the .NET API service.
  - Pushes the built image to the specified Azure Container Registry.
- **Deploy**:
  - Invokes the `deployChart` method to deploy the application in AKS.

### Deployment Method: `deployChart`

This method handles the deployment of deployment charts to AKS. It performs Azure login and sets AKS credentials. Based on the region specified (`EastUs` or `WestUs`), it applies the Kubernetes manifests (deployment, service, and ingress) from the `charts` directory.

## Key Components

- **CI/CD Pipeline**: Automates the entire process from code checkout to deployment in AKS.
- **Dockerfile**: Used for building the Docker container for the .NET API service.
- **Kubernetes Manifests**: Includes `deployment.yaml`, `Service.yaml`, and `Ingress.yaml` for orchestrating the service deployment in AKS.

- **Azure Integration**: Leverages Azure services including ACR for image registry and AKS for application deployment.

## Assumptions

The pipeline assumes the existence of an API repository with the necessary project files. The actual API source files are not included in this setup. The focus is on infrastructure and deployment automation.

## Security and Credentials Management

Azure service principal credentials are used for authentication. Credentials are securely managed within Jenkins and are referenced in the pipeline script.

## Usage

To use this pipeline, ensure that the Jenkins environment is properly configured with the necessary plugins and credentials. Update the `Jenkinsfile` with the appropriate repository URL, service name, and environment parameters.

## Conclusion

This CI/CD pipeline represents a comprehensive approach to automating the deployment of a .NET API microservice in AKS, showcasing proficiency in Jenkins pipeline development, Docker containerization, and Kubernetes orchestration.
