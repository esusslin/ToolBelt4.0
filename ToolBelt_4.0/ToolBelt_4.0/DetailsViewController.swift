//
//  DetailsViewController.swift
//  ToolBelt_4.0
//
//  Created by Emmet Susslin on 6/29/16.
//  Copyright © 2016 Emmet Susslin. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController, MKMapViewDelegate {
    
//    var contact = Int()

    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var contactButton: UIButton!

    @IBOutlet weak var contact: UILabel!
    
    @IBOutlet var toolDescription: UILabel!
 
    @IBOutlet var toolTitle: UILabel!
    
    @IBOutlet var ratingImage: UIImageView!
 
    @IBOutlet var toolImage: UIImageView!
//    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
//        if !(annotation is MKPointAnnotation) {
//            return nil
//        }
//        
//        var view = mapView.dequeueReusableAnnotationViewWithIdentifier("pin") as? MKPinAnnotationView
//        if view == nil {
//            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
//            view!.canShowCallout = false
//        }
//        return view
//    }
    
}