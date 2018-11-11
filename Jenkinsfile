pipeline {
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
    }
}
