// ConfigurationMapper.swift
// Created 22/06/2024.

import Foundation

enum ConfigurationMapper {
    enum Error: Swift.Error {
        case missingKey(String)
        case invalidValue
    }

    static func map<T>(_ key: String, bundle: Bundle = .main) throws -> T where T: LosslessStringConvertible {
        guard let object = bundle.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey(key)
        }

        switch object {
        case let value as T: return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}
