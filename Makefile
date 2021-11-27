all:


compile:
	@mvn compile
package:
	@mvn clean package -DskipTests=true
build-docker:
	@mvn clean package -DskipTests=true
	@docker build -t qute-quote-server .
run-docker-server:
	@docker run -p 5000:5000 qute-quote-server:latest


clean:
	@rm -rf server/libs/server
	@mvn clean


