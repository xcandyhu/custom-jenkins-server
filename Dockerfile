FROM jenkins/jenkins:2.440.3-jdk17
USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
# Install Node.js and npm
RUN apt-get install -y nodejs npm awscli
# Use npm to intall semver and aws-cdk
RUN npm install -g semver
RUN npm install -g aws-cdk
# Install jenkins plugins
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow \
pipeline-aws cloudbees-folder antisamy-markup-formatter \
build-timeout credentials-binding timestamper gradle git \
github-branch-source pipeline-github-lib pipeline-stage-view \
workflow-aggregator github ssh-slaves matrix-auth pam-auth \
ldap email-ext mailer dark-theme ws-cleanup pipeline-utility-steps"