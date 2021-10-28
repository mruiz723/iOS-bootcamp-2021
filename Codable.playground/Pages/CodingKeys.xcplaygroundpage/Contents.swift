import Foundation

// CodingKeys
struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
}

struct Landmark: Codable {
    var name: String
    var foundingYear: Int
    var location: Coordinate
    var vantagePoints: [Coordinate]

    enum CodingKeys: String, CodingKey {
        case name = "title"
        case foundingYear = "founding_date"

        case location
        case vantagePoints
    }
}

let jsonString: String = """
{
    "title": "Eiffel Tower",
    "founding_date": 1887,
    "location": {
        "latitude": 234.55,
        "longitude": 134.55
    },
    "vantagePoints": [
            {
                "latitude": 234.55,
                "longitude": 134.55
            },
            {
                "latitude": 134.55,
                "longitude": 34.55
            },
            {
                "latitude": 14.55,
                "longitude": 4.55
            }
    ]
}
"""

let data = Data(jsonString.utf8)
let decoder = JSONDecoder()
let coordinate = try decoder.decode(Landmark.self, from: data)

//: [Encoded&DecodedManually](@next)
