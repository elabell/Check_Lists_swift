//
//  AddItemViewController.swift
//  Check_Lists_swift
//
//  Created by lpiem on 21/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate {

   // @IBOutlet weak var btnDone: UIBarButtonItem!
    
    var delegate : AddItemViewControllerDelegate? = nil
 //   addItem
    
    
    @IBOutlet weak var btnDone: UIBarButtonItem!
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func Done(_ sender: Any) {
        
        print(textEdit.text!)
        let newItem: ChecklistItem = ChecklistItem.init(_text: textEdit.text!)
        
       
        
    // dismiss(animated: true, completion: nil)
       delegate?.addItemViewControllerExe( self, didFinishAddingItem: newItem)
       // dismiss(animated: true, completion: nil)
      delegate = nil
        
    }
    

    @IBOutlet weak var textEdit: UITextField!
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        
        textEdit.becomeFirstResponder()
        if  ((textEdit.text?.isEmpty)!) {
             btnDone.isEnabled = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func textField(_ _textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String)-> Bool{

        let text = (_textField.text! as NSString).replacingCharacters(in: range, with: string)
    
        if text.isEmpty{
           btnDone.isEnabled = false
            
        }else{
             btnDone.isEnabled = true
        }
        
        return true
     /*  guard  let nsString = _textField.text as NSString? else {return false}
        
        //let newStrng = nsString.replacingCharacters(in: range, with: string)
        let newStrng = (nsString as NSString).replacingCharacters(in: range, with: string)
        return true
    */
       // if let swRange = _textField.text.
 }
}

protocol AddItemViewControllerDelegate : class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewControllerExe(_ controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
}



/*
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

 }*/
