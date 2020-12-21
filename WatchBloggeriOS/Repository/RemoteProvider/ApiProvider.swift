import Foundation
import Alamofire

class ApiProvider: ApiProviderProtocol {

    static let BASE_URL = "https://newsapi.org/v2"
    static let API_KEY = "fabd60c0bee54a74bd4622c1d0534c41"

    let apiKeyQueryItem = URLQueryItem(name: "apiKey", value: ApiProvider.API_KEY)
    var page = 1

    func getWatchArticles(from: String, with moreData: Bool) -> DataResponsePublisher<WatchArticleResponse> {
        return self.getWatchArticlesFullRequest(from: from, moreData: moreData)
    }

    func getWatchArticlesFullRequest(
        query: String = "watches",
        from: String,
        sortBy: String = "popularity",
        language: String = "en",
        pageSize: String = "10",
        moreData: Bool
    ) -> DataResponsePublisher<WatchArticleResponse> {
        let queryItem = URLQueryItem(name: "q", value: query)
        let fromItem = URLQueryItem(name: "from", value: from)
        let sortByItem = URLQueryItem(name: "sortBy", value: sortBy)
        let languageItem = URLQueryItem(name: "language", value: language)
        let pageSizeItem = URLQueryItem(name: "pageSize", value: pageSize)

        if moreData {
            page += page
        } else {
            page = 1
        }
        let pageQueryItem = URLQueryItem(name: "page", value: String(page))
        let queryItems = [apiKeyQueryItem, queryItem, fromItem, sortByItem, languageItem, pageSizeItem, pageQueryItem]
        var urlComps = URLComponents(string: "\(ApiProvider.BASE_URL)/everything")!
        urlComps.queryItems = queryItems

        return AF.request(urlComps.url!, method: .get)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: WatchArticleResponse.self)
    }
}
