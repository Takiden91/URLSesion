//
//  ImageViewController.swift
//  URLSesion
//
//  Created by mac on 09.05.2022.
//

import UIKit

class ImageViewController: UIViewController {
    
    private let imageUrl = "https://cdn.pixabay.com/photo/2022/04/23/20/51/nature-7152461_960_720.jpg"
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true

        
    }
    
    private func fetchImage() {
        guard let url = URL(string: imageUrl) else { return }
        let session = URLSession.shared
        
        session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let response = response {
                print(response)
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.imageView.image = image
                }
            }
        }.resume()
    }
    
}
