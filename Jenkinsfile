pipeline {
    environment {
    registry = 'mayhemmenich/docker-test'
    registryCredential = 'dockerhub'
  }
   agent none
   stages {
     stage('Fetch dependencies') {
       agent {
         docker 'circleci/node:9.3-stretch-browsers'
       }
       steps {
         sh 'yarn'
        stash includes: 'node_modules/', name: 'node_modules'
      }
    }
     stage('Lint') {
      agent {
        docker 'circleci/node:9.3-stretch-browsers'
      }
      steps {
        unstash 'node_modules'
        sh 'yarn lint'
      }
    }
    stage('Unit Test') {
      agent {
        docker 'circleci/node:9.3-stretch-browsers'
      }
      steps {
        unstash 'node_modules'
        sh 'yarn test --watch=false'
      }
    }
   /** stage('E2E Test') {
        agent {
            docker 'circleci/node:9.3-stretch-browsers'
        }
        steps {
            unstash 'node_modules'
            sh 'yarn e2e'
        }
    } **/
    stage('Compile') {
        agent {
            docker 'circleci/node:9.3-stretch-browsers'
        }
        steps {
            unstash 'node_modules'
            sh 'yarn build'
            stash includes: 'dist/', name: 'dist'
        }
    }

     stage('build') {
        steps {
            unstash 'dist'
            sh ''' 
            docker build -t nginx-server . 
            '''
        }
    }

    /**stage('Build and Push Docker Image') {
56      agent any
57      environment {
58        DOCKER_PUSH = credentials('dockerhub')
59      }
60      steps {
61        unstash 'dist'
62        sh 'docker build -t $DOCKER_PUSH_URL/frontend .'
63        sh 'docker login -u $DOCKER_PUSH_USR -p $DOCKER_PUSH_PSW $DOCKER_PUSH_URL'
64        sh 'docker push $DOCKER_PUSH_URL/frontend'
65      }
66    }**/
    }
}
