# Gradle wrapper

This repository includes a robust `gradlew` script that downloads a Gradle distribution at runtime (see root `gradlew`).

The standard Gradle wrapper JAR (`gradle/wrapper/gradle-wrapper.jar`) is not included in this commit. If you prefer to use the official Gradle wrapper, generate it locally and push the generated files:

1. Ensure you have Gradle installed locally.
2. From the project root on branch `add/contador-screen` run:

   gradle wrapper --gradle-version 8.4.1

3. Then add and push the generated files:

   git add gradlew gradlew.bat gradle/wrapper/gradle-wrapper.jar gradle/wrapper/gradle-wrapper.properties
   git update-index --add --chmod=+x gradlew
   git commit -m "Add Gradle wrapper"
   git push origin add/contador-screen

Alternatively, continue using the provided `gradlew` downloader script (already committed) which will download Gradle at CI runtime. If CI environment blocks downloads, please generate and push the standard wrapper as above.
