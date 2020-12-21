import Foundation
import UIKit

protocol ArticlesTableDataManagerDelegate: class {
    func loadMoreData()
}

class ArticlesTableDataManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    private var articlesList: [Article] = []
    weak var delegate: ArticlesTableDataManagerDelegate?

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

    public func setArticlesData(articles: [Article], fetchesNextResults: Bool) {
        if fetchesNextResults {
            self.articlesList.append(contentsOf: articles)
        } else {
            self.articlesList = articles
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        if currentOffset > 0 && maximumOffset - currentOffset <= 10.0 {
                print("load more stuff")
            delegate?.loadMoreData()
        }
    }
}
