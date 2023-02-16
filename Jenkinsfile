pipeline {
    agent any

    environment {
        GIT_COMMIT_SHORT = sh (returnStdout: true, script: '''echo $GIT_COMMIT | head -c 7''')
    }

    stages {
        stage('Prepare .env') {
            steps {
                sh 'echo GIT_COMMIT_SHORT=$(echo $GIT_COMMIT_SHORT) >> .env'
            }
        }

        stage('Build Laravel') {
            //environment {
            //    DB_HOST = credentials("mysql")
            //    DB_DATABASE = credentials("blogx")
            //    DB_USERNAME = credentials("blogx")
            //    DB_PASSWORD = credentials("adminadmin1")
            //}
            steps {
                //sh 'php --version'
                //sh 'composer install'
                //sh 'cp .env.example .env'
                //sh './vendor/bin/sail up'
                //sh 'php artisan key:generate'
                //migrate database
                //sh 'php artisan migrate'
                //deploy app
                //sh 'php artisan serve'
                dir('blogx') {
                    sh 'docker build . -t laravel-app:$GIT_COMMIT_SHORT'
                    sh 'docker tag laravel-app:$GIT_COMMIT_SHORT jkpraja/laravel-app:$GIT_COMMIT_SHORT'
                    sh 'docker push jkpraja/laravel-app:$GIT_COMMIT_SHORT'
                }
            }
        }

        stage('Deploy') {
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'remote-server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''docker compose up -d''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '.env,docker-compose.yml')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
    }
}