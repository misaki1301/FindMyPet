//
//  FIndViewController.swift
//  Find my pet
//
//  Created by Paul Frank Pacheco Carpio on 7/1/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit

class FIndViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setUpNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController=searchController
        navigationItem.hidesSearchBarWhenScrolling=false
    }
}
