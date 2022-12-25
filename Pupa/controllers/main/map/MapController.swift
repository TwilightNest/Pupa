import UIKit
import CoreLocation
import MapboxMaps

public var map = MapboxMapHelper()

class MapController: UIViewController {
    
    @IBOutlet var mapView: MapView!
    var updateFriendsTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFriendsTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(updateFriendsLocation), userInfo: nil, repeats: true)
        map.setupMapboxMapHelper(mapView: mapView)
        map.initLocationManager()
        map.updateFriendsLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        map.moveCameraToUser()
    }
    
    @objc func updateFriendsLocation(){
        map.updateFriendsLocation()
        //AlertHelper.showAlertMessage(title: "FireidsTimer", message: "Location updated!")
    }
}
