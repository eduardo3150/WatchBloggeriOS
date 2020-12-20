import Foundation
import Combine

protocol HomeViewModelProtocol {
    func getWatchArticles()
    var articlesPublished: Published<WatchArticleResponse>.Publisher { get }
}

class HomeViewModel: HomeViewModelProtocol {
    private let apiProvider: ApiProviderProtocol

    @Published private var articlesResponse = WatchArticleResponse(
        status: "",
        totalResults: 0,
        articles: []
    )

    var articlesPublished: Published<WatchArticleResponse>.Publisher { $articlesResponse }

    private var cancellables: Set<AnyCancellable> = []

    init(apiProvider: ApiProviderProtocol) {
        self.apiProvider = apiProvider
    }

    func getWatchArticles() {
         apiProvider
            .getWatchArticles(from: "2020-12-17")
            .result()
            .sink { [weak self] response in
                switch response {
                case .success(let value):
                    self?.articlesResponse = value
                case .failure(let error):
                    print(error)
                }
            }.store(in: &cancellables)
    }
}
