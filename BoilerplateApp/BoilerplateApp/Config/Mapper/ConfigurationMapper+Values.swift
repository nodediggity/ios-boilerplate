// ConfigurationMapper+Values.swift
// Created 22/06/2024.

import Foundation

extension ConfigurationMapper {
    static var secretKey: String {
        get throws {
            try map("SECRET_KEY")
        }
    }
}
