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

        stage('Bot Build') {
            options {
                timeout(time: 10, unit: 'MINUTES')
            }

            steps {
                // TODO dev bot build stage
                sh '''
                aws ecr get-login-password --region $REGION_NAME | docker login --username AWS --password-stdin $REGISTRY_URL
                docker build -t $REGISTRY_URL/$IMAGE_NAME:$IMAGE_TAG -f $DOCKER_FILE_PATH .
                docker push $REGISTRY_URL/$IMAGE_NAME:$IMAGE_TAG
                '''
            }
        }

        stage('Bot Test') {
            steps {
                withCredentials([string(credentialsId: 'snyk', variable: 'SNYK_TOKEN')]) {
                    sh '''
                    snyk container test $FULL_URL --severity-threshold=high --file=./$DOCKER_FILE_PATH
                    '''
               }
            }
        }

        stage('Trigger Bot Deploy') {
            steps {
                build job: 'BotDeploy', wait: false, parameters: [
                    string(name: 'BOT_IMAGE_NAME', value: "${REGISTRY_URL}/${IMAGE_NAME}:${IMAGE_TAG}")
                ]
            }
        }
    }
}