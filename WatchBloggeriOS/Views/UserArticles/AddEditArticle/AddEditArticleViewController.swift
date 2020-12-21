import Foundation
import UIKit

class AddEditArticleViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var articlePhoto: UIImageView!

    var viewModel: AddEditArticleViewModelProtocol?

    var imagePicker: UIImagePickerController!

    enum ImageSource {
        case photoLibrary
        case camera
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let saveArticleButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(saveArticle))
        navigationItem.rightBarButtonItem = saveArticleButton
    }

    @IBAction func takePhoto(_ sender: Any) {
        self.takePhoto()
    }

    func configureView(with viewType: AddEditArticleViewModel.ViewType) {
        viewModel?.configure(viewType: viewType)
    }

    @objc func saveArticle() {

    }

    private func takePhoto() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            selectImageFrom(.photoLibrary)
            return
        }
        selectImageFrom(.camera)
    }

    private func selectImageFrom(_ source: ImageSource) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }

    private func savePicture() {
        guard let selectedImage = articlePhoto.image else {
                    print("Image not found!")
                    return
                }
        UIImageWriteToSavedPhotosAlbum(
            selectedImage,
            self,
            #selector(image(_:didFinishSavingWithError:contextInfo:)),
            nil)
    }

    @objc func image(_ image: UIImage,
                     didFinishSavingWithError error: Error?,
                     contextInfo: UnsafeRawPointer) {
        if let error = error {
            showAlertWith(title: "Save error", message: error.localizedDescription)
        }
    }

    func showAlertWith(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

extension AddEditArticleViewController: UIImagePickerControllerDelegate {

   func imagePickerController(
    _ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
   ) {
       imagePicker.dismiss(animated: true, completion: nil)
       guard let selectedImage = info[.originalImage] as? UIImage else {
           print("Image not found!")
           return
       }
    articlePhoto.image = selectedImage
   }
}
