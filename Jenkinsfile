pipeline {
  agent any
  environment {
    AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
    AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    AWS_DEFAULT_REGION    = 'ap-south-1'
  }
  stages {
    stage('Checkout') {
      steps { checkout scm }
    }
    stage('Terraform Init') {
      steps { sh 'terraform init -input=false' }
    }
    stage('Format Check') {
      steps { sh 'terraform fmt -check -recursive' }
    }
    stage('Validate') {
      steps { sh 'terraform validate' }
    }
    stage('Plan') {
      steps { sh 'terraform plan -input=false -out=tfplan' }
    }
    stage('Approval') {
      steps { input message: 'Review the plan above. Apply to AWS?', ok: 'Apply' }
    }
    stage('Apply') {
      steps { sh 'terraform apply -input=false tfplan' }
    }
    stage('Outputs') {
      steps { sh 'terraform output' }
    }
  }
}