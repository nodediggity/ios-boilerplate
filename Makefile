XCODEPROJ := BoilerplateApp/BoilerplateApp.xcodeproj
SCHEME := CI_iOS
DEVICE := iPhone 17
OS_VERSION := 27.0

XCODEBUILD := xcodebuild \
	-project $(XCODEPROJ) \
	-scheme $(SCHEME) \
	-sdk iphonesimulator \
	-destination 'platform=iOS Simulator,name=$(DEVICE),OS=$(OS_VERSION)' \
	OTHER_SWIFT_FLAGS="-D SKIP_FORMAT"

.PHONY: help
help:
	@echo "Available tasks:"
	@echo "  make test           # Run unit tests"
	@echo "  make build          # Build the project"
	@echo "  make clean          # Clean the project"
	@echo "  make help           # Display this help message"

.PHONY: test
test:
	$(XCODEBUILD) test

.PHONY: build
build:
	$(XCODEBUILD) build

.PHONY: clean
clean:
	$(XCODEBUILD) clean

.DEFAULT_GOAL := help
