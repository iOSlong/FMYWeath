//
//  FMYWTodayHomeTableViewController.swift
//  FMYWeath
//
//  Created by xuewu.long on 17/1/3.
//  Copyright © 2017年 fmylove. All rights reserved.
//

import UIKit

class FMYWTodayHomeTableViewController: UITableViewController {
    var sourceArr:NSMutableArray = {
       let muArr = NSMutableArray()
        muArr.add(["VC":"FMYWAlmanacViewController"])
        muArr.add(["VC":"FMYWTodayNewsViewController"])
        muArr.add(["VC":"FMYWTodayHistoryViewController"])
        return muArr
    }()
    var platGreGorianCal:GreGorianCalView = {
        let greGorin = GreGorianCalView(frame:.zero)
        greGorin.width    = myScreenW
        greGorin.height   = 110
        return greGorin
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let almanac = FMYWAlmanacModel()
        almanac.yangli = timeShow(time: Date().timeIntervalSince1970, formateStr: .TFy_M_d)
        self.platGreGorianCal.almanac = almanac
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableHeaderView = self.platGreGorianCal
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifer = NSStringFromClass(self.classForCoder)
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: reuseIdentifer)
        }
        let item:NSDictionary = self.sourceArr[indexPath.row] as! NSDictionary
        let desVCName = item.object(forKey: "VC")
        
        // TODO 字符串转类
        let desClass = NSClassFromString(desVCName as! String)
        let desVC = desClass 
        return cell!
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
