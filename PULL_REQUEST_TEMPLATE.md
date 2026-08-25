# Pull request template

This pull request includes:

- A single-screen Jetpack Compose counter (MainActivity + ContadorScreen)
- Material3 theme with custom colors
- Codemagic CI configuration (codemagic.yaml) and helper script
- app/build.gradle with Compose + Material3 dependencies

Notes:
- The decrement button is disabled when the counter is 0.
- To sign the release APK in Codemagic, set secure env vars: ANDROID_KEYSTORE_BASE64, ANDROID_KEYSTORE_PASSWORD, ANDROID_KEYSTORE_ALIAS, ANDROID_KEYSTORE_ALIAS_PASSWORD.

Please review and merge into main when ready.
