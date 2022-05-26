
ipeline {
    agent  any
    options {
        buildDiscarder(logRotator(numToKeepStr: '5', daysToKeepStr: '14'))
        timestamps()
    }
    environment {
        AWS_DEFAULT_REGION="us-east-1"
    }
    stages{
   
        stage ('install dependencies') {
            steps {
                script{
                  sh 'echo hello'
                  }
              }   
        }
        stage ('download data') {
            steps {
                dir("sagemaker/data"){
                    script{
                    sh 'echo hello'
                    }
                }
            }
        }
        stage ('train model') {
            steps {
                dir("sagemaker"){
                    script{
                       sh 'echo hello'
                    }
                }
            }
        }
        stage ('deploy model') {
             steps {
                dir("sagemaker"){
                    script{
                       sh 'echo hello'
                    }
                }
            }
        }
    }
    post { 
        always {
            script{
                   echo "build cleanup "
            }
        }
        success { 
              script {
                      sh '''
                       echo " build successfull "
                      '''
                }
        }
        failure {
            script {
                    
                      sh '''
                       echo " build failed "
                      '''
             }
        }
    }
    
}
