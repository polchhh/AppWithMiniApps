//
//  WeatherViewController.swift
//  AppWithMiniApps
//
//  Created by Полина Голодаевская on 03.09.2024.
//

import UIKit
import CoreLocation

struct Main: Codable {
    var temp: Double = 0.0
}

struct WeatherData: Codable {
    var name: String = ""
    var main: Main = Main()
}

class WeatherViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var weatherData = WeatherData()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
    }
    
    func updateView(){
        cityLabel.text = weatherData.name
        temperatureLabel.text = weatherData.main.temp.description + " °C"
    }
    
    private func updateWeather(latitude: Double, longitude: Double ) {
        let session = URLSession.shared
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude.description)&lon=\(longitude.description)&appid=\(myAPI)&lang=ru&units=metric")!
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("DataTask error \(String(describing: error?.localizedDescription))")
                return
            }
            do {
                self.weatherData = try JSONDecoder().decode(WeatherData.self, from: data!)
                print(self.weatherData)
                DispatchQueue.main.async {
                    self.updateView()
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    

    private func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
                self.locationManager.pausesLocationUpdatesAutomatically = false
                self.locationManager.startUpdatingLocation()
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            print(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)
            updateWeather(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
}
