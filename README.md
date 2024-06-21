# ios-boilerplate

## About

---

 iOS boilerplate for building iOS apps using SwiftUI. 
 
 Includes essential components such as networking, navigation, unit tests, and CI/CD setup.
 

 ## Features

---

- [ ] Navigation
- [ ] Networking
- [ ] Auth
- [ ] Unit Tests
- [ ] Snapshot Tests
- [ ] Acceptance Tests
- [ ] Dev/Release Environment
- [ ] CI/CD
- [ ] AppStore


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