//
//  FavoriteTableViewController.swift
//  Fortn-item
//
//  Created by Emil Söderlind on 2018-05-28.
//  Copyright © 2018 ENOS Pr. All rights reserved.
//

import UIKit
import CoreData

class FavoriteTableViewController: UITableViewController, UITabBarControllerDelegate {

    var favoriteItems: [itemModelItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FavoriteTableViewController.viewDidLoad")

        tabBarController?.delegate = self
        
        refreshTable()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 320
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        print("FavoriteTableViewController.viewDidLoad - DONE")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshTable()
    }
    
    func refreshTable(){
        DispatchQueue.global(qos:.background).async {
            print("Getting favorite items")
            
            var updatedFavoriteList:[itemModelItem] = CDhandler.getSavedItemsCoreData()
            
            if(updatedFavoriteList == self.favoriteItems){
                print("Nothing have changed")
                return
            }
            
            self.favoriteItems = updatedFavoriteList
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("Getting favorite items - DONE")
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favoriteItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! ItemTableViewCell
        
        
        // Icon image if png dosen't exist, png for other.
        if(favoriteItems[indexPath.row].imgPng != nil){
            cell.mainImage.image = favoriteItems[indexPath.row].imgPng
        }else if(favoriteItems[indexPath.row].imgIcon != nil){
            cell.mainImage.image = favoriteItems[indexPath.row].imgIcon
        }
        

        cell.title.text = favoriteItems[indexPath.row].name
        cell.priceLabel.text = favoriteItems[indexPath.row].price
        
        // Gradient background based on rarity
        cell.gradientBackgroundView.startColor = TodaysTableViewController.getRarityColor(rarityStr: favoriteItems[indexPath.row].rarity + "0")
        cell.gradientBackgroundView.endColor = TodaysTableViewController.getRarityColor(rarityStr: favoriteItems[indexPath.row].rarity + "1")
        
        if(favoriteItems[indexPath.row].priceIcon == "vbucks"){
            cell.priceImg.image = UIImage(named: "icon_vbucks.png")
        }else{
            
            
            // OTHER PRICE ICONS
            
            
        }
        
        return cell
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let removeID = favoriteItems[indexPath.row].id
            
            favoriteItems.remove(at: indexPath.row)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .right)
            
            CDhandler.removeItemInCoreData(id: removeID)
            
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
