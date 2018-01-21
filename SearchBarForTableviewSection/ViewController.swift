//
//  ViewController.swift
//  SearchBarForTableviewSection
//
//  Created by Pro Retina on 21/01/18.
//  Copyright © 2018 Pro Retina. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var studentArray = [[String:AnyObject]]()
    var filteredData = [[String:AnyObject]]()
    var searchActive : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.estimatedSectionHeaderHeight = 50
        
        
        let postDict = ["first_name":"Kashee","email":"kashee.nitd2016@gmail.com","category":"leave","course_id":"1111","phone":"9971474399","image":"image","created_at":"15-jan-2016, 19:35","id":"123","joining_year":"2016"] as! [String : AnyObject]
        
        studentArray.append(postDict)
        
       
        let postDict2 = ["first_name":"Ashok Singh ram","email":"kashee.nitd2016@gmail.com","category":"leave","course_id":"1111","phone":"9971474399","image":"image","created_at":"18-jan-2016, 19:35","id":"123","joining_year":"2017"] as! [String : AnyObject]
       
        studentArray.append(postDict2)
        studentArray.append(postDict)

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        
        let frame: CGRect = tableView.frame
        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0,width: frame.size.width, height:50))
        let headerButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0,width: frame.size.width,height: 50))
        headerButton.setTitle("Block Name", for: .normal)
        headerButton.setTitleColor(UIColor.red, for: .normal)
        headerButton.backgroundColor = UIColor.yellow
        // headerButton.contentHorizontalAlignment = .left
        
        headerButton.titleEdgeInsets.left = -UIScreen.main.bounds.width+110
        // headerButton.setImage(UIImage(named: "drop_up"), for: UIControlState.normal)
        // headerButton.setImage(UIImage(named: "drop_down"), for: UIControlState.selected)
        headerButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 300, bottom: 0, right: 5)
        headerButton.imageView?.contentMode = .scaleAspectFit
        
        headerButton.tag = section
        // headerButton.addTarget(self, action: #selector(ViewController.buttonTapped(sender:)), for: .touchUpInside)
        headerView.addSubview(headerButton)
        
        //        let button  = UIButton(type:.system)
        //        button.frame = CGRect(x: 0, y: 0,width: SCREEN_WIDTH,height: 50)
        //        button.setTitle("BLOCK", for: .normal)
        //        button.setTitleColor(.red, for: .normal)
        //        button.backgroundColor = .yellow
        //        return button
        
        return headerView
        
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 83
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if(searchActive) {
            return filteredData.count
        }
        return studentArray.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if(searchActive) {
            return filteredData[section].count
        }
        return studentArray[section].count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BlockTableViewCell
        if(searchActive && filteredData.count > indexPath.section){
            
            cell.userName.text = filteredData[indexPath.section]["first_name"] as! String
            //cell.joiningDate.text = filteredData[indexPath.section]["joining_year"] as! String
            
            cell.selectionStyle = .none
        } else {
           
            cell.userName.text = studentArray[indexPath.section]["first_name"] as! String
            //cell.joiningDate.text = studentArray[indexPath.section]["joining_year"] as! String
            cell.selectionStyle = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("click at \(indexPath.section) or \(indexPath.row)")
    }
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        
        filteredData.removeAll()
        let firstNamePredicate = NSPredicate(format: " first_name CONTAINS[cd] %@", searchText.uppercased())
        print("name \(firstNamePredicate)")
        self.filteredData = (studentArray as NSArray).filtered(using: firstNamePredicate) as! [[String:AnyObject]]
        print("name \(self.filteredData)")
        
        if filteredData.count == 0{
            searchActive = false
        }else{
            searchActive = true
        }
        
        tableView.reloadData()
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

