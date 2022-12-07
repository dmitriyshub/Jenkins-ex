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
        IMAGE_NAME = "dmitriyshub-bot-prod"
        REGION_NAME = "us-west-2"
        DOCKER_FILE_PATH = "services/bot/Dockerfile"
    }

    options {
        buildDiscarder(logRotator(daysToKeepStr: '30'))
        disableConcurrentBuilds()
        timestamps()
    }

    stages {
        stage('Build') {
            options {
                timeout(time: 12, unit: 'MINUTES')
            }

            steps {
                // TODO dev bot build stage
                sh '''
                aws ecr get-login-password --region $REGION_NAME | docker login --username AWS --password-stdin $REGISTRY_URL
                docker build -t $IMAGE_NAME:$IMAGE_TAG -f $DOCKER_FILE_PATH .
                docker tag $IMAGE_NAME:$IMAGE_TAG $REGISTRY_URL/$IMAGE_NAME:$IMAGE_TAG
                docker push $REGISTRY_URL/$IMAGE_NAME:$IMAGE_TAG
                '''
            }
        }

        stage('Trigger Deploy') {
            steps {
                build job: 'BotDeploy', wait: false, parameters: [
                    string(name: 'BOT_IMAGE_NAME', value: "${REGISTRY_URL}/${IMAGE_NAME}:${IMAGE_TAG}")
                ]
            }
        }
    }
}


