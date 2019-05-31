//
//  Globals.swift
//  Night Watch
//
//  Created by Handy Lukman on 5/30/19.
//  Copyright © 2019 Handy Lukman. All rights reserved.
//

import Foundation
class Globals {
  
  var consoleText:String
  var deviceToken:String
  static let shared = Globals()
  
  init() {
    consoleText = "Globals initiated!";
    deviceToken = "";
  }
  
  func saveDeviceToken(_ token:String) {
    deviceToken = token;
    print(">>> Device Token: \(deviceToken)")
  }
  
  func printConsole(_ text:String) {
    consoleText = consoleText + "\n\n" + text;
  }
  
  func getConsoleText() -> String {
    return consoleText;
  }
  
  func resetConsole() {
    consoleText = "";
  }
  
  func getNowTime() -> String {
    let df = DateFormatter();
    df.dateFormat = "yyyy-MM-dd hh:mm:ss";
    return df.string(from: Date());
  }
  
  func processNotification(_ aps:[String: AnyObject]) {
    print(aps);
    let alertMsg = aps["alert"] as! String;
    let priority = aps["priority"] as! Int;
    
    printConsole(getNowTime() + ": \(alertMsg) -- Priority: \(priority)");
    
    NotificationCenter.default.post(name: .updateData, object: nil, userInfo: aps)
  }
}
