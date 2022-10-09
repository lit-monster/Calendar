//
//  Timer..swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/08/24.
//

import RealmSwift
import UIKit
import CoreLocation


class TimerViewController: UIViewController,CLLocationManagerDelegate {
    var locationManager = CLLocationManager()

    let feedbackGenerator = UINotificationFeedbackGenerator()

    var count: Int = 0
    var latestHeartRate: Double = 0.0
    var focusRate = 0
    
    var timer: Timer = Timer()
    var targetTimeInterval: CFTimeInterval = 0
    var startTime = TimeInterval()

    var currentLongitude: CLLocationDegrees = 0
    var currentLatitude: CLLocationDegrees = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        feedbackGenerator.prepare()
        locationManager.delegate = self

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else {
            return
        }

        let location:CLLocationCoordinate2D
        = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)

        let formatter: DateFormatter = DateFormatter()
        formatter.timeZone   = TimeZone(identifier: "Asia/Tokyo")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let date = formatter.string(from: newLocation.timestamp)
        self.currentLatitude = location.latitude
        self.currentLongitude = location.longitude

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        heartRateLabel.text = String(Int(latestHeartRate))
        if focusRate == 3 {
            starLabel.text = "★★★"
            recoLabal.text = "超集中"
        } else if focusRate == 2 {
            starLabel.text = "★★"
            recoLabal.text = "集中"
        } else if focusRate == 1 {
            starLabel.text = "★"
            recoLabal.text = "普通"
        }

        let interval = count
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        totalTimeLabel.text =  String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    @IBOutlet weak var totalTimeLabel: UILabel!

    @IBOutlet weak var heartRateLabel: UILabel!

    @IBOutlet weak var starLabel: UILabel!

    @IBOutlet weak var recoLabal: UILabel!

    @IBAction func quality3(){
        print("超集中")
        saveRecord(quality: 3)
        navigationController?.popToViewController(navigationController!.viewControllers[0], animated: true)
    }

    @IBAction func quality2(){
        print("集中")
        saveRecord(quality: 2)
        navigationController?.popToViewController(navigationController!.viewControllers[0], animated: true)

    }

    @IBAction func quality1(){
        print("普通")
        saveRecord(quality: 1)
        navigationController?.popToViewController(navigationController!.viewControllers[0], animated: true)

    }

    private func saveRecord(quality: Int) {
        print(currentLatitude, currentLongitude)
        print("aaasdfasdfasd")
        StudyRecordManager.shared.saveRecord(quality: quality, count: count, lat: currentLatitude, long: currentLongitude)
        count = 0
        feedbackGenerator.notificationOccurred(.warning)
    }
}
