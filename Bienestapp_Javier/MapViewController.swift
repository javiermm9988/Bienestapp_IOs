import UIKit
import Alamofire
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var map_view: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocationsUse()
        
        let localizacion = CLLocationCoordinate2DMake(40.4167, -3.70325)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: localizacion, span: span)
        map_view.setRegion(region, animated: true)
    }
    
    
    
    var jsonArray: NSArray?
    var latitudeArray: Array<String> = []
    var longitudeArray: Array<String> = []
    
    func getLocationsUse() {
        let url = "http://localhost:8888/BienestarDigital/public/index.php/api/useLocation"
        
        let userToken : String = UserDefaults.standard.value(forKey: "token") as! String
        let userTokenHeaders = ["Authorization" : userToken]
        
        Alamofire.request(url, headers:userTokenHeaders).responseJSON { response in
            
            if let json = response.result.value {
                self.jsonArray = json as? NSArray
                for item in self.jsonArray! as! [NSDictionary] {
                    let latitude = item["latitude"] as? String
                    let longitude = item["longitude"] as? String
                    
                    self.latitudeArray.append(latitude ?? "0")
                    self.longitudeArray.append(longitude ?? "0")
                }
                if (response.response?.statusCode == 200) {
                    self.createPoints()
                }
            }
        }
    }
    
    func createPoints () {
        
        var locations = 0
        let latitudes = latitudeArray.count
        let longuitudes = longitudeArray.count
        
        if (latitudes == longuitudes) {
            locations = latitudes-1
        }
        
        for locations in 0...locations {
            let NumberLoc = String(locations+1)
            let annotation = MKPointAnnotation()
            annotation.title = "Localización "+NumberLoc
            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitudeArray[locations]) as! CLLocationDegrees, longitude: CLLocationDegrees(longitudeArray[locations]) as! CLLocationDegrees)
            self.map_view.addAnnotation(annotation)
        }
    }
}

