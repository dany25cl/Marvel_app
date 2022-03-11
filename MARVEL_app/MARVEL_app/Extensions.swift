//
//  Extensions.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 11/03/2022.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

extension UIViewController {
    func showAlert(){
        let alert = UIAlertController(title: "Atención", message: "No se han podido cargar los datos. Intentalo de nuevo", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

//extension UIImageView {
//    func loadFrom(URLAddress: String) {
//        guard let url = URL(string: URLAddress) else {
//            return
//        }
//
//        DispatchQueue.main.async { [weak self] in
//            if let imageData = try? Data(contentsOf: url) {
//                if let loadedImage = UIImage(data: imageData) {
//                        self?.image = loadedImage
//                }
//            }
//        }
//    }
//}
