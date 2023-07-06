//
//  ViewController.swift
//  PopUp
//
//  Created by Mac on 04/07/23.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func showPopup(_ sender: UIButton) {
        let frame = sender.frame
        print(frame)
        let c = CustomView(frame: frame)
        c.arcFrame = sender.frame
        c.items = ["Hi this is Akhter and i am jbjkfb fjbfwe kjbew  djkb kjbedj kjan IOS Developer", "Welcome to Popup Demo","Welcome to Popupssdgdsgsdgsgsgsdsdg Demo","Welcome to Pdsdfsfsfsdopup Demo","Welcome to1111111\n\n\n\n\n Popup Demo"]

        
        c.show()
        view.addSubview(c)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

