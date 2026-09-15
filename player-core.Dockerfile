FROM eclipse-temurin:25-jdk AS builder

WORKDIR /workspace

COPY . .

RUN ./mill player-core.build

FROM eclipse-temurin:25-jre

WORKDIR /app

COPY --from=builder /workspace/out/player-core/build.dest/out/ /app/

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/quarkus-run.jar"]
