//
//  PlaceOrderVC.swift
//  Something
//
//  Created by Capgemini-DA067 on 9/25/22.
//

import UIKit
import MapKit
import CoreLocation

class PlaceOrderVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    // outlet for mapview
    @IBOutlet weak var orderLocationMapView: MKMapView!
    
    var locManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //calling the myOrderLocation
        myOrderLocation()
       
    }
    
    //
    func myOrderLocation() {
        
        locManager = CLLocationManager()
        locManager?.delegate = self
            
        locManager?.desiredAccuracy = kCLLocationAccuracyBest
           
        locManager?.requestAlwaysAuthorization()
            
            if CLLocationManager.locationServicesEnabled() {
                
                locManager?.startUpdatingLocation()
            }
        }
        
        var orderLocation: CLLocation?
    
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            let orderLocations: CLLocation = locations[0] as CLLocation
            orderLocation = orderLocations
            
            let center = CLLocationCoordinate2D(latitude: orderLocations.coordinate.latitude, longitude: orderLocations.coordinate.longitude)
            
            let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            orderLocationMapView.setRegion(mRegion, animated: true)
            
            let mkAnnotation: MKPointAnnotation = MKPointAnnotation()
            
            mkAnnotation.coordinate = CLLocationCoordinate2DMake(orderLocations.coordinate.latitude, orderLocations.coordinate.longitude)
           
            getAddress { (address) in
                mkAnnotation.title = address
            }
            orderLocationMapView.addAnnotation(mkAnnotation)
        }
        
        func getAddress(handler: @escaping (String) -> Void) {
            
            let geoCoder = CLGeocoder()
            
            //for getting the address for annotation
            let location = CLLocation(latitude: orderLocation!.coordinate.latitude, longitude: orderLocation!.coordinate.longitude)
            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placeMarks, error) -> Void in
                
                var placeMark: CLPlacemark?
                placeMark = placeMarks?[0]
               
                let address = "\(placeMark?.subThoroughfare ?? ""), \(placeMark?.thoroughfare ?? ""), \(placeMark?.locality ?? ""), \(placeMark?.subLocality ?? ""), \(placeMark?.administrativeArea ?? ""), \(placeMark?.postalCode ?? ""), \(placeMark?.country ?? "")"
                handler(address)
            })
        }

    @IBAction func placeOrderButtonClicked(_ sender: Any) {
       
        // navigates to the notification page
        let notificationVC = storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(notificationVC, animated: true)
        
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
