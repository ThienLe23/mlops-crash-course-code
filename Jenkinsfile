def user_id
def group_id
node {
  user_id = sh(returnStdout: true, script: 'id -u').trim()
  group_id = sh(returnStdout: true, script: 'id -g').trim()
}

pipeline {
    agent { 
        docker { 
            image 'python:3.9' 
            args '-v /var/run/docker.sock:/var/run/docker.sock\
             -v /usr/local/bin/docker:/usr/local/bin/docker\
             --privileged true\
             --user root'
        } 
    }

    stages {
        stage('build data pipeline') {
            when {changeset "data_pipeline/**" }

            steps {
                echo 'Building data pipeline..'
                sh 'make build_image'
            }
        }

        stage('test data pipeline') {
            when {changeset "data_pipeline/**" }

            steps {
                echo 'Testing data pipeline..' 
            }
        }

        stage('deploy data pipeline') {
            when {changeset "data_pipeline/**" }

            steps {
                sh 'make deploy_dags'
            }
        }
    }
}
