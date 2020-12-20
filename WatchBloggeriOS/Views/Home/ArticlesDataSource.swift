import Foundation
import UIKit

class ArticlesDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    private var articlesList: [Article] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articlesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "")
        let currentItem = articlesList[indexPath.row]
        cell.textLabel?.text = currentItem.title
        cell.detailTextLabel?.text = currentItem.author
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    public func setArticlesData(articles: [Article]) {
        self.articlesList = articles
    }
}
