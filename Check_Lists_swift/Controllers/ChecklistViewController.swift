//
//  ViewController.swift
//  Check_Lists_swift
//
//  Created by lpiem on 21/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    
    var nbItems: Int {
        return tableItems.count
    }
    var tableItems =  [ChecklistItem]()
    

    /*
 variable de classe
     static var xxxx : URL{
     .AppendPathComponent
     return ddddd
     }
 */

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTablewithItems()
       
        
    }

    

    
    @IBAction func addItem(_ sender: Any) {
    
        /*
         Cette méthode permettra d’ajouter un item à la liste et préviendra la table view de l’arrivée d’une nouvelle ligne en utilisant la méthode insertRows(at:with:) de table view */
     
        
       let item = ChecklistItem(_text:"Comunication homework")
        tableItems.append(item)
        //nbItems = tableItems.count //  important
       
        tableView.beginUpdates()
        let indx = IndexPath(row: (tableItems.count - 1), section: 0)
        
        
        tableView.insertRows(at: [indx], with: UITableView.RowAnimation.middle)
         tableView.endUpdates()
    }
    
  
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
       //
     /*
      tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
    
         tableView.beginUpdates()
         tableItems.remove(at: indexPath.row)
         nbItems = tableItems.count // very important
           tableView.endUpdates()
 
      */
        if editingStyle == .delete {
            print("Deleted")
        }
        
   //     var indx = indexPath.row
        tableItems.remove(at: indexPath.row)
  //      nbItems = tableItems.count // very important when in  tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)  we have this var
        
       // tableView.beginUpdates()
   //  tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
        
        
        tableView.reloadData()
      //  nbItems = tableItems.count
        // tableView.endUpdates()  // very important
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  tableItems.count// => is better to count each time  bc if we forget update this variable
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // pour recycler ou créer une nouvelle cellule selon le modèle défini dans le storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
      
        cell.textLabel?.text = "My Item"
        
        let item = tableItems[indexPath.row]
        //let label = cell.viewWithTag(1000) as! UILabel
        //label.text = item.text
        configureText(for: cell, withItem: item)
        configureCheckmark(for: cell, withItem: item)
        tableView.reloadRows(at: [indexPath], with:  UITableView.RowAnimation.bottom)
        
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath){
            let item = tableItems[indexPath.row]
            item.toggleChecked()
            configureText(for: cell, withItem: item)
            configureCheckmark(for: cell, withItem: item)
           // tableView.reloadRows(at: [indexPath], with:  UITableView.RowAnimation.none)
            tableView.reloadRows(at: [indexPath], with:  UITableView.RowAnimation.left)
            
        }
        tableView.deselectRow(at: (indexPath), animated: true)
    }
    
    
    
    func configureCheckmark(for cell: UITableViewCell, withItem item: ChecklistItem){
        if(item.checked){
            cell.accessoryType = .checkmark
          }
        else{
            cell.accessoryType = .none
        }
        
        
        
    }
    
    
    func configureText(for cell: UITableViewCell, withItem item: ChecklistItem){
        
      //  let label = cell.viewWithTag(1000) as! UILabel
      //  label.text = item.text
        
        cell.textLabel?.text = item.text

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func initTablewithItems(){
        let task1 = ChecklistItem(_text: "Finir le cours d'IOS")
        let task2 = ChecklistItem(_text: "Mettre à jour XCode",_checked:true)
        let task3 = ChecklistItem(_text: "Ma tache perso")
        let task4 = ChecklistItem(_text: "Home work Java",_checked:true)
        tableItems.append(task1)
        tableItems.append(task2)
        tableItems.append(task3)
        tableItems.append(task4)
        
       // nbItems = tableItems.count
        
    }
    
    

    

}
