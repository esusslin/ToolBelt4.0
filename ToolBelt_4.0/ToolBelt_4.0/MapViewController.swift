//
//  MapSearchViewController.swift
//  Pods
//
//  Created by Emmet Susslin on 6/24/16.
//
//
import UIKit
import MapKit
import Alamofire

class MapViewController: SearchViewController, MKMapViewDelegate, UISearchBarDelegate {
    
    var userId: Int = 0
    
    var tools = [Tool]()
    
    let locationManager = CLLocationManager()
    var currentLat: CLLocationDegrees = 0.0
    var currentLong: CLLocationDegrees = 0.0
 
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var findButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       self.mapView.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        
    }
    
    func searchBarSearchButtonClicked( searchbar: UISearchBar) {
        searchbar.resignFirstResponder()
        tools = []
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let userid: Int = defaults.objectForKey("toolBeltUserID") as! Int
        
        let searchTerm = String(searchBar.text!)
        
        print(searchTerm)
        
        
        Alamofire.request(.GET, "http://localhost:3000/tools/search", parameters: ["keyword": searchTerm, "latitude": currentLat, "longitude": currentLong,
            "user": userid]) .responseJSON {response in
                if let JSON = response.result.value {
                    print("\(JSON)")
                }
        
        
        
        }
        
    }
    
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        let reuseIdentifier = "pin"
//        var pin = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier) as? MKPinAnnotationView
//        if pin == nil {
//            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
//            pin!.pinColor = .Red
//            pin!.canShowCallout = true
//            pin!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
//            //pin!.image = UIImage(named: "custom_pin.png")
//        } else {
//            pin!.annotation = annotation
//        }
//        return pin
//    }

    
}


extension MapViewController : CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.01, 0.01)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: \(error)")
    }
}