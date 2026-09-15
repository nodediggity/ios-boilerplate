// LocalizationTests.swift
// Created 24/06/2024.

import Foundation
import Testing
@testable import BoilerplateApp

struct LocalizationTests {
    @Test("Supported Localizations")
    func localizedStringsHaveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Localizable"
        let bundle = Bundle(for: AppDependencies.self)
        
        assertLocalizedKeyAndValuesExist(in: bundle, table)
    }
}

private extension LocalizationTests {
    typealias LocalizedBundle = (bundle: Bundle, localization: String)
    
    func assertLocalizedKeyAndValuesExist(
        in presentationBundle: Bundle,
        _ table: String,
        sourceLocation: SourceLocation = #_sourceLocation
    ) {
        let localizationBundles = allLocalizationBundles(
            in: presentationBundle,
            sourceLocation: sourceLocation
        )
        
        let localizedStringKeys = allLocalizedStringKeys(
            in: localizationBundles,
            table: table,
            sourceLocation: sourceLocation
        )
        
        for (bundle, localization) in localizationBundles {
            for key in localizedStringKeys {
                let localizedString = bundle.localizedString(
                    forKey: key,
                    value: nil,
                    table: table
                )
                
                if localizedString == key {
                    let language = Locale.current.localizedString(
                        forLanguageCode: localization
                    ) ?? ""
                    
                    Issue.record(
                        "Missing \(language) (\(localization)) localized string for key: '\(key)' in table: '\(table)'",
                        sourceLocation: sourceLocation
                    )
                }
            }
        }
    }
    
    func allLocalizationBundles(
        in bundle: Bundle,
        sourceLocation: SourceLocation = #_sourceLocation
    ) -> [LocalizedBundle] {
        bundle.localizations.compactMap { localization in
            guard
                let path = bundle.path(
                    forResource: localization,
                    ofType: "lproj"
                ),
                let localizedBundle = Bundle(path: path)
                    else {
                Issue.record(
                    "Couldn't find bundle for localization: \(localization)",
                    sourceLocation: sourceLocation
                )
                return nil
            }
            
            return (localizedBundle, localization)
        }
    }
    
    func allLocalizedStringKeys(
        in bundles: [LocalizedBundle],
        table: String,
        sourceLocation: SourceLocation = #_sourceLocation
    ) -> Set<String> {
        bundles.reduce(into: Set<String>()) { keys, current in
            guard
                let path = current.bundle.path(
                    forResource: table,
                    ofType: "strings"
                ),
                let strings = NSDictionary(contentsOfFile: path),
                let localizedKeys = strings.allKeys as? [String]
                    else {
                Issue.record(
                    "Couldn't load localized strings for localization: \(current.localization)",
                    sourceLocation: sourceLocation
                )
                return
            }
            
            keys.formUnion(localizedKeys)
        }
    }
}
