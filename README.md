// Add a note to README about Codemagic and keystore setup
# Estudos-Kotlin

Exercícios e estudos de Kotlin.

## CI / Codemagic

This repository contains a `codemagic.yaml` workflow to build a release APK. To sign the APK in Codemagic, add the following secure environment variables in the Codemagic UI:

- ANDROID_KEYSTORE_BASE64: base64-encoded .jks file
- ANDROID_KEYSTORE_PASSWORD
- ANDROID_KEYSTORE_ALIAS
- ANDROID_KEYSTORE_ALIAS_PASSWORD

The workflow decodes the keystore into `./keystores/keystore.jks` before running `./gradlew assembleRelease`.
