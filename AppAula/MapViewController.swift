//
//  MapViewController.swift
//  AppAula
//
//  Created by jonathas on 23/07/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    
    lazy var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = self
        
        searchBar.delegate = self
    
        requestAuthorization()
    }
    

    func requestAuthorization(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

}


extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 7.0
        renderer.strokeColor = UIColor.red
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: mapView.userLocation.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: mapView.userLocation.coordinate))
        
        
        let directions = MKDirections(request: request)
        directions.calculate{ response, error in
            if error == nil {
                guard let response = response,
                      let route = response.routes.first
                else{return}
                
                self.mapView.removeOverlays(self.mapView.overlays)
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                
            }
        }
    }
    
    
    
}

extension MapViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBar.text
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if error == nil {
                guard let response = response else {return}
                
                self.mapView.removeAnnotations(self.mapView.annotations)
                for item in response.mapItems {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    annotation.subtitle = item.url?.absoluteString
                    self.mapView.addAnnotation(annotation)
                }
                self.mapView.showAnnotations(self.mapView.annotations, animated: true)
                
            }
        }
        
    }
    
    
}
    
