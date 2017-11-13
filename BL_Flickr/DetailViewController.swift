//
//  DetailViewController.swift
//  BL_Flickr
//
//  Created by Алексей Россошанский on 06.10.17.
//  Copyright © 2017 Denis Petrov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        detailImage.image = thIm[myItem]
        
        
    }


    @IBOutlet weak var detailImage: UIImageView!
    
    
    

}
