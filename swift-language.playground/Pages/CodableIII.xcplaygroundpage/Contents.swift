//: [CodableII](@previous)

import Foundation

// Encode and Decode Manually

struct Coordinate {
    var latitude: Double
    var longitude: Double
    var elevation: Double

    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case additionalInfo
    }

    enum AdditionalInfoKeys: String, CodingKey {
        case elevation
    }
}

extension Coordinate: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)

        let additionalInfo = try values.nestedContainer(keyedBy: AdditionalInfoKeys.self,
                                                        forKey: .additionalInfo)
        elevation = try additionalInfo.decode(Double.self, forKey: .elevation)
    }
}

extension Coordinate: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)

        var additionalInfo = container.nestedContainer(keyedBy: AdditionalInfoKeys.self,
                                                       forKey: .additionalInfo)
        try additionalInfo.encode(elevation, forKey: .elevation)
    }
}

let jsonString: String = """
{
    "latitude": 134.55,
    "longitude": 134.55,
    "additionalInfo": {
        "elevation": 234.56
    }
}
"""

let data = Data(jsonString.utf8)
let decoder = JSONDecoder()
let coordinate = try decoder.decode(Coordinate.self, from: data)

let encoder = JSONEncoder()
let dataEncoded = try encoder.encode(coordinate)
let jsonString2 = String(data: dataEncoded, encoding: .utf8)

//: [CodableIV](@next)
