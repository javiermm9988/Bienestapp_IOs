import Foundation

class App {
    
    var id: Int
    var name: String
    var icon: String
    var use: Int
    
    init(json: [String: Any]) {
        id = json["id"] as? Int ?? 0
        name = json["name"] as? String ?? ""
        icon = json["icon"] as? String ?? ""
        use = json["use"] as? Int ?? 0
    }
}
