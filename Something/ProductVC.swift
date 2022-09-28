//
//  ProductVC.swift
//  Something
//
//  Created by Capgemini-DA067 on 9/23/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
import CoreData

class ProductVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var productTableView: UITableView!
    
    var titleArray: NSMutableArray = []
    var descriptionArray: NSMutableArray = []
    var imageArray: NSMutableArray = []
    var categoryName: String!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.productTableView.delegate = self
        self.productTableView.dataSource = self
        
        webService1()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let productCell = tableView.dequeueReusableCell(withIdentifier: "product") as! ProductCellTableViewCell
        productCell.productName?.text = titleArray[indexPath.row] as? String
        productCell.productDescription?.text = descriptionArray[indexPath.row] as? String
        
        let imgUrl = imageArray[indexPath.row] as! String
        Alamofire.request(imgUrl).responseImage { (response) in
            if let image = response.result.value
            {
                DispatchQueue.main.async {
                    productCell.productImageView.image = image
                }
            }
            
        }
        
        productCell.addToCartButton.tag = indexPath.row
        productCell.addToCartButton.addTarget(self, action: #selector(saveProductDetails(sender: )), for: .touchUpInside)
        
        return productCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
    @objc func saveProductDetails(sender: UIButton){
        
        let index = IndexPath(row: sender.tag, section: 0)
        let prodctName = titleArray[index.row]
        let productDescription = descriptionArray[index.row]
        let productImage = imageArray[index.row]
        
        
        let appDeli = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDeli.persistentContainer.viewContext
        let productData = NSEntityDescription.insertNewObject(forEntityName: "AddToCart", into: context) as! AddToCart
        productData.productName = prodctName as? String
        productData.productDescription = productDescription as? String
        productData.productImage = productImage as? String
        
        alertDisplay(message: "Product added to Cart")
        

    }
    
    func webService1() {
        
        let categoryUrl = "https://dummyjson.com/products/category/" + categoryName! + "/"
        
        Alamofire.request(categoryUrl, method: .post, encoding: URLEncoding.default, headers: nil ).responseJSON {
            response in
            
            switch response.result{
            case .success:
                if let product: [String: Any] = response.value as! [String: Any]? {
                    let productArray = product["products"] as! NSArray
                    for productDict in productArray {
                        let temp = productDict as! NSDictionary
                        self.titleArray.add(temp["title"] as! String)
                        self.descriptionArray.add(temp["description"] as! String)
                        self.imageArray.add(temp["thumbnail"] as! String)
                        
                    }
                }
                    
                self.productTableView.reloadData()
                
                break
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func alertDisplay(message: String) {
        
        let alertMessage = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alertMessage.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertMessage, animated: true)
        
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
