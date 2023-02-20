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
                    sh 'docker build -f app.Dockerfile . -t laravel-app:latest'
                    sh 'docker tag laravel-app:latest jkpraja/laravel-app:latest'
                    sh 'docker push jkpraja/laravel-app:latest'
                }
            }
        }

        //stage('Build Webserver') {
        //    steps {
        //        dir('blogx') {
        //            sh 'docker build -f web-server.Dockerfile . -t laravel-server:latest'
        //            sh 'docker tag laravel-server:latest jkpraja/laravel-server:latest'
        //            sh 'docker push jkpraja/laravel-server:latest'
        //        }
        //    }
        //}

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