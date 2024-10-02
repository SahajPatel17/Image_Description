import Foundation
import CoreLocation

final class locationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager()
    var city: String = "Error"
    var country: String = "Error"
    
    
    override init(){
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func convertLatLongToAddress(latitude:Double,longitude:Double){
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // City
            if let citytemp = placeMark.locality {
                self.city = citytemp
            }
            // Country
            if let countrytemp = placeMark.country {
                self.country = countrytemp
            }
        })
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else {
            
            return
        }
        convertLatLongToAddress(latitude: latestLocation.coordinate.latitude, longitude: latestLocation.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
