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
        choice(choices: 'Auto\nRelease\nDebug', description: 'What type of build to BranchNamebuild?', name: 'buildType')
    }
    triggers {
        cron(cron_string)
    }
    environment {
        TRIGGER_BY_TIMER          = 'false'
        BUILDDATE                 = sh(script: 'echo `date "+%d%m%Y_%H%M%S"`', returnStdout: true).trim()
        APPBASENAME               = "Babyplus"
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
        BUILD_FLAVOR              = getBuildFlavor()
    }
    options {
        timestamps()
        buildDiscarder(logRotator(numToKeepStr: '24'))
            }
    stages {


        stage('Initialize') {
              steps {
                  updateBuildInfo()
                  updatePods(LogLevel)
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

def updateAutoConfig() {

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
    BUILDTYPE = updateAutoConfig()
    committerName = sh (script: "git show -s --format='%an' HEAD", returnStdout: true).trim()
    currentBuild.description = "Submitter: " + committerName + ";Node: ${env.NODE_NAME}"
    echo currentBuild.description

    if (params.buildType == 'AUTO') {
             currentBuild.displayName = "${env.BUILD_NUMBER}-${BUILDTYPE}-AUTO"
    } else {
         currentBuild.displayName = "${env.BUILD_NUMBER}-${BUILDTYPE}"
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
    echo "publish ipa"
}

def publish() {
    echo "publish ipa"
}


def notifyBuild(String buildStatus = 'STARTED') {
 echo "notify result"
}




