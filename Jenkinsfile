pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "tawa123/capstone-app"
        DOCKER_TAG   = "${GIT_COMMIT[0..6]}"
        PATH         = "/usr/local/bin:/opt/homebrew/bin:${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Run tests') {
            steps {
                sh '''
                    python3 -m venv venv
                    source venv/bin/activate
                    pip install -r app/requirements.txt
                    cd app && python3 -m pytest tests/ -v
                '''
            }
        }

        stage('Build and push Docker image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker buildx build --platform linux/amd64 \
                          -t tawa123/capstone-app:${DOCKER_TAG} \
                          -t tawa123/capstone-app:latest \
                          --push .
                    '''
                }
            }
        }

        stage('Provision with Terraform') {
            steps {
                dir('terraform/environments/staging') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Deploy with Ansible') {
            steps {
                dir('ansible') {
                    sh "ansible-playbook -i inventory.ini playbook.yml -e docker_tag=${DOCKER_TAG}"
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline succeeded - capstone app is live at http://3.209.56.172/health"
        }
        failure {
            echo "Pipeline failed - check logs above"
        }
    }
}
