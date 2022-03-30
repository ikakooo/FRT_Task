//
//  WelcomeViewController.swift
//  FRT_Task
//
//  Created by Irakli Chkhitunidzde on 30.03.22.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func onStartClick(_ sender: Any) {
        let sb = UIStoryboard(name: "MainDashboardTabBarController", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MainDashboardTabBarController")
        
        self.navigationController?.viewControllers.removeAll()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }

}
