import UIKit
import CoreLocation
import MapboxMaps

public var map = MapboxMapHelper()
public var api = ApiProcessor()

class MapController: UIViewController {
    
    @IBOutlet var mapView: MapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.setupMapboxMapHelper(mapView: mapView)
        map.initLocationManager()
        map.updateFriendsLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        map.moveCameraToUser()
    }
    
}
