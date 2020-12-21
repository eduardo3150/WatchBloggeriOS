import Foundation
import UIKit

class AddEditArticleViewController: UIViewController {
    @IBOutlet weak var articleTitle: UITextField!
    @IBOutlet weak var articleContent: UITextView!
    @IBOutlet weak var placeholderHelper: UILabel!
    @IBOutlet weak var actionOnArticleContainer: UIStackView!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!

    var viewModel: AddEditArticleViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        let saveArticleButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(saveArticle)
        )
        navigationItem.rightBarButtonItem = saveArticleButton
        disableSaveButton()
        articleContent.delegate = self
        articleTitle.delegate = self
        viewModel?.getViewTypeConfiguration { [weak self] userArticle in
            guard let userArticle = userArticle,
                  let `self` = self else { return }
            self.articleTitle.text = userArticle.title
            self.articleContent.text = userArticle.content
            self.placeholderHelper.isHidden = true
            self.makeViewOnly()
        }
    }

    @IBAction func editArticle(_ sender: Any) {
        makeEditable()
    }

    @IBAction func updateArticle(_ sender: Any) {
        self.updateArticle()
    }

    @IBAction func deleteArticle(_ sender: Any) {
        self.deleteArticle()
    }

    func makeViewOnly() {
        articleTitle.isEnabled = false
        articleContent.isUserInteractionEnabled = false
        articleContent.isEditable = false
        disableSaveButton()
        self.actionOnArticleContainer.isHidden = false
    }

    func makeEditable() {
        articleTitle.isEnabled = true
        articleContent.isUserInteractionEnabled = true
        articleContent.isEditable = true
        updateButton.isHidden = false
        deleteButton.isHidden = false
        editButton.isHidden = true
    }

    func disableSaveButton() {
        navigationItem.rightBarButtonItem?.isEnabled = false
    }

    func enableSaveButton() {
        navigationItem.rightBarButtonItem?.isEnabled = true
    }

    func configureView(with viewType: AddEditArticleViewModel.ViewType) {
        viewModel?.configure(viewType: viewType)
    }

    @objc func saveArticle() {
        if let articleTitle = articleTitle.text,
           let articleContent = articleContent.text {
            viewModel?.performArticleAction(title: articleTitle, content: articleContent, action: .add) {
                self.dismissView()
            }
        }
    }

    func validateFields() {
        if let articleText = articleTitle.text,
           let contentText = articleContent.text,
           !articleText.isEmpty,
           !contentText.isEmpty {
            enableSaveButton()
        } else {
            disableSaveButton()
        }
    }

    func updateArticle() {
        if let articleTitle = articleTitle.text,
           let articleContent = articleContent.text {
            viewModel?.performArticleAction(title: articleTitle, content: articleContent, action: .update) {
                self.dismissView()
            }
        }
    }

    func deleteArticle() {
        viewModel?.performArticleAction(title: "", content: "", action: .delete) {
            self.dismissView()
        }
    }

    func dismissView() {
        navigationController?.popViewController(animated: true)
    }
}

extension AddEditArticleViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderHelper.isHidden = true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        placeholderHelper.isHidden = !textView.text.isEmpty
    }

    func textViewDidChange(_ textView: UITextView) {
        validateFields()
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        validateFields()
    }
}
