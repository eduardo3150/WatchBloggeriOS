import Foundation
import UIKit

class UserArticlesViewController: UIViewController {
    @IBOutlet weak var userArticlesTableView: UITableView!

    var viewModel: UserArticleViewModelProtocol?
    var segueHandler: SegueHandlerProtocol?

    let articlesTableManager = UserArticleTableManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(routeToAddArticle))

        navigationItem.rightBarButtonItem = addButton

        articlesTableManager.delegate = self
        userArticlesTableView.delegate = articlesTableManager
        userArticlesTableView.dataSource = articlesTableManager

        articlesTableManager.setUserArticlesData(articles: viewModel!.getAllStoredArticles())
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addEditArticleSegue",
           let nextScene = segue.destination as? AddEditArticleViewController,
           let viewType = sender as? AddEditArticleViewModel.ViewType {
            nextScene.configureView(with: viewType)
        }
    }

    @objc func routeToAddArticle() {
        segueHandler?.performSegue(
            withIdentifier: "addEditArticleSegue",
            viewController: self,
            sender: AddEditArticleViewModel.ViewType.ADD
        )
    }
}

extension UserArticlesViewController: UserArticleTableManagerDelegate {
    func didTapOnArticle(with articleId: String) {
        segueHandler?.performSegue(
            withIdentifier: "addEditArticleSegue",
            viewController: self,
            sender: AddEditArticleViewModel.ViewType.EDIT(id: articleId)
        )
    }
}
