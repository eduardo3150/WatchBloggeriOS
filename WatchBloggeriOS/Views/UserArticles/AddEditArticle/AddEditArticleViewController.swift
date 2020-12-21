import Foundation
import UIKit

class AddEditArticleViewController: UIViewController {
    @IBOutlet weak var articleTitle: UITextField!
    @IBOutlet weak var articleContent: UITextView!
    @IBOutlet weak var placeholderHelper: UILabel!
    @IBOutlet weak var actionOnArticleContainer: UIStackView!
    @IBOutlet weak var editButton: UIButton!

    var viewModel: AddEditArticleViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        let saveArticleButton = UIBarButtonItem(
            barButtonSystemItem: .save,
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
            let deleteArticleButton = UIBarButtonItem(
                barButtonSystemItem: .trash,
                target: self,
                action: #selector(self.deleteArticleAction)
            )
            self.navigationItem.rightBarButtonItems = [saveArticleButton, deleteArticleButton]
        }
    }

    @IBAction func editArticle(_ sender: Any) {
        makeEditable()
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
           let articleContent = articleContent.text, let viewModel = self.viewModel {
            var action: ArticleAction = .add
            if case .EDIT = viewModel.viewType {
                action = .update
            }
            viewModel.performArticleAction(title: articleTitle, content: articleContent, action: action) {
                self.dismissView()
            }
        }
    }
    
    @objc func deleteArticleAction() {
        self.deleteArticle()
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
