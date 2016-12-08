FROM  jenkins
#  COPY plugins.txt /usr/share/jenkins/plugins.txt
#  RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
   USER root
   RUN apt-get update && apt-get install -y \
     openssh-server \
     default-jdk \
     maven 
