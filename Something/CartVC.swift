//
//  CartVC.swift
//  Something
//
//  Created by Capgemini-DA067 on 9/25/22.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class CartVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // Outlets
    @IBOutlet weak var cartTableView: UITableView!
    
    // array
    var productArray = [AddToCart]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adding table delegates
        self.cartTableView.delegate = self
        
        self.cartTableView.dataSource = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //getting data in array from
        productArray = displayInCart()
        self.cartTableView.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //no of rows
        return productArray.count
        
    }
    
    // fun to add data to coredata and adding buuto acction
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cartCell = cartTableView.dequeueReusableCell(withIdentifier: "product") as! ProductCellTableViewCell
        
        cartCell.productName.text = productArray[indexPath.row].productName
        
        cartCell.productDescription.text = productArray[indexPath.row].productDescription
        
        let imgurl = productArray[indexPath.row].productImage!
        Alamofire.request(imgurl).responseImage { (response) in
            if let image = response.result.value
            {
                DispatchQueue.main.async {
                    cartCell.productImageView.image = image
                }
            }

        }
        
        //adding action to the button in cell
        cartCell.goToPlaceOrder?.tag = indexPath.row
        cartCell.goToPlaceOrder?.addTarget(self, action: #selector(goToPlaceOrder(sender: )), for: .touchUpInside)
        
        return cartCell
    }
    
    @objc func goToPlaceOrder(sender: UIButton) {
        
        let placeOrderVC = storyboard?.instantiateViewController(withIdentifier: "PlaceOrderVC") as! PlaceOrderVC
        self.navigationController?.pushViewController(placeOrderVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
    func displayInCart() -> [AddToCart] {
        
        var temp = [AddToCart]()
        let appDeli = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDeli.persistentContainer.viewContext
        do{
            temp = try context.fetch(AddToCart.fetchRequest()) as! [AddToCart]
        }
        catch{
            print("Failed")
        }
        return temp
        
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
