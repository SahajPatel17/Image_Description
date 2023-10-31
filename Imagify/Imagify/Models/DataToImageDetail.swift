import Foundation
import AVFoundation
import UIKit
import MapKit

class DataToImageDetail: ObservableObject, Identifiable{
    var id = UUID()
    var textArray: String
    let DateTaken = Date.now
    var image : UIImage
    var cityCountry: String = "Error"
    init(city: String, country: String, image: UIImage, text: String){
        self.cityCountry = city + ", " + country
        self.image = image
        self.textArray = text
    }
    
    
}

