//
//  MyCategoryVC.swift
//  Something
//
//  Created by Capgemini-DA067 on 9/22/22.
//

import UIKit
import Alamofire


class MyCategoryVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    //Outlet for tableview
    @IBOutlet weak var categoryTable: UITableView!
    
    var myArray: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Categories"       //adding title to page
        
        
        // Adding the table delegates
        self.categoryTable.delegate = self
        
        self.categoryTable.dataSource = self
        
        //calling the webService function
        webService()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true // to hide back Button
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myArray.count     // for number of rows
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //creating custom reusable cell
        let myCell = tableView.dequeueReusableCell(withIdentifier: "category") as! CategoryCell
        myCell.myCategoryLabel?.text = myArray[indexPath.row] as? String
        return myCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Giving automatiic height for the row asper the data inside it
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //lines for navigating to add to cart page
        let productPage = storyboard?.instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
        productPage.categoryName = myArray[indexPath.row] as? String
        self.navigationController?.pushViewController(productPage, animated: true)
        
    }
    
    func webService() {
        
        // using alamofire for getting json file data
        Alamofire.request("https://dummyjson.com/products/categories/", method: .post, encoding: URLEncoding.default, headers: nil ).responseJSON {
            response in
            switch response.result {
            case .success:
                if let array: NSArray = response.value as! NSArray?
                {
                    self.myArray = array
                }
                self.categoryTable.reloadData()
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
