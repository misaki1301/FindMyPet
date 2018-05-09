//
//  ViewController.swift
//  Find my pet
//
//  Created by Paul Pacheco on 5/7/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    struct Dog {
        var name:String
        var race:String
        var lastAddress:String
        var title:String
        var image:String
    }

    @IBOutlet weak var tableView: UITableView!
    var tableData:[Dog]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableData=[
            Dog(name:"Poseidon",race:"Bichon Frise",lastAddress:"San Luis",title:"Se me perdio mi perrito",image:"https://i.ytimg.com/vi/AqwOO4JUrD0/hqdefault.jpg"),
            Dog(name:"Poseidon",race:"Bichon Frise",lastAddress:"San Luis",title:"Se me perdio mi perrito",image:"https://i.ytimg.com/vi/AqwOO4JUrD0/hqdefault.jpg"),
            Dog(name:"Poseidon",race:"Bichon Frise",lastAddress:"San Luis",title:"Se me perdio mi perrito",image:"https://i.ytimg.com/vi/AqwOO4JUrD0/hqdefault.jpg")
        ]
        //tableView.dataSource=self
        //tableView.delegate=self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "LostDog") as! LostDogCell
        cell.nameText.text=tableData[indexPath.row].name
        cell.lastAddressText.text=tableData[indexPath.row].lastAddress
        cell.raceText.text=tableData[indexPath.row].race
        cell.titleText.text=tableData[indexPath.row].title
        let url=URL(string: tableData[indexPath.row].image)
        cell.imageDog?.kf.setImage(with: url)
        return cell
    }
    


}
