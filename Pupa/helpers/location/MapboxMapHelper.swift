import UIKit
import MapboxMaps

public class MapboxMapHelper: LocationPermissionsDelegate {

    var mapView: MapView!
    var lm = LocationManager()
    var api = ApiProcessor()
    var annotationManager: CircleAnnotationManager!
    var friends: [CircleAnnotation]!
    
    func setupMapboxMapHelper(mapView: MapView){
        self.mapView = mapView
        mapView.location.delegate = self
        mapView.location.options.puckType = .puck2D()
        
        annotationManager = mapView.annotations.makeCircleAnnotationManager()
        friends = [CircleAnnotation]()
    }
    
    func initLocationManager(){
        lm.initLocationManager(mapboxMapHelper: self)
    }
    
    func deinitLocationManager(){
        lm.deinitLocationManager()
    }
    
    func updateFriendsLocation() {
        let userRelationships = api.getUserRelationships(userId: api.currentUser.Id)
        
        if userRelationships != nil {
            userRelationships?.forEach({ relationship in
                let friendLocation = api.getUserLocation(userId: relationship.secondUserId)
                
                // Create the circle annotation.
                var circleAnnotation = CircleAnnotation(centerCoordinate: friendLocation!.toCLLocation())
                circleAnnotation.circleColor = StyleColor(.blue)
                circleAnnotation.circleRadius = 10
                
                friends.append(circleAnnotation)
            })
            
            annotationManager.annotations = friends
        }
    }
    
    func moveCameraToLocation(newLocation: CLLocation) {
        let CameraOptions = CameraOptions(center: newLocation.coordinate, zoom: 12, pitch: 40)
        mapView.camera.fly(to: CameraOptions, duration: 2)
    }
    
    func moveCameraToUser(){
        let userLocation = api.getUserLocation(userId: api.currentUser.Id)
        let CameraOptions = CameraOptions(center: userLocation!.toCLLocation(), zoom: 12, pitch: 40)
        mapView.camera.fly(to: CameraOptions, duration: 1.5)
    }
}
