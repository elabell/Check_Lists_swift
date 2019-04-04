//
//  ViewController.swift
//  Check_Lists_swift
//
//  Created by lpiem on 21/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController,ItemDetailViewControllerDelegate,SegueHandlerType {
    
    
    var documentDirectory : URL? = nil
    var dataFileUrl : URL? = nil

    var stateEdit: Bool = false
    
    var tableItems = [ChecklistItem]()
    
    var editedItemIndex: IndexPath? = nil
    
    var nbItems: Int {
        return tableItems.count
    }
    
    
    
    
    @IBOutlet weak var NavigationBar: UINavigationItem!
    
    
    
    enum SegueIdentifier: String {
        case addItem
        case editItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        switch segueIdentifierForSegue(for: segue) {
        case .addItem:
            
            
            guard  let destViewControler  = segue.destination as? UINavigationController
                else {return }
            
            guard  let targetcontroller   = destViewControler.topViewController as? ItemDetailViewController
                else {return }
            
            targetcontroller.delegate = self
            targetcontroller.stateEdit = false
            self.stateEdit = false
            break
            
        case .editItem:
            
            // var destSegue = segue.destination
            
            guard  let destViewControler  = segue.destination as? UINavigationController
                else {return }
            
            
            // segue.setValue(stateEdit , forKey:"stateEdit" )  //TOTEST  this //.accessibilityValue
            guard  let targetcontroller   = destViewControler.topViewController  as? ItemDetailViewController
                else {return }
            
            /* guard  let targetcontroller   = segue.destination as? ItemDetailViewController
             else {return }
             */
            targetcontroller.delegate = self
            
            //  if  let item = sender as? ChecklistItem?{
            let   indxPath_Current : IndexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            
            targetcontroller.current_idxItem = indxPath_Current
            
            self.editedItemIndex = indxPath_Current
            
            targetcontroller.stateEdit = true
            self.stateEdit = true
            
            if  let item = sender as? ChecklistItemCell?{
                
                targetcontroller.itemToEditWith = item //tableView.indexPath(for: sender)
                // On passe la donnée via les propriétés
            }
            
            break
            
            // [indexPath.row]
            //  we can make edition in meme view
            
            
        }
        
        
    }
    
    
    
    func itemDetailViewControllerEdit(_ controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
        
        self.editItem(editedItem: item)
        self.stateEdit = false
        self.dismiss(animated: true, completion: nil)
        
        
    }
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        // TOTEST
        
    }
    
    func itemDetailViewControllerExe(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
        
        
        self.addItem(controller, item: item)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableItems = [ChecklistItem]()
        initTablewithItems()
        self.configureTitreOfNavigationWind( withItem: NavigationBar, text: "Checklist")
        
    }
    
    
    
    func editItem(editedItem: ChecklistItem){
        
        var index: IndexPath =  self.editedItemIndex!
        
        //TODO totest DW
        //var   itemindex =  tableItems.index(where:{ $0 === editedItem})
        var itemToEdit : ChecklistItem = tableItems[index.row]
        itemToEdit.text = editedItem.text
        itemToEdit.checked = editedItem.checked
        
        tableView.reloadData()
    }
    
    //@IBAction
    func addItem(_ sender: Any, item: ChecklistItem) {
        
        /*
         Cette méthode permettra d’ajouter un item à la liste et préviendra la table view de l’arrivée d’une nouvelle ligne en utilisant la méthode insertRows(at:with:) de table view */
        //   let cellId : String = "cellId"
        
        //    let item = ChecklistItem(_text:"Comunication homework")
        tableItems.append(item)
        
        //nbItems = tableItems.count //  important
        
        //  tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        //  tableView.register(ChecklistItemCell.self, forCellReuseIdentifier: cellId)
        
        
        tableView.beginUpdates()
        let indx = IndexPath(row: (tableItems.count - 1), section: 0)
        
        
        tableView.insertRows(at: [indx], with: UITableView.RowAnimation.middle)
        tableView.endUpdates()
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            print("Deleted")
            
            

            
            if indexPath.row  < tableItems.count {
             //if(tableItems.count >= indexPath.row + 1){
                tableItems.remove(at: indexPath.row)
              
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
                // tableView.reloadData()
        }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("countItems",tableItems.count)
        return  tableItems.count// => is better to count each time  bc if we forget update this variable
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // pour recycler ou créer une nouvelle cellule selon le modèle défini dans le storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath) as! ChecklistItemCell  //ici on cast to perso ItemCell and we can access to his propriety
        
        
        
        cell.textLabel?.text = "My Item"
        // cell.LabelItem.isHidden = true
        // cell.CheckLabel.isHidden = true
        
        cell.isInVissible()
        let item = tableItems[indexPath.row]
        //let label = cell.viewWithTag(1000) as! UILabel
        //label.text = item.text
        configureText(for: cell, withItem: item)
        configureCheckmark(for: cell, withItem: item)
   
        //    tableView.reloadRows(at: [indexPath], with:  UITableView.RowAnimation.bottom)
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if let cell = tableView.cellForRow(at: indexPath){
        
            print("indxPAth: ",indexPath)
            let item = tableItems[indexPath.row]
            item.toggleChecked()
//            configureText(for: cell, withItem: item)
//            configureCheckmark(for: cell, withItem: item)
            // tableView.reloadRows(at: [indexPath], with:  UITableView.RowAnimation.none)
            tableView.reloadRows(at: [indexPath], with:  .automatic)
        
//        }
        tableView.deselectRow(at: (indexPath), animated: true)
    }
    
    
    
    func configureCheckmark(for cell: UITableViewCell, withItem item: ChecklistItem){
        if(item.checked){
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .detailDisclosureButton
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
    
   //documentDirectory  persistencePath()
    private  func persistencePath() -> URL?{
        
        let url = try? FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true)
        
        return url?.appendingPathComponent("checklistitems.bin")
    }
    
    
   override required init?(coder aDecoder: NSCoder) {
     super.init(coder: aDecoder)
     try! loadChecklistItems()
   
    }

    override func awakeFromNib() {
        
    }
    
    func configureTitreOfNavigationWind( withItem: UINavigationItem, text: String){
        withItem.title = text
    }
    
    func saveChecklistItems() throws{
        
        if let url = self.persistencePath(), let array = self as? NSArray{
       
        
            
            let data = try NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: false)
            try data.write(to: url)
        }
        else {
            let displaymsg: [String: Any] = ["Error occurred": 10]
                
            throw NSError(domain: "com.exemple.MyCheckList", code: 10, userInfo: displaymsg)
        }
    }
    
    func loadChecklistItems()  throws -> [ChecklistItem]{
        
        //var decoder: JSONDecoder?  = nil
        if let url = self.persistencePath() , let data = (try? Data(contentsOf: url) as Data?){
        
            if let array = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, ChecklistItem.self], from: (data as? Data)!) as? [ChecklistItem] {
               
                return array!
               }
            else {
                    
                     throw NSError(domain: "com.example.MyToDo", code: 11, userInfo: nil)
                    
                }
    
      }
        else{
            throw NSError(domain: "com.example.MyToDo", code: 11, userInfo: nil)
        }
    }
    


}
