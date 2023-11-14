# Test Framework README

## Overview

This repository contains a comprehensive test framework designed for testing the Parabank web application. The framework is Dockerized, allowing for easy setup and execution of tests in a controlled environment.

## Prerequisites

Before running the tests, ensure you have the following prerequisites installed on your system:

- Docker
- Ruby `3.2.1`
- Bundler

## Docker Setup

The `docker-compose.yml` file defines two services: `webapp` and `tests`. The `webapp` service runs the Parabank application, exposing ports 8080, 61616, and 9001. The `tests` service builds the Docker image using the specified `Dockerfile` and depends on the `webapp` service. Test reports are stored in the `./reports` directory.

To set up the Docker environment, run:

```bash
docker-compose up
```
This will launch the Parabank application and execute the test suite within the Docker container.

## Dockerfile
The Dockerfile sets up the Ruby 3.2.1 runtime and installs necessary dependencies for running tests, including Chromium and the corresponding driver. The working directory is set to /usr/src/parabank, where the necessary files are copied, and Ruby dependencies are installed using Bundler. The entry point is configured to run the Cucumber tests.

## Environment Configuration
The .env file is used to configure the platform for test execution. Currently, it is set to host.docker.internal. Adjust this file as needed for your testing environment.

## Project Structure
The main project structure is organized as follows:

- `features/`: Contains Gherkin feature files.
- `features/step_definitions/`: Holds the step definitions corresponding to the Gherkin scenarios.
- `features/support/`: Contains support files including hooks, env.rb, and utility files.
- `pages/`: Directory for page object models or related files.
- `reports/`: Directory where test reports are generated.

## Running Tests in Docker container
Once the Docker environment is set up, execute the tests by running:

```bash
docker-compose run tests
```

## Running Tests in locally

Change `PLATFORM` value in `config/.env` to `localhost` or execute with the next command:
```bash
PLATFORM=localhost cucumber features/
```
Test results will be available in the ./reports directory.