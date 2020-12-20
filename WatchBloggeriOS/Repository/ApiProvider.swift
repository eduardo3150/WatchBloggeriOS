import Foundation
import Alamofire

class ApiProvider: ApiProviderProtocol {

    static let BASE_URL = "https://newsapi.org/v2/"
    static let API_KEY = "fabd60c0bee54a74bd4622c1d0534c41"

    let apiKeyQueryItem = URLQueryItem(name: "apiKey", value: ApiProvider.API_KEY)

    func getWatchArticles(from: String) -> DataResponsePublisher<WatchArticleResponse> {
        return self.getWatchArticlesFullRequest(from: from)
    }

    func getWatchArticlesFullRequest(
        query: String = "watches",
        from: String,
        sortBy: String = "popularity",
        language: String = "en",
        pageSize: String = "20"
    ) -> DataResponsePublisher<WatchArticleResponse> {
        let queryItem = URLQueryItem(name: "q", value: query)
        let fromItem = URLQueryItem(name: "from", value: query)
        let sortByItem = URLQueryItem(name: "sortBy", value: query)
        let languageItem = URLQueryItem(name: "language", value: query)
        let pageSizeItem = URLQueryItem(name: "pageSize", value: query)

        let queryItems = [queryItem, fromItem, sortByItem, languageItem, pageSizeItem]
        var urlComps = URLComponents(string: ApiProvider.BASE_URL)!
        urlComps.queryItems = queryItems

        return AF.request(urlComps, method: .get)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: WatchArticleResponse.self)
    }
}
