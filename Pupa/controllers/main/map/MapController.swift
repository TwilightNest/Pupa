import UIKit
import CoreLocation
import MapboxMaps

class MapController: UIViewController {
    
    @IBOutlet var mapView: MapView!
    var map = MapboxMapHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.setupMapboxMapHelper(mapView: mapView)
        map.initLocationManager()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        map.moveCameraToUser()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        map.deinitLocationManager()
    }
}
