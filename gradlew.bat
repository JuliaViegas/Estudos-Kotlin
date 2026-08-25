@echo off
REM Minimal gradlew.bat fallback for Windows CI
SET GRADLE_VERSION=8.4.1
SET CACHE_DIR=%USERPROFILE%\.gradle-wrapper
IF NOT EXIST "%CACHE_DIR%\gradle-%GRADLE_VERSION%\bin\gradle.bat" (
  echo Gradle not found locally on Windows runner. Please install Gradle or add a proper wrapper.
  exit /b 1
)
"%CACHE_DIR%\gradle-%GRADLE_VERSION%\bin\gradle.bat" %*
