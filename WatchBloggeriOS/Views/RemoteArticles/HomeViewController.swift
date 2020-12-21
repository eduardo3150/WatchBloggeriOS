import UIKit
import Combine

class HomeViewController: UIViewController {
    @IBOutlet weak var articlesTableView: UITableView!

    var viewModel: HomeViewModelProtocol?
    var cancellables: Set<AnyCancellable> = []
    private let articlesDataManager = ArticlesTableDataManager()
    private let refreshControl = UIRefreshControl()
    private var articlesList: [Article] = []
    private var fetchesNextResults: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        refeshTableView(moreItems: false)

        navigationItem.title = "Watches articles"

        viewModel?
            .articlesPublished
            .sink(receiveValue: { [weak self] articleMain in
                guard let `self` = self else { return }
                self.articlesDataManager.setArticlesData(
                    articles: articleMain.articles,
                    fetchesNextResults: self.fetchesNextResults
                )
                self.articlesTableView.reloadData()
                self.refreshControl.endRefreshing()
                self.fetchesNextResults = false
            }).store(in: &cancellables)
    }

    private func setupTableView() {
        articlesTableView.delegate = articlesDataManager
        articlesTableView.dataSource = articlesDataManager

        articlesDataManager.delegate = self

        articlesTableView.register(
            UINib(
                nibName: RemoteArticlesCell.kNibName,
                bundle: nil
            ),
            forCellReuseIdentifier: RemoteArticlesCell.kCellIdentifier
        )
        articlesTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTableViewSelector), for: .valueChanged)
    }

    @objc func refreshTableViewSelector() {
        refeshTableView(moreItems: false)
    }

    private func refeshTableView(moreItems: Bool) {
        if !refreshControl.isRefreshing {
            refreshControl.programaticallyBeginRefreshing(in: articlesTableView)
        }
        viewModel?.getWatchArticles(with: moreItems)
    }
}

extension HomeViewController: ArticlesTableDataManagerDelegate {
    func loadMoreData() {
        self.fetchesNextResults = true
        self.refeshTableView(moreItems: true)
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: articlesTableView.bounds.width, height: CGFloat(44))

        self.articlesTableView.tableFooterView = spinner
        self.articlesTableView.tableFooterView?.isHidden = false
    }
}
