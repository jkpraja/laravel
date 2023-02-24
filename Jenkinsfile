pipeline {
    agent {
        label 'linux'
    }

    environment {
        BUILD_NUMBER = sh (returnStdout: true, script: '''echo $BUILD_NUMBER''')
        //DOCKERHUB_CREDENTIALS = credentials('jkpraja-dockerhub')
    }

    stages {
        stage('Prepare .env') {
            steps {
                sh 'echo "\nBUILD_NUMBER=$(echo $BUILD_NUMBER)" >> .env'
            }
        }

        stage('Build Laravel') {
            steps {
                dir('blogx') {
                    sh 'docker build -f app.Dockerfile . -t laravel-app:$BUILD_NUMBER'
                    sh 'docker tag laravel-app:$BUILD_NUMBER jkpraja/laravel-app:$BUILD_NUMBER'
                    //sh 'echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS} --password-stdin'
                    sh 'docker push jkpraja/laravel-app:$BUILD_NUMBER'
                }
            }
        }

        stage('Deploy') {
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'dev-server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'sh ./runapp.sh', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '.env,compose.yaml,runapp.sh')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: true)])
            }
        }
    }
    //post {
    //    always {
    //        sh 'docker logout'
    //    }
    //}
}