//
//  DetailViewController.swift
//  Project1
//
//  Created by Jaylen on 7/31/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    
    var images = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Picture \(images.firstIndex(of: selectedImage!)!+1 ) of \(images.count)"
        
        navigationItem.largeTitleDisplayMode = .never

        if let selectedImage = selectedImage {
            imageView.image = UIImage(named: selectedImage)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
