import Foundation
import Alamofire

protocol ApiProviderProtocol {
    func getWatchArticles(from: String) -> DataResponsePublisher<WatchArticleResponse>
}
