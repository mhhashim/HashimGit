#!/usr/bin/env groovy
// please look at: https://jenkins.io/doc/book/pipeline/syntax/
BranchName = env.BRANCH_NAME
Workspace = env.WORKSPACE
BuildNo = env.BUILD_NUMBER

String cron_string = BranchName == "develop" ? "H H(20-22) * * *" : BranchName =~ /continuous\/.*/ ? "H H(21-22) * * *" : ""

def MailRecipient = 'mhhashim@gmail.com, hashim.mh@philips.com '
def nodes = 'hashim'
def logLevel = 'true'


if (env.BRANCH_NAME == "develop") {
    nodes = nodes
}

pipeline {
    agent {
        node {
            label nodes
        }
    }
        parameters {
        booleanParam(name: 'RemoveWorkspace', defaultValue: false, description: 'Remove Workspace')
        booleanParam(name: 'isLogEnabled', defaultValue: false, description: 'Enable Log')
        choice(choices: 'Auto\nRelease\nDebug', description: 'What type of build to BranchNamebuild?', name: 'buildType')
    }
    triggers {
        cron(cron_string)
    }
    environment {
        TRIGGER_BY_TIMER          = 'false'
        BUILDDATE                 = sh(script: 'echo `date "+%d%m%Y_%H%M%S"`', returnStdout: true).trim()
        APPBASENAME               = "HashimGit"
        BUILD_NUMBER              = "${BuildNo}"
        BRANCHNAME                = "${BranchName}"
        BRANCH                    = "${BranchName}".replace('/', '-')
        GIT_VERSION               = sh(script: 'echo $GIT_COMMIT | cut -c1-7', returnStdout: true).trim()
        BUILD_SCHEME              = "${params.buildScheme}"
        SCHEME_NAME               = "BabyApp"
        VERSION                   = "2.6"
        APPLE_BUNDLE_VERSION      = "2.6"
        APPLE_SHORT_VERSION       = "0.202"
        BUILDTYPE                 = "${params.buildType}"
        APPNAME                   = ""
        NEW_XLS_NAME              = ""
        ARTIFACTORY_REPO          = ""
        DSYM_PATH                 = "AppStore.xcarchive/dSYMs"
        DSYM_PATH_adhoc           = "Adhoc.xcarchive/dSYMs"
        BUILD_FLAVOR              = getBuildType()
    }
    options {
        timestamps()
        buildDiscarder(logRotator(numToKeepStr: '24'))
            }
    stages {


        stage('Initialize') {
              steps {
                  updateBuildInfo()
                  updatePods(logLevel)
              }
          }

       stage('Build') {
            steps {
                 script {
                     build()
                }
            }
        }

        
        stage('Publish') {
            steps {
                publish()
            }
        }

    }

        post {
        always {
            notifyBuild(currentBuild.result)
        }
    }

}

def getBuildType() {

    if (env.BUILDTYPE != "Auto") {
        return env.BUILDTYPE
    }
    if (env.BRANCH_NAME == /develop.*/) {
        return "Adhoc"
    }
    if (env.BRANCH_NAME =~ /feature\/.*/) {
        return "Adhoc"
    }
    if (env.BRANCH_NAME =~ /release\/.*/) {
        return "Ent"
    }
    if (env.BRANCH_NAME =~ /master.*/) {
        return "Appstore"
    }
    return "Adhoc"
}


def updateBuildInfo() {
    BUILDTYPE = getBuildType()
    committerName = sh (script: "git show -s --format='%an' HEAD", returnStdout: true).trim()
    currentBuild.description = "Submitter: " + committerName + ";Node: ${env.NODE_NAME}"
    echo currentBuild.description
    BUILD_TRIGGER_BY = "${currentBuild.getBuildCauses()[0].shortDescription} / ${currentBuild.getBuildCauses()[0].userId}"
    echo "BUILD_TRIGGER_BY: ${BUILD_TRIGGER_BY}"    
    if (params.buildType == 'Auto') {
             currentBuild.displayName = "${env.BUILD_NUMBER}-${BUILDTYPE}-Auto-${BUILD_TRIGGER_BY}"
    } else {
         currentBuild.displayName = "${env.BUILD_NUMBER}-${BUILDTYPE}-${BUILD_TRIGGER_BY}"
    }
    echo currentBuild.displayName
}



def updatePods(String logLevel) {
 echo "----- installing pods start -----"
 echo "----- installing pods end -----"
}

def getBuildFlavor() {
 
    if (env.BRANCH_NAME == /develop.*/) {
        return "Release"
    }
    if (env.BRANCH_NAME =~ /feature\/.*/) {
        return "Release"
    }
    if (env.BRANCH_NAME =~ /release\/.*/) {
        return "AppStore"
    }
    return "Release"
}


def build() {
    echo "----- build start -----"
    verboseMode = "-quiet"
    if (isLogEnabled) {
        verboseMode = ""
    }
    echo verboseMode
    def shellcommand = '''#!/bin/bash -l
    xcodebuild $verboseMode | xcpretty -t; test ${PIPESTATUS[0]} -eq 0
    '''
    sh shellcommand
    
    echo "----- build end -----"
}

def publish() {
    echo "publish ipa"
}


def notifyBuild(String buildStatus = 'STARTED') {
 echo "notify result"
}




