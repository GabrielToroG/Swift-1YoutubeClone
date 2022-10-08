//
//  MainViewController.swift
//  Swift-1YoutubeClone
//
//  Created by Gtoro on 07-10-22.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Variables
    var pageViewController: PageViewController!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PageViewController {
            pageViewController = destination // Se instancia el pageViewController
            destination.delegatePage = self  // Se conforma el protocolo en MainViewController
        }
    }
}

extension MainViewController: PageProtocol {
    func getCurrentPageView(index: Int) {
        print("current page: \(index)")
    }
}
