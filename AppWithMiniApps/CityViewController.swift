//
//  CityViewController.swift
//  AppWithMiniApps
//
//  Created by Полина Голодаевская on 03.09.2024.
//

import UIKit
import CoreLocation

class CityViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var cityLabel: UILabel! 
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            fetchCity(for: location)
        }
    }
    
    private func fetchCity(for location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Failed to get city: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first, let city = placemark.locality {
                self.cityLabel.text = city
            } else {
                self.cityLabel.text = "City not found"
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
}
