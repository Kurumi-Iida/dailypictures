//
//  CalendarView.swift
//  Carender test
//
//  Created by 飯田くるみ on 2016/06/26.
//  Copyright © 2016年 Kurumi Iida. All rights reserved.
//

import UIKit

class CalendarView: UIView {
    
    var mArray: NSMutableArray!
    
    //メンバ変数の設定（カレンダー用）
    var now: NSDate!
    var year: Int!
    var month: Int!
    var day: Int!
    var Maxday: Int!
    var dayOFWeek: Int!
    
    //メンバ変数の設定（カレンダー関数から取得したものを渡す）
    var comps: NSDateComponents!
    
    //メンバ変数の設定
    var calendarBackGroundColor: UIColor!
    var beforecangeBackgroundColor: UIColor!
    
    //カレンダーの位置決め用メンバ変数
    var calendarLabelIntervalX: Int!
    var calendarLabelX: Int!
    var calendarLabelY: Int!
    var calendarLabelWidth: Int!
    var calendarLabelHeight: Int!
    var calendarLableFontSize: Int!
    
    var buttonRadius: Float!
    
    var calendarIntervalX: Int!
    var calendarX: Int!
    var calendarIntervalY: Int!
    var calendarY: Int!
    var calendarSize: Int!
    var calendarFontSize: Int!

}
