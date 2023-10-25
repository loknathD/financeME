FROM openjdk:17
COPY target/*.jar finance.jar
ENTRYPOINT [ "java","-jar","/finance.jar" ] 
