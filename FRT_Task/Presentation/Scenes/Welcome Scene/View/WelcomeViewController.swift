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
        let transition = CATransition()
        
        vc.modalPresentationStyle = .fullScreen
        transition.duration = 2.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        
        self.present(vc, animated: true)
    }

}
