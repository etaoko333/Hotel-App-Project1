**Automating CI/CD for a Hotel Web App: Deploy Seamlessly with AWS CodePipeline, CodeBuild, and CodeDeploy**
![image](https://github.com/user-attachments/assets/0a5f95ec-2c08-4002-83a9-3ddd01b58730)


![image](https://github.com/user-attachments/assets/6fa033d1-a1ac-4d4d-97fa-f0dc2ea2866d)


**Explanation of AWS CodeBuild, CodeDeploy, and CodePipeline**

1. **AWS CodePipeline**
**Purpose:** AWS CodePipeline is a fully managed Continuous Integration/Continuous Deployment (CI/CD) service that automates the build, test, and deployment phases of your release process.
**Importance:**
- Automates the entire software release pipeline.
- Integrates with multiple tools like GitHub, AWS CodeBuild, AWS CodeDeploy, Jenkins, etc.
- Ensures faster and more reliable deployments.
- Tracks every step of the process, ensuring transparency and control.

**Why It's Used in the Project:**
- CodePipeline orchestrates your CI/CD process by connecting GitHub as the source, CodeBuild for building the application, and CodeDeploy for deploying it on EC2.
- It automates the workflow, reducing manual effort and chances of errors.
- With GitHub integration, any changes pushed to the repository automatically trigger the pipeline.

**2. AWS CodeBuild
Purpose:**
AWS CodeBuild is a fully managed build service that compiles your source code, runs tests, and produces deployable artifacts.
**Importance:**
-Eliminates the need for provisioning and managing build servers.
- Scales automatically to handle multiple builds simultaneously.
- Supports multiple environments (e.g., Java, Python, Node.js, Docker).
- Allows running unit tests to catch errors early in the pipeline.

**Why It's Used in the Project:**
- CodeBuild compiles your application code and prepares it for deployment.
- Ensures the codebase is validated (via testing) before deployment.
- You don't need to manage build environments; CodeBuild handles it dynamically.

**3. AWS CodeDeploy
Purpose:**
AWS CodeDeploy automates the deployment of applications to various compute services like EC2, Lambda, or on-premises servers.
**Importance:**
- Simplifies deployments with zero downtime.
- Offers customizable deployment strategies (e.g., rolling, blue/green).
- Tracks the status of deployments and offers rollback options in case of issues.
- Ensures high availability during updates.

**Why It's Used in the Project:**
- CodeDeploy automates the deployment process to your EC2 instances, ensuring consistency.
- It handles deployment complexities like restarting services, copying files, and executing scripts.
- It reduces manual intervention, ensuring smoother, error-free deployments.

**How These Services Work Together In ThisProject**
- Source Stage (GitHub):
- CodePipeline monitors the specified GitHub repository branch for changes.
- When a new commit is pushed, the pipeline triggers.
- Build Stage (CodeBuild):
- CodeBuild pulls the source code from GitHub.
- It compiles the code, runs tests, and prepares the application for deployment (e.g., by creating a .zip or Docker image).

**2. Deploy Stage (CodeDeploy):**
- CodeDeploy fetches the deployable artifact from CodeBuild.
- It deploys the artifact to your EC2 instances, following your appspec.yml configuration.

**Why Use AWS Code Services for Your Project**
- Automation: AWS services automate the deployment pipeline, freeing you to focus on code rather than deployment processes.
- Scalability: As the application grows, CodeBuild, CodeDeploy, and CodePipeline scale seamlessly to handle increasing workloads.
- Integration with GitHub: Direct integration with GitHub ensures every code change is validated, tested, and deployed automatically.
- Reliability: The pipeline tracks every stage, ensuring accountability and offering rollback options in case of failures.
- Deployment Strategies: CodeDeploy supports advanced deployment methods like rolling updates or blue/green, ensuring minimal downtime.

**Overview of Steps**
- Set Up Your Environment
- Create EC2 Instance
- Install Docker on EC2
- Create a CodeBuild Project
- Create a CodeDeploy Application and Deployment Group
- Create a Dockerfile
- Create a CodePipeline
- Monitor and Test the Deployment

**Step 1: Setting Up Your Project in GitHub**
- Create a GitHub Repository:
- Log in to GitHub and create a new repository for your Hotel Web App
-Clone the repository from Github to your local machine: : https://github.com/etaoko333/Hotel-App-Project1.git
**git add . 
git commit -m "Initial commit for Hotel Web App" 
git push origin main**

**Step 2: Create a CodeBuild Project**
- Go to the CodeBuild service in the AWS Management Console.
- Click "Create build project."
- Configure the source provider:
- Select GitHub and connect your account to select the repository.
- Set the build environment:
- Image: Use a standard image (e.g., aws/codebuild/standard:5.0).
- Service Role: Create a new role or use an existing one.
- Create a buildspec.yml file in your GitHub repository

**2.1 Create an IAM Role for CodeBuild**
- Go to the IAM Console:
- Navigate to Roles > Create Role.
- Trusted Entity: Select AWS service and choose CodeBuild.
- Permissions: Attach the following policies:
- AWSCodeBuildAdminAccess
- AmazonSSMReadOnlyAccess (for accessing SSM parameters).

**Step 2.2: Configure AWS Systems Manager (SSM)**
- AWS SSM allows secure parameter management for sensitive data (e.g., database passwords, API keys).
- 2.3 Create Parameters in SSM
- Go to Systems Manager > Parameter Store.
- Click Create Parameter:
- Name: /hotel-web-app/db-password
- Type: SecureString
- Value: Set the database password (e.g., SuperSecret123)
-Repeat the same for other two parameters
- /cloud-cicd/docker-credentials/username: Your DockerHub Username
- /cloud-cicd/docker-credentials/password: Your DockerHub 
- /cloud-cicd/docker-registry/url: docker.io
- Now build your project.

![image](https://github.com/user-attachments/assets/f55abb28-aeea-4a73-8e8a-6446ac2f5098)


![image](https://github.com/user-attachments/assets/81b8afd0-da05-4c40-a66e-082412d87e00)

  
**Step 3: Create EC2 Instance**
- Go to the EC2 dashboard.
- Launch a new instance with the desired configuration (e.g., Amazon Linux).
- Select a security group that allows inbound traffic on ports 80 (HTTP) and 22 (SSH).

3.1 Attach IAM Role to EC2 Instances
G- o to the EC2 Console:
 CodeDeploy agent in Ec2 need to communicate with the CodeDeploy So create a role for it.
- → Navigate to IAM → Roles → Create role →Use case → EC2 → Next → "AWSCodeDeployFullAccess" → Name it → Create.
- Attach a role with the following permissions:AWSCodeDeployFullAccess
- Select the instance and choose Actions > Security > Modify IAM Role.

**3.2: Configure Codedeploy-agent on the Ec2 instances.**
- sudo apt update
- sudo apt install ruby-full
- sudo apt install wget
- wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install - change it to your own codedeploy arn
- +x ./install 
- sudo ./install auto 
- sudo systemctl status codedeploy-agent
- Install docker

![image](https://github.com/user-attachments/assets/ffd575a8-4bfd-4b0d-b5e9-90022c257d8d)


**Step 4: Create a CodeDeploy Application and Deployment Group**
- Create a CodeDeploy Application and Deployment Group
- Go to AWS CodeDeploy:
- In the AWS Management Console, search for "CodeDeploy" and click on
- Create an Application:
- Click on "Create application."
- Application name: Enter a name for your application
- Compute platform: Choose "EC2/On-Premises."
- Create a Deployment Group:
- Click "Create deployment group."
- Deployment group name: Give it a name.
- Service role: Create a service role for CodeDeploy.
- Environment configuration: Specify your EC2 instance by tags or instance ID.
- Click "Create deployment group."

![image](https://github.com/user-attachments/assets/169bcd47-4359-48e8-b05a-15f2f3c11f5a)


-Once the pipeline successfully runs, access your application via the EC2 instance's public IP address in a web browser. make sure you edit the security group to allow port 80<EC2_public_ip>:<host port>.

![image](https://github.com/user-attachments/assets/326e14d3-d8db-4ca7-a783-ae22ff61214a)


![image](https://github.com/user-attachments/assets/5c1337b3-9f2c-4574-a9b2-74891b6cbca0)



![image](https://github.com/user-attachments/assets/daea410a-a4f7-49ee-ab79-e2b22b6ed694)


**Step 5: Create a CodePipeline**
- Go to AWS CodePipeline:
- In the AWS Management Console, search for "CodePipeline" and click on it.
- Create a New Pipeline:
- Click "Create pipeline."
- Pipeline settings:
- Pipeline name: Enter a name for your pipeline.
- Source: Choose GitHub as the source provider.
- Connect your GitHub account and select the repository and branch.
- Build: Choose the CodeBuild project you created earlier.
- Deploy: Choose CodeDeploy and specify your application and deployment group.
- Review and create the pipeline.

**Step 6: Monitor and Test the Deployment**
- After setting everything up, monitor the pipeline for execution status in the AWS Management Console.
- Once the pipeline successfully runs, access your application via the EC2 instance's public IP address in a web browser.

**Conclusion**
In conclusion, building a robust CI/CD pipeline with AWS CodePipeline, CodeBuild, and CodeDeploy ensures efficient, automated, and seamless deployments for your Hotel Web App. By integrating with GitHub and leveraging the flexibility of AWS services, this pipeline provides a reliable framework for rapid development cycles, scalability, and high availability, empowering teams to focus on delivering value to users while maintaining application quality and performance.
