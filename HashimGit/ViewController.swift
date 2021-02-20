//
//  ViewController.swift
//  HashimGit
//
//  Created by Hashim M H on 20/02/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var usernameLbl: UILabel!

    @IBOutlet weak var passwordLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        usernameLbl.text = NSLocalizedString("username", comment: "")
        passwordLbl.text = NSLocalizedString("password", comment: "")

    }

}

