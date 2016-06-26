//
//  ViewController.swift
//  Carender test
//
//  Created by 飯田くるみ on 2015/12/28.
//  Copyright © 2015年 Kurumi Iida. All rights reserved.
//

import UIKit
import QuartzCore
import AssetsLibrary
import Photos


class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var haikeiImageView: UIImageView!
    let ipc:UIImagePickerController = UIImagePickerController();
    var photoAssets = [PHAsset]()
    //メンバ変数の設定（配列格納用）
    var mArray: NSMutableArray!
    
    // チェックボックス
    //@IBOutlet var button: UIButton!
    
    @IBOutlet weak var calendar: CalendarView!
    //プロパティを指定
    @IBOutlet var calendarBar: UILabel!
    @IBOutlet var prevMonthButton: UIButton!
    @IBOutlet var nextMonthButton: UIButton!
    
    var timer: NSTimer!
    var animationFlag: Bool = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        calendar.delegate = self
        setupCalendarTitle(calendar.year, month: calendar.month)

        timer = NSTimer.scheduledTimerWithTimeInterval(4,
            target: self,
            selector: Selector("textRed"),
            userInfo: nil,
            repeats: true
        )
        
        PHPhotoLibrary.requestAuthorization{ handler in
            print("hoge")
        }
        
    }
    
    //前の月のボタンを押した際のアクション
    @IBAction func getPrevMonthData(sender: UIButton) {
        calendar.prevCalendarSettings()
    }
    
    //次の月のボタンを押した際のアクション
    @IBAction func getNextMonthData(sender: UIButton) {
        calendar.nextCalendarSettings()
    }
    
    //左スワイプで前月を表示
    @IBAction func swipePrevCalendar(sender: UISwipeGestureRecognizer) {
        calendar.prevCalendarSettings()
    }
    
    //右スワイプで次月を表示
    @IBAction func swipeNextCalendar(sender: UISwipeGestureRecognizer) {
        calendar.nextCalendarSettings()
    }
    
    private func getNSDateFromString(year: Int, month:Int, day: Int) -> NSDate?{
        let date_string = "\(year)-\(month)-\(day) 00:00:00"
        let date_formatter = NSDateFormatter()
        date_formatter.locale = NSLocale(localeIdentifier: "ja")
        date_formatter.dateFormat = "yyy/MM/dd HH:mm:ss"
        return date_formatter.dateFromString(date_string)
    }
    
    private func getAllPhotosInfo(year: Int, month: Int, day: Int) {
        photoAssets = []
        
        // ソート条件を指定
        let options = PHFetchOptions()
        options.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
        
        let fromDate = getNSDateFromString(year, month: month, day: day)
        let toDate = getNSDateFromString(year, month: month, day: day+1)
        if toDate == nil {
            return
        }
        options.predicate = NSPredicate(format: "(creationDate >= %@) and (creationDate < %@)",fromDate!, toDate!)
        // options.predicate = NSPredicate.predicateWithSubstitutionVariables(日にち)
        
        // 画像をすべて取得
        let assets: PHFetchResult = PHAsset.fetchAssetsWithMediaType(.Image, options: options)
        assets.enumerateObjectsUsingBlock { (asset, index, stop) -> Void in
            self.photoAssets.append(asset as! PHAsset)
        }
        print("")
        print(photoAssets)
        
        if self.photoAssets.count != 0 {
            let manager: PHImageManager = PHImageManager()
            manager.requestImageDataForAsset(self.photoAssets[0],
                options: nil,
                resultHandler: {(data, str, orientation, info) in
                    let image = UIImage(data: data!)
                    self.haikeiImageView.image = image
                })
        }
    }
    
    func textRed() {
        print("image")
        UIView.animateWithDuration(1.5,
            animations: {
                self.haikeiImageView.alpha = 0.5
            },
            completion: { animationFlag in
                UIView.animateWithDuration(1.5,
                    animations: {
                        self.haikeiImageView.alpha = 1.0
                        if self.photoAssets.count != 0 {
                            let manager: PHImageManager = PHImageManager()
                            manager.requestImageDataForAsset(self.photoAssets[Int(arc4random_uniform(UInt32(self.photoAssets.count)))],
                                options: nil,
                                resultHandler: {(data, str, orientation, info) in
                                    let image = UIImage(data: data!)
                                    self.haikeiImageView.image = image
                            })
                        } else {
                            // このときだけ画像がないよーを表示する
                            self.haikeiImageView.alpha = 1.0

                            self.haikeiImageView.image = UIImage(named: "noimage.JPG")
                            
                }
                    }, completion: nil)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func checkButton(button: UIButton){
        if button.selected {
            button.selected = false
        } else {
            button.selected = true
        }
        
    }
}

extension ViewController: CalendarViewDelegate {
    func setupCalendarTitle(year: Int, month: Int) {
        calendarBar.text = String("\(year).\(month)")
    }
    
    func buttonTapped(year: Int, month: Int, day: Int) {
        getAllPhotosInfo(year, month: month, day: day)
    }

}