//
//  LocationViewController.swift
//  Test
//
//  Created by Alikhan Nursapayev on 26.04.2022.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var textView: UITextField!
    private var locationManager:CLLocationManager?
    var enabled: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.delegate = self
    }
    
    func getUserLocation() {
        if !enabled {
            startButton.setTitle("Stop tracking", for: .normal)
            locationManager?.startUpdatingLocation()
        } else {
            startButton.setTitle("Start tracking", for: .normal)
            locationManager?.stopUpdatingLocation()
        }
        enabled = !enabled
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            textView.text = "Lat : \(location.coordinate.latitude) \nLng : \(location.coordinate.longitude)"
        }
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        getUserLocation()
    }
}
