pipeline {
    agent { docker { image 'python:3.9' } }

    stages {
        stage('build model serving') {
            when {changeset "model_serving/**" }

            steps {
                echo 'Building model serving..'
                sh 'cd model_serving && make build_image'
            }
        }

        stage('test model serving') {
            when {changeset "model_serving/**" }

            steps {
                echo 'Testing model serving..' // (1)
            }
        }

        stage('deploy model serving') {
            parallel { // (2)
                stage('batch serving pipeline') {
                    when {changeset "model_serving/**" }

                    steps {
                        sh 'cd model_serving && make deploy_dags'
                    }
                }

                stage('online serving API') {
                    when {changeset "model_serving/**" }

                    steps {
                        sh 'cd model_serving && make compose_up'
                    }
                }
            }
        }
    }
}