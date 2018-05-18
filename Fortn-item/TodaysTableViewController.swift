//
//  TodaysTableViewController.swift
//  Fortn-item
//
//  Created by Emil Söderlind on 2018-05-18.
//  Copyright © 2018 ENOS Pr. All rights reserved.
//

import UIKit

class TodaysTableViewController: UITableViewController {
    
    
    var dailyList:[FortniteItem] = []
    var featuredList:[FortniteItem] = []
    var parseDone:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TodaysTableViewController ViewDidLoad")
        
        let ap: FNBRApiHandler = FNBRApiHandler()
        
        ap.parseCurrentItems(vc: self)
        
        //testImage.downloadedFrom(link: "https://image.fnbr.co/pickaxe/5afc0fa7b6e7f77dcfa32634/gallery.jpg")
        
        print("TodaysTableViewController ViewDidLoad - DONE")
    }
    
    func doneParsing(daily: [FortniteItem], featured: [FortniteItem]){
        print("Done parsing - updating tableView")
        parseDone = true
        
        dailyList = daily
        featuredList = featured
        
        self.tableView.reloadData()
        print("Done parsing - updating tableView - DONE")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        
        if(section == 0){
            return "Item Shop | \(result)"
        }else if(section == 1){
            return "Featured"
        }else{
            return "Daily"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        if(section == 0){
            return 0
        }else if(section == 1){
            return featuredList.count
        }else if (section == 2){
            return dailyList.count
        }
    
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ItemTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemTableViewCell
        
        if(indexPath.section == 1){
            
            cell.mainImage.downloadedFrom(link: featuredList[indexPath.row].images["icon"]!)
            
        }else if(indexPath.section == 2){
            
            cell.mainImage.downloadedFrom(link: dailyList[indexPath.row].images["icon"]!)

        }
        
        
        return cell
    }
    

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

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return false
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
