import Foundation

class JSONFormatter {
    static let shared = JSONFormatter()
    
    func getPrettyJSON(_ dic: [String: Any]) -> String {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted) else {
            return "Unable to convert dictionary to json string"
        }
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            return "Unable to convert dictionary to json string"
        }
        return jsonString
    }
    
    func convertToDictionary<T: Codable>(value: T, encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any] {
        let data = try encoder.encode(value)
        let object = try JSONSerialization.jsonObject(with: data)
        if let json = object as? [String: Any] {
            return json
        }
        let context = DecodingError.Context(codingPath: [], debugDescription: "Deserialized object is not a dictionary")
        throw DecodingError.typeMismatch(type(of: object), context)
    }
}
