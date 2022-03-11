//
//  MainDetailView.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 11/03/2022.
//  
//

import Foundation
import UIKit
import SDWebImage

class MainDetailView: UIViewController {

    // MARK: Properties
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var imgCharacter: UIImageView!
    
    var presenter: MainDetailPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        self.view.backgroundColor = UIColor.init(rgb: Utils.MARVEL_COLORS.RED.rawValue)
        self.scroll.backgroundColor = UIColor.init(rgb: Utils.MARVEL_COLORS.YELLOW.rawValue)
        self.imgCharacter.layer.borderWidth = 1
        self.imgCharacter.layer.borderColor = UIColor.black.cgColor
    }
}

extension MainDetailView: MainDetailViewProtocol {
    func didReceivedError(_ error: Error) {
        print(error)
        self.showAlert()
    }
    
    func startActivityAnimation() {
        self.activity.isHidden = false
    }
    
    func stopActivityAnimation() {
        self.activity.isHidden = true
    }
    
    // TODO: implement view output methods
    func pushCharacter(_ data: MainDetailModel){
        
        self.lbl_name.text = data.name
        self.lbl_description.text = data.description
        self.imgCharacter.sd_setImage(with: URL(string: data.imgPath), placeholderImage: UIImage(named: "UnknownUser"))
    }
    
}
