pipeline{
	agent any
	options{
        buildDiscarder(logRotator(numToKeepStr: '5', daysToKeepStr: '5'))
        timestamps()
    }
	stages{
		stage('Building image') {
			steps{
				script{
					docker.withRegistry('','dockerhub') {
						def myImage = docker.build("jcivitell/garrysmod:${env.BUILD_ID}")
						myImage.push()
					}
				}
			}
		}
	}
	post{
	    cleanup{
            cleanWs()
        }
	}
}
