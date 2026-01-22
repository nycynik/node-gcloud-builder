pipeline {
    agent any
    environment {
        // where to store image when built.
        IMAGE_NAME = "ghcr.io/nycynik/node-gcloud-builder"
    }
    stages {
        stage('Checkout') {
            steps {
                // Pull the repo containing your Dockerfile
                checkout scm
            }
        }
        // stage('Login to GHCR') {
        //     steps {
        //         // This uses the credentials ID we created in step 2
        //         withCredentials([usernamePassword(credentialsId: 'github-ghcr-token',
        //                                          passwordVariable: 'GH_TOKEN',
        //                                          usernameVariable: 'GH_USER')]) {
        //             sh "echo \$GH_TOKEN | docker login ghcr.io -u \$GH_USER --password-stdin"
        //         }
        //     }
        // }
        stage('Build and Push') {
            steps {
                script {
                    // Build the image
                    // We tag it 'latest' and also with the Build ID for history
                    sh "docker build -t ${IMAGE_NAME}:latest -t ${IMAGE_NAME}:${env.BUILD_ID} ."

                    // // Push both tags
                    // sh "docker push ${IMAGE_NAME}:latest"
                    // sh "docker push ${IMAGE_NAME}:${env.BUILD_ID}"
                }
            }
        }
    }
    post {
        always {
            // Clean up the local image to save disk space on the Jenkins server
            // sh """
            //    docker rmi ${IMAGE_NAME}:latest || true
            //    docker rmi ${IMAGE_NAME}:${env.BUILD_ID} || true
            // """

            // Log out from GHCR
            //sh "docker logout ghcr.io"

            sh 'echo "Pipeline completed."'
        }
    }
}
