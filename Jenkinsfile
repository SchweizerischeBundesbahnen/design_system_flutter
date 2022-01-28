#!/usr/bin/env groovy

pipeline {
    agent {
        label 'flutter-fvm'
    }

    stages {
        stage('golden test') {
            steps {
                sh 'fvm install'
                sh 'fvm flutter pub get'
                sh 'fvm flutter test'
            }
        }
    }
}
