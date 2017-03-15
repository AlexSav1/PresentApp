//
//  PresentsTableViewController.swift
//  PresentBase
//
//  Created by Alex Laptop on 3/14/17.
//  Copyright © 2017 Alex Laptop. All rights reserved.
//

import UIKit
import CoreData

class PresentsTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //var myGifts = [["name":"Best Friend","image":"1","item":"Camera"],["name":"Mom","image":"2","item":"Flowers"],["name":"Dad","image":"3","item":"Some kind of tech"],["name":"Sister","image":"4","item":"Sweets"]]

    
    var presents = [Present]()
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let iconImageView = UIImageView(image: UIImage(named: "Shape"))
        self.navigationItem.titleView = iconImageView
        
        self.managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        self.loadData()
    }
    
    func loadData(){
        
        let presentRequest: NSFetchRequest<Present> = Present.fetchRequest()
        
        do {
            self.presents = try managedObjectContext.fetch(presentRequest)
            self.tableView.reloadData()
        } catch {
            print("Could not load data \(error.localizedDescription)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.presents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PresentsTableViewCell

        // Configure the cell...
        let presentObject = self.presents[indexPath.row]
        
        if let presentImage = UIImage(data: presentObject.image as! Data){
            cell.backgroundImageView.image = presentImage
        }
        
        cell.nameLabel.text = presentObject.person
        cell.itemLabel.text = presentObject.presentName
        

        return cell
    }
    
    @IBAction func addPresent(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true){}
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            picker.dismiss(animated: true, completion: { 
              self.createPresentItem(with: image)
            })
            
        }
        
    }
    
    func createPresentItem(with Image: UIImage){
        
        let presentItem = Present(context: self.managedObjectContext)
        presentItem.image = NSData(data: UIImageJPEGRepresentation(Image, 0.3)!)
        
        let inputAlert = UIAlertController(title: "New Present", message: "Enter a person and a present.", preferredStyle: .alert)
        inputAlert.addTextField { (textField: UITextField) in
            textField.placeholder = "Person"
        }
        inputAlert.addTextField { (textField: UITextField) in
            textField.placeholder = "Present"
        }
        
        inputAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action: UIAlertAction) in
            
            let personTextField = inputAlert.textFields?.first
            let presentTextField = inputAlert.textFields?.last
            
            if (personTextField?.text != "" && presentTextField?.text != "") {
                
                presentItem.person = personTextField?.text
                presentItem.presentName = presentTextField?.text
                
                do {
                    try self.managedObjectContext.save()
                    self.loadData()
                } catch  {
                    print("Could not save data \(error.localizedDescription)")
                }
                
            }
            
        }))
        
        inputAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(inputAlert, animated: true, completion: nil)
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete the row from the data source
            let presentToDelete: Present = self.presents[indexPath.row]
            
            self.managedObjectContext.delete(presentToDelete)
            
            self.presents.remove(at: indexPath.row)
            
            do {
                try self.managedObjectContext.save()
                self.tableView.reloadData()
            } catch  {
                print("Could not save data \(error.localizedDescription)")
            }
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
