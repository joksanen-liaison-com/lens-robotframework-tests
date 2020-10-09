#!groovy
@Library('common')
import com.liaison.jenkins.visibility.Utilities
import com.liaison.jenkins.common.kubernetes.*
import com.liaison.jenkins.common.test.*

def utils = new Utilities()
def deployments = new Deployments()
def k8sDocker = new Docker()
def test = new Test()

def dockerImageName = "solutions/solution-ci-project-template-tests"
def dockerImageTag
def yaml

node {
    stage('Checkout') {
        timeout(5) {
            checkout scm
            env.VERSION = utils.runSh("sed -nE 's/##.*\\[([0-9]+\\.[0-9]+\\.[0-9]+)\\].*/\\1/p' CHANGELOG.md | head -n1")

            if (utils.isMasterBuild()) {
                dockerImageTag = env.VERSION
            } else {
                // Create a unique tag for each PR/non-master build because over-writing at master registry is not allowed.
                dockerImageTag = "${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
            }

            // Read test recipe yaml file from root of project.
            yaml = readYaml file: "TestRecipe.yaml"
        }
    }

    stage('Build Docker image for Robot tests') {
        k8sDocker.build(imageName: dockerImageName)
        milestone label: 'Docker image built', ordinal: 100

        k8sDocker.push(
                imageName: dockerImageName,
                imageTag: dockerImageTag
        )

        // Always publish to master registry
        k8sDocker.publish(
                imageToPublish: "${dockerImageName}:${dockerImageTag}",
                publishedImageName: dockerImageName,
                publishedImageTag: dockerImageTag
        )
    }
}

stage('Run map Robot tests in LD1-UAT') {
    if (utils.isMasterBuild()) {
        test.runTestSession(
                recipeYaml: yaml,
                name:       "Map-tests-UAT"
        )
    } else {
        test.runTestSession(
                recipeYaml: yaml,
                name:       "PR-map-tests-UAT"
        )
    }
}

stage('Run integration Robot tests in LD1-UAT') {
    if (utils.isMasterBuild()) {
        test.runTestSession(
                recipeYaml: yaml,
                name:       "Integration-tests-UAT"
        )
    } else {
        test.runTestSession(
                recipeYaml: yaml,
                name:       "PR-integration-tests-UAT"
        )
    }
}
