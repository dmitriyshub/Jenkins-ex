pipeline {
    agent {
        docker {
            // TODO build & push your Jenkins agent image, place the URL here
            image '352708296901.dkr.ecr.us-west-2.amazonaws.com/dmitriyshub-agent:latest'
            args  '--user root -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        APP_ENV = "prod"
    }

    parameters {
        string(name: 'WORKER_IMAGE_NAME')
    }

    stages {
        stage('Worker Deploy') {
            steps {
                withCredentials([
                    file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')
                ]) {
                    sh '''
                    K8S_CONFIGS=infra/k8s

                    # replace placeholders in YAML k8s files
                    bash common/replaceInFile.sh $K8S_CONFIGS/worker.yaml APP_ENV $APP_ENV
                    bash common/replaceInFile.sh $K8S_CONFIGS/worker.yaml WORKER_IMAGE $WORKER_IMAGE_NAME

                    # apply the configurations to k8s cluster
                    kubectl apply --kubeconfig ${KUBECONFIG} -f $K8S_CONFIGS/worker.yaml
                    '''
                }
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