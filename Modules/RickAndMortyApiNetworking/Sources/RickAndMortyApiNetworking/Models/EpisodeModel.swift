//
// EpisodeModel.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct EpisodeModel: Codable, JSONEncodable, Hashable, Identifiable {

    public var id: Int
    public var name: String
    public var airDate: String
    public var episode: String
    public var characters: [String]
    public var url: String
    public var created: String

    public init(id: Int, name: String, airDate: String, episode: String, characters: [String], url: String, created: String) {
        self.id = id
        self.name = name
        self.airDate = airDate
        self.episode = episode
        self.characters = characters
        self.url = url
        self.created = created
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case name
        case airDate = "air_date"
        case episode
        case characters
        case url
        case created
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(airDate, forKey: .airDate)
        try container.encode(episode, forKey: .episode)
        try container.encode(characters, forKey: .characters)
        try container.encode(url, forKey: .url)
        try container.encode(created, forKey: .created)
    }
}
