# Template
This repo is a template of how you can organize your deployment repo
# Deployment 6: React and Frontend Testing

## Purpose 

Purpose of this deployment is to utilize a Jenkins controller and two other agents(hosted on 3 different Amazon EC2s) to host a React build and run a cypress test. 

## Steps to replicate

1. Launch one Amazon Linux 2 that will be your Jenkins master/controller and name it appropriately and install Jenkins. 
2. Launch 2 Amazon Ubuntu servers, as these will be the two Jenkins agents. 
    - For Agent 1 set the inbound rules to ports 22 and 5000. 5000 is the port the react app will be served.
    - For Agent 2 set the inbound rules to port 22 for SSH. 
3. Sign into your Jenkins controller and download the nodejs, EC2, and Maven plugin. 
4. In your first Jenkins Agent install the following default-jre, git, nodejs, and npm
    ```
    $ sudo apt update
    $ sudo apt-get install nodejs npm
    $ sudo apt-get install default-jre
    ```
5. Now for the second Jenkins Agent install the following packages
    ```
    $ sudo apt update 
    $ sudo apt-get install default-jre git nodejs npm maven \
        libgtk2.0-0 libgtk3-0 libgbm-dev \
        libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb

    ```
6. In your Jenkins controller add the two agents through the Jenkins UI using an SSH connection. 
    - For usage select only build jobs with label expressions matching this node 
    - Select launch agents via SSH and add the appropriate credentials correlating with your EC2 agents
    - I labeled my respective nodes/agents AgentOne and AgentTwo
    - Make sure connection is established.
7. Create a new Multibranch pipeline and name it what you wish. 
8. For branch source select Github and add your github credentials and select this repo or your own repo. 
9. For build configuration select by Jenkinsfile.
10. Now for the pipeline add the following to your Jenkinsfile. 
```
pipeline {
  agent{

    label 'Agent One'

  }
  triggers {
    pollSCM('')
  }
  stages {
    stage ('Build') {
      
      steps {
        sh 'rm -rf ./kura_test_repo/cypress2'
        dir('./kura_test_repo'){
          sh '''
            npm install
            npm run build
            sudo npm install -g serve
            serve -s build &
            '''
        } 
        
      }
    }
    stage ('Test') {
      agent {
        label 'Agent Two'
      }
      steps {
        dir('./kura_test_repo'){
          sh '''
            npm install cypress
            npm install mocha
            npx cypress run --spec ./cypress/integration/test.spec.js
            '''
        }

      }
      
      post {
        always {
           dir('./kura_test_repo'){
            junit 'results/cypress-report.xml'
           }
        }
      }
    }
  }
}
```
11. Lastly change the test.spec.js file in ./kura_test_repo/cypress/integration to point to the ip address of Agent 1. 
12. Now schedule a build and run it.
13. To find the screen shots, SSH into the agent which runs the cypress testing and locate the cypress folder.
