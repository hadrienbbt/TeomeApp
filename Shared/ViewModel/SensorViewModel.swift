import SwiftUI
import Firebase
import Combine

typealias Completion<R> = (Error?, R?) -> Void

class SensorViewModel: ObservableObject {
    @Published var sensors = ValueStore().sensors {
        didSet {
            ValueStore().sensors = sensors
        }
    }
    @Published var loading = false
    
    lazy var firestore = Firestore.firestore()
    
    func fetchSensors() {
        loading = true
        firestore.collection("sensors")
            .document("13861322")
            .getDocument { snap, error in
                guard let snap = snap else {
                    print(error?.localizedDescription ?? "Unknown error")
                    return
                }
                guard let value = snap.data(),
                      let humidity = value["humidity"] as? Double,
                      let temperature = value["temperature"] as? Double,
                      let illuminance = value["illuminance"] as? Double else { return }
                
                print("Humidity: \(humidity)")
                print("Temperature: \(temperature)")
                print("Illuminance: \(illuminance)")
                self.sensors = Sensor.samples
            }
    }
    
    func receiveSensors(_ sensors: [Sensor]) {
        self.sensors = sensors
    }
    
    func receiveCompletion(_ completion: Subscribers.Completion<Error>) -> Void {
        switch completion {
        case .failure(let error): print("❌ Error fetching backend: \(error)")
        case .finished:
           
            print("✅ Fetching finished with \(self.sensors.count) sensors")
        }
        self.loading = false
    }
}
