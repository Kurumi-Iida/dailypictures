//
//  ReminderViewController.swift
//  Carender test
//
//  Created by 飯田くるみ on 2016/01/17.
//  Copyright © 2016年 Kurumi Iida. All rights reserved.
//

import Foundation
import UIKit


class ReminderViewController: UIViewController, UITableViewDelegate{
    
    @IBOutlet var reminderTableView:UITableView!
    
     override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    
    //Cellが選択された際に呼び出されるデリゲートメッソッド。
    func tableView(tableView:UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
    }
    
    //Cellの総数を返すデータソースメソッド。
    func tableView(tableView: UITableView, numberOfRowsInsection section: Int) ->Int{
        return 10
    }
    
    //cellの値を設定するデータソースメソッド。
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cellValue = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
    
        cellValue.textLabel?.text = String(indexPath.row)
        print(indexPath.row)
        
        return cellValue
    }
}