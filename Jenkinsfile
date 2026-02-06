pipeline {
    agent {
        docker {
            // Menggunakan Docker image dengan Flutter SDK
            // Opsi 1: Gunakan image Flutter resmi dari community
            image 'ghcr.io/cirruslabs/flutter:stable'
            
            // Opsi 2: Jika Anda membuat custom image, gunakan:
            // image 'your-registry/flutter-jenkins:latest'
            
            // Mount cache untuk mempercepat build berikutnya
            args '-v flutter-pub-cache:/root/.pub-cache'
        }
    }
    
    environment {
        // Konfigurasi build
        BUILD_OUTPUT_DIR = 'build/web'
        ARTIFACT_NAME = 'flutter-web-build'
        
        // Disable analytics
        FLUTTER_SUPPRESS_ANALYTICS = 'true'
        PUB_CACHE = '/root/.pub-cache'
    }
    
    options {
        // Timeout untuk seluruh pipeline
        timeout(time: 30, unit: 'MINUTES')
        
        // Hapus build lama, simpan hanya 10 build terakhir
        buildDiscarder(logRotator(numToKeepStr: '10'))
        
        // Tampilkan timestamp di log
        timestamps()
        
        // Disable concurrent builds
        disableConcurrentBuilds()
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo '📥 Checking out source code...'
                checkout scm
            }
        }
        
        stage('Setup Flutter') {
            steps {
                echo '🔧 Verifying Flutter environment...'
                sh '''
                    flutter --version
                    flutter doctor -v
                    flutter config --enable-web
                '''
            }
        }
        
        stage('Get Dependencies') {
            steps {
                echo '📦 Getting Flutter dependencies...'
                sh '''
                    flutter pub get
                '''
            }
        }
        
        stage('Analyze Code') {
            steps {
                echo '🔍 Analyzing Dart code...'
                sh '''
                    flutter analyze --no-fatal-infos --no-fatal-warnings || true
                '''
            }
        }
        
        stage('Run Tests') {
            steps {
                echo '🧪 Running tests...'
                sh '''
                    flutter test --coverage || true
                '''
            }
            post {
                always {
                    // Publish test results jika ada
                    junit allowEmptyResults: true, testResults: '**/test-results.xml'
                }
            }
        }
        
        stage('Build Web') {
            steps {
                echo '🏗️ Building Flutter Web application...'
                sh '''
                    flutter build web --release --base-href "/"
                '''
            }
        }
        
        stage('Archive Artifacts') {
            steps {
                echo '📁 Archiving build artifacts...'
                // Compress build output
                sh '''
                    cd build/web
                    tar -czvf ../../${ARTIFACT_NAME}-${BUILD_NUMBER}.tar.gz .
                '''
                
                // Archive sebagai Jenkins artifact
                archiveArtifacts artifacts: "${ARTIFACT_NAME}-${BUILD_NUMBER}.tar.gz", 
                                 fingerprint: true,
                                 onlyIfSuccessful: true
            }
        }
    }
    
    post {
        success {
            echo '✅ Build completed successfully !'
            echo "📦 Artifact: ${ARTIFACT_NAME}-${BUILD_NUMBER}.tar.gz"
        }
        failure {
            echo '❌ Build failed!'
        }
        cleanup {
            echo '🧹 Cleaning up workspace...'
            cleanWs(cleanWhenNotBuilt: false,
                    deleteDirs: true,
                    disableDeferredWipeout: true,
                    notFailBuild: true)
        }
    }
}
