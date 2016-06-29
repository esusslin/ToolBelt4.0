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
import AddressBook

class MapViewController: UIViewController, UISearchBarDelegate {
    
    var userId: Int = 0
    
    @IBOutlet var mapView: MKMapView!
    var tools = [Tool]()
    
    let locationManager = CLLocationManager()
    var currentLat: CLLocationDegrees = 0.0
    var currentLong: CLLocationDegrees = 0.0
 
    @IBOutlet weak var searchBar: UISearchBar!

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        mapView.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        
    }
    
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annotation = annotationView.annotation as! MyAnnotation
        if control == annotationView.rightCalloutAccessoryView {
            if control == annotationView.rightCalloutAccessoryView {
                userId = annotation.identifier!
                self.performSegueWithIdentifier("maptochat", sender: self)
            }
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "pin"
        var pin = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier) as? MKPinAnnotationView
        if pin == nil {
            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            pin!.pinColor = .Red
            pin!.canShowCallout = true
            pin!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            //pin!.image = UIImage(named: "custom_pin.png")
        } else {
            pin!.annotation = annotation
        }
        return pin
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
                    
                    for var i = 0; i < JSON.count; i++ {
                        
                        let distanceToTool = JSON[i].objectForKey("distance") as! Double
                        
                        let owner = JSON[i].objectForKey("owner")
                        let tool = JSON[i].objectForKey("tool")
                        let id = tool!["user_id"] as? Int!
                        let toolName = tool!["title"]!
                        let toolDescription = tool!["description"]!
                        var lat = owner!["latitude"]?!.doubleValue
                        lat = lat! + Double(arc4random_uniform(5))/10000
                        var long = owner!["longitude"]?!.doubleValue
                        long = long! + Double(arc4random_uniform(5))/10000
                        var latitude: CLLocationDegrees = lat!
                        var longitude: CLLocationDegrees = long!
                        
                        var latDelta: CLLocationDegrees = 0.05
                        var lonDelta: CLLocationDegrees = 0.05
                        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
                        
                        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
                        //                        self.map.setRegion(region, animated: true)
                        
                        let myTool = Tool(title: "\(toolName!)", description: "\(toolDescription!)", ownerId: id!, distance: distanceToTool)
                        
                        self.tools += [myTool]
                        
                        func annotate() {
                            
                            let annotation = MyAnnotation(identifier: id!, title: "\(toolName!)", subtitle: "\(toolDescription!)", coordinate: location)
                            
                            //                                                    annotation.coordinate: location
                            //
                            //                                                    annotation.title: "\(toolName!)"
                            //
                            //                                                    annotation.subtitle: "\(toolDescription!)"
                            //
                            //                                                    annotation.identifier: "\(owner!["id"])"
                            
                            self.mapView.addAnnotation(annotation)
                            
                        }
                        annotate()
                    }
                    
                    
                } else {
                    print("Sent search term, but no response")
                }
        }
        
        
        
        
    }
    

}



extension MapViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.03, 0.03)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            let locValue:CLLocationCoordinate2D = manager.location!.coordinate
            //        print("locations = \(locValue.latitude) \(locValue.longitude)")
            let location = locations.last! as CLLocation
            currentLat = location.coordinate.latitude
            currentLong = location.coordinate.longitude
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: \(error)")
    }
}