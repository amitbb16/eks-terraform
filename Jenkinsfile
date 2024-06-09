pipeline {
    agent any
      parameters {
          booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
          choice(name: 'action', choices: ['apply', 'destroy'], description: 'Select the action to perform')
        }
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws_access_key_id')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
        AWS_DEFAULT_REGION = "us-west-2"
    }
    stages {
        stage('Checkout SCM DEV Branch'){
            steps{
                script{
                    checkout scmGit(branches: [[name: '*/DEV']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/amitbb16/eks-terraform.git']])
                }
            }
        }
        stage('Initializing Terraform'){
            steps{
                script{
                    dir('terraform'){
                        sh 'terraform init'
                    }
                }
            }
        }
        stage('Formatting Terraform Code'){
            steps{
                script{
                    dir('terraform'){
                        sh 'terraform fmt'
                    }
                }
            }
        }
        stage('Validating Terraform'){
            steps{
                script{
                    dir('terraform'){
                        sh 'terraform validate'
                    }
                }
            }
        }
        stage('Previewing the Infra using Terraform Plan'){
            steps{
                script{
                    dir('terraform'){
                        sh 'terraform plan -out tfplan'
                        sh 'terraform show -no-color tfplan > tfplan.txt'
                    }
                }
            }
        }
        stage('Apply / Destroy') {
            steps {
                script {
                    dir('terraform'){
                        if (params.action == 'apply') {
                            if (!params.autoApprove) {
                                def plan = readFile 'tfplan.txt'
                                input message: "Do you want to apply the plan?",
                                parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                            }

                            sh 'terraform ${action} -input=false tfplan'
                        } else if (params.action == 'destroy') {
                            sh 'terraform ${action} --auto-approve'
                        } else {
                            error "Invalid action selected. Please choose either 'apply' or 'destroy'."
                        }
                    }
                }
            }
        }
        stage('Adding eks cluster to Server') {
	        when {
         	    expression { params.action != 'destroy' }
    	    }
     	    steps{
                     sh 'aws eks update-kubeconfig --name eks-for-devlopers'
                     sh 'export KUBECONFIG="$(sudo cat /var/lib/jenkins/.kube/config)"'
            }
        }
        stage('Deploying Application') {
	        when {
         	    expression { params.action != 'destroy' }
    	    }
     	    steps{
                script{
                    dir('deployments') { 
                            sh 'kubectl apply -f frontend-deployment.yaml'
                            sh 'kubectl apply -f services.yaml'
                    }
                }
            }
        }
    }
}
