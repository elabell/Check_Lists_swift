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
   // car on va modifier cettt item etpas surcouche
    var itemToEdit : ChecklistItem? = nil
    var itemToEditWith : ChecklistItemCell? = nil
    var current_idxItem : IndexPath? = nil
    
     var stateEdit: Bool = false
    
    
    
    @IBOutlet weak var NavigationBarAddItem: UINavigationItem!
    
    @IBOutlet weak var btnDone: UIBarButtonItem!
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate = nil
    }
    
    
    @IBAction func Done(_ sender: Any) {
        
        print(textEdit.text!)
        let newItem: ChecklistItem = ChecklistItem.init(_text: textEdit.text!)
        
        if (stateEdit){
            // dismiss(animated: true, completion: nil)
            delegate?.addItemViewControllerEdit(self,didFinishEditingItem: newItem)
            // dismiss(animated: true, completion: nil)
            delegate = nil
            
        } else {
            
            // dismiss(animated: true, completion: nil)
            delegate?.addItemViewControllerExe( self, didFinishAddingItem: newItem)
            // dismiss(animated: true, completion: nil)
            delegate = nil
        }
        
        
    }
    

    @IBOutlet weak var textEdit: UITextField!
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        
        textEdit.becomeFirstResponder()
        if  ((textEdit.text?.isEmpty)!) {
             btnDone.isEnabled = false
        }
        if (stateEdit) {
            NavigationBarAddItem.title = "Edit item"
        }else{
            NavigationBarAddItem.title = "Add item"
        }
        
    }

    override func viewDidLoad() {
      super.viewDidLoad()
        
   
    }
    
    func textField(_ _textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String)-> Bool{

        let text = (_textField.text! as NSString).replacingCharacters(in: range, with: string)
    
        if text.isEmpty{
            btnDone.isEnabled = false
            
        }else{
             btnDone.isEnabled = true
        }
        
        return true
    
 }
}

protocol AddItemViewControllerDelegate : class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewControllerExe(_ controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
    
    func addItemViewControllerEdit(_ controller: AddItemViewController, didFinishEditingItem item: ChecklistItem)
}





protocol EditItemViewControllerDelegate : class {
    
    func editItemViewController(_ controller: AddItemViewController, itemToEdit:ChecklistItem ,itemToEditWith : ChecklistItemCell )
}
