pipeline {
    agent {
        docker {
            // TODO build & push your Jenkins agent image, place the URL here
            image '352708296901.dkr.ecr.us-west-2.amazonaws.com/dmitriyshub-agent:latest'
            args  '--user root -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        REGISTRY_URL = "352708296901.dkr.ecr.us-west-2.amazonaws.com"
        IMAGE_TAG = "0.0.$BUILD_NUMBER"
        IMAGE_NAME = "dmitriyshub-bot-dev"
        FULL_URL = "352708296901.dkr.ecr.us-west-2.amazonaws.com/dmitriyshub-bot-dev:0.0.$BUILD_NUMBER"
        REGION_NAME = "us-west-2"
        DOCKER_FILE_PATH = "services/bot/Dockerfile"
    }

    options {
        buildDiscarder(logRotator(daysToKeepStr: '30'))
        disableConcurrentBuilds()
        timestamps()
    }

    stages {
        stage('Build Bot Image') {
            options {
                timeout(time: 10, unit: 'MINUTES')
            }

            steps {
                sh '''
                aws ecr get-login-password --region $REGION_NAME | docker login --username AWS --password-stdin $REGISTRY_URL
                docker build -t $REGISTRY_URL/$IMAGE_NAME:$IMAGE_TAG -f $DOCKER_FILE_PATH .
                '''
            }
        }

        stage('Test Bot Image') {
            steps {
                withCredentials([string(credentialsId: 'snyk', variable: 'SNYK_TOKEN')]) {
                    sh '''
                    snyk container test $FULL_URL --severity-threshold=high --file=./$DOCKER_FILE_PATH
                    '''
               }
            }
        }

        stage('Push Bot Image') {
            options {
                timeout(time: 5, unit: 'MINUTES')
            }
            steps {
                sh '''
                docker push $REGISTRY_URL/$IMAGE_NAME:$IMAGE_TAG
                '''
            }
        }

        stage('Trigger Bot Deploy') {
            steps {
                build job: 'BotDeploy', wait: false, parameters: [
                    string(name: 'BOT_IMAGE_NAME', value: "${REGISTRY_URL}/${IMAGE_NAME}:${IMAGE_TAG}")
                ]
            }
        }

        stage('Clean WorkSpace') {
            steps {
                cleanWs()
            }
        }
    }

    post {
        always {
            emailext body: 'A Test EMail', recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']], subject: 'Test'
        }
    }
}