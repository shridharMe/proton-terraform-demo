pipeline {
    agent  any
    options {
        buildDiscarder(logRotator(numToKeepStr: '5', daysToKeepStr: '14'))
        timestamps()
    }
    environment {
        AWS_DEFAULT_REGION="us-east-2"
    }
    stages{
   
        stage ('terraform init') {
            steps {
                script{
                  sh 'terraform init'
                  }
              }   
        }
        stage ('terraform plan') {
            steps {
                dir("sagemaker"){
                    script{
                        sh 'terraform plan'
                    }
                }
            }
        }
        stage ('terraform apply') {
            when{
                expression {
                    env.GIT_BRANCH == 'master'
                }
            }
             steps {
                dir("sagemaker"){
                    script{
                     try{
                        sh 'terraform apply'
                        sh 'aws proton notify-resource-deployment-status-change --resource-arn "arn:aws:proton:us-east-2:753690273280:environment/vpc-primary" --status SUCCEEDED'
                     }catch(Exception e){
                        sh 'aws proton notify-resource-deployment-status-change --resource-arn "arn:aws:proton:us-east-2:753690273280:environment/vpc-primary" --status FAILED'
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
