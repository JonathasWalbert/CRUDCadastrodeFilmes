//
//  MovieFormViewController.swift
//  AppAula
//
//  Created by jonathas on 22/07/22.
//

import UIKit

class MovieFormViewController: UIViewController {
    
    
    @IBOutlet weak var textFielTitle: UITextField!
    @IBOutlet weak var textFieldRating: UITextField!
    @IBOutlet weak var textFieldDuration: UITextField!
    @IBOutlet weak var textFieldCategories: UITextField!
    @IBOutlet weak var textViewSummary: UITextView!
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var buttonAddEdit: UIButton!
    
    var movie: Movie?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let movie = movie{
            title = "Edição"
            
            textFielTitle.text = movie.title
            textFieldRating.text = "⭐️ \(movie.rating)"
            textFieldDuration.text = movie.duration
            textFieldCategories.text = movie.categories
            textViewSummary.text = movie.summary
            
            if let image = movie.image{
                imageViewPoster.image = UIImage(data: image)
            }
            
            buttonAddEdit.setTitle("Editar", for:.normal)
            
        }
        
    }
    

    @IBAction func selectPoster(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar a imagem", message: "Onde deseja buscar a imagem", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                self.selectPicture(sourceType: .camera)
            }
            
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default) { _ in
            self.selectPicture(sourceType: .photoLibrary)
        }
            alert.addAction(libraryAction)
        
    
        let albumAction = UIAlertAction(title: "Album de fotos", style: .default) { _ in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }
            alert.addAction(albumAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
        
    
       
        
    }
    
    
    func selectPicture (sourceType: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func save(_ sender: UIButton) {
        if movie == nil {
            movie = Movie(context: context)
        }
        
        movie?.title = textFielTitle.text
        movie?.duration = textFieldDuration.text
        movie?.rating = Double(textFieldRating.text!) ?? 0
        movie?.categories = textFieldCategories.text
        movie?.summary = textViewSummary.text
        movie?.image = imageViewPoster.image?.jpegData(compressionQuality: 0.9)
        
        try? context.save()
        
        navigationController?.popViewController(animated: true)
        
    }
}

extension MovieFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            imageViewPoster.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
}
