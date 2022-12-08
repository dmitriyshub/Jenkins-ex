pipeline {
    agent any

    options {
        buildDiscarder(logRotator(daysToKeepStr: '30'))
        disableConcurrentBuilds()
        timestamps()
    }

    stages {

        stage ("terraform fmt") {
            steps {
                sh ('terraform -chdir=./infra/terraform fmt')
            }
        }

        stage ("terraform init") {
            steps {
                sh ('terraform -chdir=./infra/terraform init')
            }
        }

        stage ("terraform plan") {
            steps {
                sh ('terraform -chdir=./infra/terraform plan')
            }
        }

        stage('Terraform action') {
            options {
                timeout(time: 15, unit: 'MINUTES')
            }

            steps {
                sh '''
                echo "Terraform action is --> ${action}"
                terraform -chdir=./infra/terraform ${action} --auto-approve
                '''
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