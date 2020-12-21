import Foundation
import Alamofire

protocol ApiProviderProtocol {
    func getWatchArticles(from: String, with moreData: Bool) -> DataResponsePublisher<WatchArticleResponse>
}
