import Foundation
import RealmSwift

protocol UserArticleTemplate {
    var title: String { get set }
    var content: String { get set }
    var image: String? { get set }
}

class UserArticle: Object, UserArticleTemplate {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var image: String? = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}

class TemporalArticle: UserArticleTemplate {
    var title: String = ""
    var content: String = ""
    var image: String? = ""
}
