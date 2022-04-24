pipeline {
    agent {label 'Test'}
    options{
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '5', daysToKeepStr:'', numToKeepStr: '5')
        disableConcurrentBuilds()
    }
    environment{
        registry = "chash07/capstone_project2"
        registryCredential = "dockerhub"
    }

    stages{

        stage('Checkout'){
        steps{
            checkout([$class: 'GitSCM', branches: [[name: '*/master'], [name: '*/hostfix']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/chia5/capstone_project_2.git']]])
            echo "Git Repo Cloned Successfully"
            }
            
        }
    
        stage('Build Website'){
            steps{
                script{
                    dockerImage = docker.build registry + ":V$BUILD_NUMBER"
                    echo "Image Build Successfully"
                }

            }
        }

        stage('Test Website'){
            steps{
                echo "Testing"
            }
        }

        stage('Push To Dockerhub'){
            steps{
                script{
                    docker.withRegistry('', registryCredential){
                        dockerImage.push("V$BUILD_NUMBER")
                        echo "Image Pushed to Dockerhub"
                    }
                }

            }
        }

        stage('Push To Test Env'){
            agent {label 'Test'}
            steps{
                //sh "docker rm -f Apache2
                sh "docker run -d --name Apache2 -p 80:80 chash07/capstone_project2:V$BUILD_NUMBER"
                echo "Website Deployed on K8s"
            }
        }

        /*stage('Push To K8s Production'){
            agent {label 'K8s'}
            steps{
                echo "Website Deployed on K8s"
            }
        }*/
    }
    
}
