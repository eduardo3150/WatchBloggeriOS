import Foundation
import UIKit

class ArticlesTableDataManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    private var articlesList: [Article] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articlesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: RemoteArticlesCell.kCellIdentifier
        ) as? RemoteArticlesCell {
            let currentItem = articlesList[indexPath.row]
            cell.configure(article: currentItem)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    public func setArticlesData(articles: [Article]) {
        self.articlesList = articles
    }
}
