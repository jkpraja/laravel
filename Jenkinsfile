pipeline {
    agent {
        label 'linux'
    }

    environment {
        GIT_COMMIT_SHORT = sh (returnStdout: true, script: '''echo $GIT_COMMIT | head -c 7''')
        DOCKERHUB_CREDENTIALS = credentials('jkpraja-dockerhub')
    }

    stages {
        stage('Prepare .env') {
            steps {
                sh 'echo "\nGIT_COMMIT_SHORT=$(echo $GIT_COMMIT_SHORT)" >> .env'
            }
        }

        stage('Build Laravel') {
            steps {
                dir('blogx') {
                    sh 'docker build -f app.Dockerfile . -t laravel-app:latest'
                    sh 'docker tag laravel-app:latest jkpraja/laravel-app:latest'
                    //sh 'echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS} --password-stdin'
                    sh 'docker push jkpraja/laravel-app:latest'
                }
            }
        }

        stage('Deploy') {
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'dev-server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''sh ./runapp.sh''', execTimeout: 300000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '.env,compose.yaml,runapp.sh')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: true)])
            }
        }
    }
    //post {
    //    always {
    //        sh 'docker logout'
    //    }
    }
}