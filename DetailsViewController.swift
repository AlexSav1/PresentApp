//
//  DetailsViewController.swift
//  PresentBase
//
//  Created by Alex Laptop on 3/24/17.
//  Copyright © 2017 Alex Laptop. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var presentLabel: UILabel!
    
    var selectedPresent: Present!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.imageView.image = UIImage(data: self.selectedPresent.image as! Data)
        
        self.nameLabel.text = self.selectedPresent.person
        
        self.presentLabel.text = self.selectedPresent.presentName
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
