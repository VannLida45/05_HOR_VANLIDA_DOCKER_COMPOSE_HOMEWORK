FROM gradle:8.14-jdk21 AS build

WORKDIR /app

COPY . .

RUN gradle build --no-daemon -x test --build-cache

FROM eclipse-temurin:21-jdk

WORKDIR /app

COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080

CMD ["java","-jar","app.jar"]