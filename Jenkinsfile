pipeline {
    agent any

    environment {
        GIT_COMMIT_SHORT = sh (returnStdout: true, script: '''echo $GIT_COMMIT | head -c 7''')
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
                    sh 'docker push jkpraja/laravel-app:latest'
                }
            }
        }

        stage('Deploy') {
            steps {
                //sshPublisher(publishers: [sshPublisherDesc(configName: 'remote-server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''docker compose up -d
                //sleep 200
                //docker exec laravel-app php artisan key:generate
                //docker exec laravel-app php artisan migrate
                //docker exec laravel-app php artisan serve --host=0.0.0.0''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '.env,compose.yaml,runapp.sh')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                sshPublisher(publishers: [sshPublisherDesc(configName: 'remote-server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''sh ./runapp.sh''', execTimeout: 300000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '.env,compose.yaml,runapp.sh')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: true)])
            }
        }
    }
}