pipeline {
    agent any
    environment {
        PROJECT = "Daje-Plugin-Authorities"
        BUILD_DIR = "${PROJECT}/"
        DEPLOY_DIR = "/var/lib/jenkins/workspace/backend" // Target directory for deployment
        PATH = "/var/lib/jenkins/perl5/perlbrew/perls/perl-5.42.2/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', credentialsId: "${GIT_PWD}", url: "https://github.com/janeskil1525/${PROJECT}.git"
            }
        }
        stage('Verify perl') {
            steps {
                sh 'perl -v'
            }
        }
        stage('Build project') {
            steps {
                sh '/var/lib/jenkins/perl5/perlbrew/perls/perl-5.42.2/bin/minil install'
                sh '/var/lib/jenkins/perl5/perlbrew/perls/perl-5.42.2/bin/minil dist'
            }
        }
        stage('collect artifact') {
            steps {
                script {
                    //if (fileExists(BUILD_DIR)) {

                    def output_dir = "/var/lib/jenkins/workspace/backend/${PROJECT}"
                    echo output_dir
                    sh "rm -rf " + output_dir + " || true"
                    echo "🚀 Moving build to " + output_dir + "..."

                    // Create the deployment directory
                    sh "mkdir -p " + output_dir

                    // Copy build artifacts
                    sh "cp  *.tar.gz " + output_dir + "/"
                    echo "✅ Deployment complete."
                    //} else {
                    //error "❌ Build directory not found: ${BUILD_DIR}"
                    //}
                }
            }
        }
    }
    post {
        success {
            echo '✅ Build and Deployment Successful!'
        }
        failure {
            echo '❌ Build Failed!'
        }
    }
}
