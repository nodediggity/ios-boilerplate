# ios-boilerplate

![ci workflow](https://github.com/nodediggity/ios-boilerplate/actions/workflows/CI-iOS.yml/badge.svg)

## About

---

 iOS boilerplate for building iOS apps using SwiftUI. 
 
 Includes essential components such as networking, navigation, unit tests, and CI/CD setup.
 

 ## Features

---

- [x] Navigation
- [x] Networking
- [x] Formatting
- [x] Localisation
- [x] Unit Tests
- [x] Snapshot Tests
- [ ] UI Tests
- [x] Dev/Release Environment
- [x] CI/CD
- [ ] AppStore


## Dependencies

---

- Xcode 15.4.0
- Swift 5
- Minimum iOS version 17.5


## Environment Variables

---

### Config

Environment variables should be added [here](/BoilerplateApp/BoilerplateApp/Config/Config.xcconfig) for debug and release builds.

- `APP_DISPLAY_NAME`
- `APP_ICON_NAME`

### Secrets

Secrets are injected during the build process within the CI pipeline.

When running the project locally a copy of the secrets file should be configured [here](/BoilerplateApp/BoilerplateApp/Config/Config/Secrets.xcconfig).

- `MY_SECRET_VALUE`

The `Secrets.xcconfig` file is excluded from source control - updates should be base64 encoded and replace the CI environment variable.

This can be encoded using the openssl base64 command.

```
$ openssl base64 -in Secrets.xcconfig | tr -d "\n" | pbcopy;
```


## Getting started

---

```sh
# fork it on GitHub + clone your fork
git clone https://github.com/YOUR_USERNAME/ios-boilerplate.git
cd ios-boilerplate

# Make it your own
chmod +x rename.sh
./rename.sh NEW_NAME # Replace NEW_NAME with the desired name for your project
```


## Commit messages

---

Commit message should adhere to the [`Conventional Commits`](https://www.conventionalcommits.org/en/v1.0.0/) style and be structured as follows:

Format: `<type>(<scope>): <subject>`

`<scope>` is optional

### Example

```
feat: add something new
^--^  ^---------------^
|     |
|     +-> Summary in present tense.
|
+-------> Type: chore, docs, feat, fix, refactor, style, or test.
```

More Examples:

- `feat`: (new feature for the user, not a new feature for build script)
- `fix`: (bug fix for the user, not a fix to a build script)
- `docs`: (changes to the documentation)
- `style`: (formatting, missing semi colons, etc; no production code change)
- `refactor`: (refactoring production code, eg. renaming a variable)
- `test`: (adding missing tests, refactoring tests; no production code change)
- `chore`: (updating grunt tasks etc; no production code change)


## Code and Linting

---

[SwiftFormat](https://github.com/nicklockwood/SwiftFormat) executes on builds ensuring consistently formatted code.