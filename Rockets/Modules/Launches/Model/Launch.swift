//
//  Launch.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 1/12/23.
//

import Foundation

// MARK: - Launch
struct Launch: Codable {
    let fairings: Fairings?
    let links: Links
    let staticFireDateUtc: String?
    let staticFireDateUnix: Int?
    let net: Bool
    let window: Int?
    let rocket: String
    let success: Bool?
    let failures: [Failure]
    let details: String?
    let crew: [String]
    let ships: [String]
    let capsules: [String]
    let payloads: [String]
    let launchpad: String?
    let flightNumber: Int
    let name: String
    let dateUtc: String
    let dateUnix: Int
    let dateLocal: Date
    let datePrecision: DatePrecision
    let upcoming: Bool
    let cores: [Core]
    let autoUpdate: Bool
    let tbd: Bool
    let launchLibraryId: String?
    let id: String
    
    func dateFormatted() -> String {
        return Date.format(
            self.dateUtc,
            from: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
            to: "d MMMM, YYYY"
        )
    }
    
}

extension Launch {
    
    struct Failure: Codable {
        let time: Int
        let altitude: Int?
        let reason: String
    }
    
    struct Core: Codable {
        let core: String?
        let flight: Int?
        let gridfins: Bool?
        let legs: Bool?
        let reused: Bool?
        let landingAttempt: Bool?
        let landingSuccess: Bool?
    }

    struct Fairings: Codable {
        let reused: Bool?
        let recoveryAttempt: Bool?
        let recovered: Bool?
        let ships: [String]
    }

    struct Links: Codable {
        let patch: Patch
        let flickr: Flickr
        let presskit: String?
        let webcast: String?
        let youtubeID: String?
        let article: String?
        let wikipedia: String?
    }

    struct Flickr: Codable {
        let original: [String]
    }

    struct Patch: Codable {
        let small: String?
        let large: String?
    }
    
    enum DatePrecision: String, Codable {
        case day = "day"
        case hour = "hour"
        case month = "month"
    }

}
