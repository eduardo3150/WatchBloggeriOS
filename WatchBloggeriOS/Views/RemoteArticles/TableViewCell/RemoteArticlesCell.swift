import UIKit
import SDWebImage

class RemoteArticlesCell: UITableViewCell {

    static let kCellIdentifier = "remoteArticlesCell"
    static let kNibName = "RemoteArticlesCell"

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(article: Article) {
        self.articleTitle.text = article.title
        self.articleDescription.text = article.description

        if let imageURL = article.urlToImage {
            articleImage.sd_setImage(with: URL(string: imageURL))
        }
    }
}
