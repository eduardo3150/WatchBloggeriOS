import Foundation
import RealmSwift

class UserArticle: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var image: String? = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}
