pipeline {

    agent any

    stages {
        stage('checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/loknathD/financeME.git'
            }
        }
        stage ('build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage ('tests') {
            steps {
                publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/financeME/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
            }
        }
           stage ('build docker file') {
            steps {
                sh 'docker build -t loknathdas/financeme-v1:1.0 .'
            }
        }
         stage ('docker push image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'docker_password', usernameVariable: 'docker_username')]) {
                sh 'docker login -u ${docker_username} -p ${docker_password}'
                                  }
                sh 'docker push loknathdas/financeme-v1:1.0'
            }
        }
      } 

     } 
