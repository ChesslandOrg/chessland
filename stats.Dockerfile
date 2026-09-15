FROM eclipse-temurin:25-jdk AS builder

WORKDIR /workspace

COPY . .

RUN ./mill stats.build

FROM eclipse-temurin:25-jre

WORKDIR /app

COPY --from=builder /workspace/out/stats/build.dest/out/ /app/

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/quarkus-run.jar"]