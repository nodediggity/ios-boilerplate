FASTLANE := bundle exec fastlane
XCODEPROJ := BoilerplateApp/BoilerplateApp.xcodeproj
SCHEME := CI_iOS
DEVICE := iPhone 17
OS_VERSION := 27.0

# Targets
.PHONY: help
help:
	@echo "Available tasks:"
	@echo "  make test           # Run unit tests on the $(DEVICE) simulator with iOS $(OS_VERSION)"
	@echo "  make build          # Build the project for the $(DEVICE) simulator with iOS $(OS_VERSION)"
	@echo "  make clean          # Clean the project"
	@echo "  make help           # Display this help message"
	@echo ""
	
.PHONY: test
test:
	xcodebuild -project $(XCODEPROJ) -scheme $(SCHEME) -sdk iphonesimulator -destination 'platform=iOS Simulator,name=$(DEVICE),OS=$(OS_VERSION)' OTHER_SWIFT_FLAGS="-D SKIP_FORMAT" clean build test
.PHONY: build
build:
	xcodebuild -project $(XCODEPROJ) -scheme $(SCHEME) -sdk iphonesimulator -destination 'platform=iOS Simulator,name=$(DEVICE),OS=$(OS_VERSION)' OTHER_SWIFT_FLAGS="-D SKIP_FORMAT" clean build

.PHONY: clean
clean:
	xcodebuild -project $(XCODEPROJ) -scheme $(SCHEME) clean

.DEFAULT_GOAL := help

