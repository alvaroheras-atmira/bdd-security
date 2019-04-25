# Use OpenJDK 8
FROM openjdk:8-jdk

#ENV URL "https:\/\/localhost:8099\/"
ENV TAGS "@ssl"
ENV TAGS_SKIP "~@skip"


RUN apt-get update && apt-get install -y python-pip && pip install sslyze 

# Set a sensible server directory.
#WORKDIR /home/bdd-security
WORKDIR .

# Add the directory
ADD . .

# run gradle
RUN ./gradlew buildIt

RUN sed -E -i "s/<baseUrl>.+<\/baseUrl>/<baseUrl>${URL}<\/baseUrl>/" config.xml


# Execute gradle tests
#CMD sed -E -i "s/<baseUrl>.+<\/baseUrl>/<baseUrl>${URL}<\/baseUrl>/" config.xml &&

CMD ./gradlew -Dcucumber.options="--tags ${TAGS} --tags ${TAGS_SKIP}"

