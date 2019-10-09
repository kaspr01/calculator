pipeline {
     agent any
     //triggers {
          //pollSCM('* * * * *')
     //}
     stages {
          stage("Compile") {
               steps {
                    sh "./gradlew compileJava"
               }
          }
          stage("Unit test") {
               steps {
                    sh "./gradlew test"
               }
          }
          stage("Code coverage") {
               steps {
                    sh "./gradlew jacocoTestReport"
                    sh "./gradlew jacocoTestCoverageVerification"
               }
          }
          stage("Static code analysis") {
               steps {
                    sh "./gradlew checkstyleMain"
               }
          }
          stage("Package") {
               steps {
                    sh "./gradlew build"
               }
          }

          stage("Docker build") {
               steps {
                    //sh "docker build -t leszko/calculator:${env.BUILD_NUMBER} ."
                    echo "docker build -t leszko/calculator:${env.BUILD_NUMBER}  ."
                    sh "docker build -t leszko/calculator:${env.BUILD_NUMBER}  ."
               }
          }

          stage("Docker login") {
               steps {
                    //withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'docker-hub-credentials',
                      //         usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
                        // sh "docker login --username $USERNAME --password $PASSWORD"
                    sh "docker login -u prabhuks -p Docker12!"
                   // }
               }
          }

          stage("Docker push") {
               steps {
                     echo "docker push prabhuks/kaspr01:${env.BUILD_NUMBER}"
                    sh "docker push prabhuks/kaspr01:${env.BUILD_NUMBER}"
                   // sh "docker push leszko/calculator"
               }
          }

          stage("Update version") {
               steps {
                    sh "sed  -i 's/{{VERSION}}/${env.BUILD_NUMBER}/g' calculator.yaml"
               }
          }
          
          stage("Deploy to staging") {
               steps {
                    sh "kubectl config use-context staging"
                    sh "kubectl apply -f hazelcast.yaml"
                    sh "kubectl apply -f calculator.yaml"
               }
          }

          stage("Acceptance test") {
               steps {
                    sleep 60
                    sh "chmod +x acceptance-test.sh && ./acceptance-test.sh"
               }
          }

          //stage("Release") {
            //   steps {
              //      sh "kubectl config use-context production"
                //    sh "kubectl apply -f hazelcast.yaml"
                  //  sh "kubectl apply -f calculator.yaml"
               //}
          //}
          stage("Smoke test") {
              steps {
                  sleep 60
                  sh "chmod +x smoke-test.sh && ./smoke-test.sh"
              }
          }
     }
     
     post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This will run only if successful'
        }
        failure {
            echo 'This will run only if failed'
               mail bcc: 'prabhuprabhuks@yahoo.com', body: "<b>Example</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "ERROR CI: Project name -> ${env.JOB_NAME}", to: "prabhuprabhuks@yahoo.com";  
         }  
     }
  }
//}
//}
//
