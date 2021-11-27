FROM debian:buster-slim
MAINTAINER Sinethemba <sluthang@student.wethinkcode.co.za>
RUN apt-get update
RUN apt-get install -y openjdk-11-jre

ADD server/libs/QuteQuoteServer.jar /srv/server/lib/QuteQuoteServer.jar
ADD QuteQuoteDB.db /srv/server/lib/QuteQuoteDB.db
ADD src /srv/src

WORKDIR /srv/server/lib
EXPOSE 5000

CMD ["java", "-jar", "QuteQuoteServer.jar"]