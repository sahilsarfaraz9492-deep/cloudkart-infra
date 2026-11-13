pipeline {
  agent any
  parameters {
    booleanParam(name: 'DESTROY', defaultValue: false, description: 'Tick to destroy all AWS resources')
  }
  environment {
    AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
    AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    AWS_DEFAULT_REGION    = 'us-east-1'
  }
  stages {
    stage('Checkout') {
      steps { checkout scm }
    }
    stage('Terraform Init') {
      steps { sh 'terraform init -input=false' }
    }
    stage('Format Check') {
      when { expression { !params.DESTROY } }
      steps { sh 'terraform fmt -check -recursive' }
    }
    stage('Validate') {
      when { expression { !params.DESTROY } }
      steps { sh 'terraform validate' }
    }
    stage('Plan') {
      when { expression { !params.DESTROY } }
      steps { sh 'terraform plan -input=false -out=tfplan' }
    }
    stage('Approval') {
      when { expression { !params.DESTROY } }
      steps { input message: 'Review the plan above. Apply to AWS?', ok: 'Apply' }
    }
    stage('Apply') {
      when { expression { !params.DESTROY } }
      steps { sh 'terraform apply -input=false tfplan' }
    }
    stage('Outputs') {
      when { expression { !params.DESTROY } }
      steps { sh 'terraform output' }
    }
    stage('Destroy Plan') {
      when { expression { params.DESTROY } }
      steps { sh 'terraform plan -destroy -input=false -out=tfdestroy' }
    }
    stage('Destroy Approval') {
      when { expression { params.DESTROY } }
      steps { input message: 'This DELETES the EC2 instance and ECR repos. Continue?', ok: 'Destroy' }
    }
    stage('Destroy') {
      when { expression { params.DESTROY } }
      steps { sh 'terraform apply -input=false tfdestroy' }
    }
  }
}