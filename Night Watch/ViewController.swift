//
//  ViewController.swift
//  Night Watch
//
//  Created by Handy Lukman on 5/24/19.
//  Copyright © 2019 Handy Lukman. All rights reserved.
//

import UIKit
import NotificationCenter

extension Notification.Name {
  static var updateData: Notification.Name {
    return .init(rawValue: "UpdateData")
  }
}

class ViewController: UIViewController {

    @IBOutlet weak var deviceTokenField: UITextField!
    @IBOutlet weak var consoleField: UITextView!
    @IBOutlet weak var alertButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(dataUpdate), name: .updateData, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        deviceTokenField.text = Globals.shared.deviceToken;
        consoleField.text = Globals.shared.consoleText;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }

    @IBAction func tapMe(_ sender: Any) {
//        let alert = UIAlertController(title: "Alert", message: "The Night King is coming!", preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "nightKing") else { return }
        
        popVC.modalPresentationStyle = .popover
        
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = alertButton
        popOverVC?.sourceRect = CGRect(x: alertButton.bounds.midX, y: alertButton.bounds.minY, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 300, height: 500)
        
        self.present(popVC, animated: true)
    }
    
    @objc func dataUpdate(_ notification: Notification) {
        print(notification);
        self.view.setNeedsDisplay()
        
        deviceTokenField.text = Globals.shared.deviceToken;
        consoleField.text = Globals.shared.consoleText;
    }
    
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
