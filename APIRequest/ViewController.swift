//
//  ViewController.swift
//  APIRequest
//
//  Created by admin on 6/18/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    
   
    @IBOutlet weak var tableView: UITableView!
    var user = [User]()
    var height = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        Request(api: "https://jsonplaceholder.typicode.com/posts", request: .get, headers: nil, params: nil).request{ result, string in
            switch result{
            case .success(let success):
                self.user = success
                self.tableView.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                print(success.count)
            case.failure(let error):
                print(error)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
        }
        
        
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return user.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.id.text = "\(user[indexPath.row].id)"
        cell.title.text = user[indexPath.row].title
        cell.body.text = user[indexPath.row].body
        cell.userID.text = "\(user[indexPath.row].userId)"
        return cell
        
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 147
//    }

    
    
    
}

