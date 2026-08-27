# Builder
FROM alpine/java:22.0.2-jdk AS builder
WORKDIR /app

COPY .mvn .mvn
COPY pom.xml mvnw ./
RUN set -xe && \
	./mvnw dependency:go-offline -B

COPY src src
RUN set -xe && \
	./mvnw package -DskipTests -B && \
	mv target/*.jar target/app.jar
	

# Runner
FROM alpine/java:22.0.2-jre AS runner
WORKDIR /app

RUN set -xe && \
	apk add --no-cache bash curl

COPY wait-for-it.sh docker-entrypoint.sh ./

RUN set -xe && \
	chmod 555 wait-for-it.sh docker-entrypoint.sh
 
COPY --from=builder /app/target/app.jar /app/target/app.jar

ENV WAIT_SEC=120

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ./wait-for-it.sh ${POSTGRES_HOST}:${POSTGRES_PORT} -s -t ${WAIT_SEC} -- java -jar target/app.jar
