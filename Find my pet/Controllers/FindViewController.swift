//
//  FIndViewController.swift
//  Find my pet
//
//  Created by Paul Frank Pacheco Carpio on 7/1/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit

class FindViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView:UITableView!
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for:indexPath) as! FoundDog
        return cell
    }
}
