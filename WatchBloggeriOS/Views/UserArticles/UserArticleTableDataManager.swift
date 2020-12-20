import Foundation
import UIKit

class UserArticleTableManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    private var userArticleList: [UserArticle] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userArticleList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "")
        let currentItem = userArticleList[indexPath.row]
        cell.textLabel?.text = currentItem.title
        cell.detailTextLabel?.text = currentItem.content
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    public func setUserArticlesData(articles: [UserArticle]) {
        self.userArticleList = articles
    }
}
