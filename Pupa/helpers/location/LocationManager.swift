import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    var map: MapboxMapHelper!
    
    func initLocationManager(mapboxMapHelper: MapboxMapHelper) {
        map = mapboxMapHelper
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50 // 50.0 meters
        locationManager.startUpdatingLocation()
    }
    
    func deinitLocationManager() {
        locationManager = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newUserLocation = Location(objectId: api.currentUser!.Id, latitude: locations.last!.coordinate.latitude, longitude: locations.last!.coordinate.longitude)
        
        let responseCode = api.updateUserLocation(newLocation: newUserLocation)
        
        AlertHelper.showAlertDialog(title: "Location update event\n responseCode = \(responseCode)", message: newUserLocation.toString())
    }
}
