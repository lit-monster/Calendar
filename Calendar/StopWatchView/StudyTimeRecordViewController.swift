//
//  TimerViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/08/24.
//


import UIKit
import CoreLocation
import FirebaseAuth
import FirebaseFirestore


class StudyTimeRecordViewController: UIViewController {

    // StopWatchVCから受け渡される値
    var targetTimeInterval: CFTimeInterval = 0
    var count: Int = 0
    var focusRate = 0


    var locationManager = CLLocationManager()
    let feedbackGenerator = UINotificationFeedbackGenerator()
    let db = Firestore.firestore()

    var currentLongitude: CLLocationDegrees = 0
    var currentLatitude: CLLocationDegrees = 0

    var startTime = TimeInterval()
    var timer: Timer = Timer()
    var latestHeartRate: Double = 0.0

    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var heartRateLabel: UILabel!

    @IBOutlet weak var focusLabel: UILabel!
    @IBOutlet weak var haertRateStackView: UIStackView!
    @IBOutlet weak var heartRateSwith: UISwitch!
    
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var recoLabal: UILabel!
    @IBOutlet weak var totalBlurView: UIVisualEffectView! {
        didSet {
            totalBlurView.layer.cornerCurve = .continuous
            totalBlurView.layer.cornerRadius = 32
            totalBlurView.clipsToBounds = true
        }
    }

    //view
    @IBOutlet weak var heart: UIView! {
        didSet {
            heart.layer.cornerRadius = 16
            heart.layer.cornerCurve = .continuous
            heart.layer.shadowColor = UIColor.black.cgColor
            heart.layer.shadowOpacity = 0.1
            heart.layer.shadowRadius = 8
            heart.layer.shadowOffset = CGSize(width: 4, height: 4)
        }
    }

    @IBOutlet weak var rate: UIView! {
        didSet {
            rate.layer.cornerRadius = 16
            rate.layer.cornerCurve = .continuous
            rate.layer.shadowColor = UIColor.black.cgColor
            rate.layer.shadowOpacity = 0.1
            rate.layer.shadowRadius = 8
            rate.layer.shadowOffset = CGSize(width: 4, height: 4)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        feedbackGenerator.prepare()
        setUpLocation()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        heartRateLabel.text = String(Int(latestHeartRate))
        if focusRate == 3 {
//            starLabel.text = "★★★"
            recoLabal.text = "超集中"
        } else if focusRate == 2 {
//            starLabel.text = "★★"
            recoLabal.text = "集中"
        } else if focusRate == 1 {
//            starLabel.text = "★"
            recoLabal.text = "普通"
        }

        let interval = count
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        totalTimeLabel.text =  String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    func setUpLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
        locationManager.activityType = .fitness
        locationManager.startUpdatingHeading()

        if locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else {
            fatalError()
        }
    }

    @IBAction func quality3() {
        print("超集中")
        saveRecord(quality: 3)
        navigationController?.popToViewController(navigationController!.viewControllers[0], animated: true)

    }

    @IBAction func quality2() {
        print("集中")
        saveRecord(quality: 2)
        navigationController?.popToViewController(navigationController!.viewControllers[0], animated: true)

    }

    @IBAction func quality1() {
        print("普通")
        saveRecord(quality: 1)
        navigationController?.popToViewController(navigationController!.viewControllers[0], animated: true)

    }

    private func saveRecord(quality: Int) {
        focusRate = quality
        StudyRecordManager.shared.saveRecord(quality: quality, count: count, lat: currentLatitude, long: currentLongitude)
        createStudyRecord()
        count = 0
        feedbackGenerator.notificationOccurred(.warning)
    }

    func createStudyRecord() {
        print("保存する記録")
        print("日時")
        print(Date())
        print("目標時間")
        print(targetTimeInterval)
        print("勉強時間")
        print(count)
        print("集中度")
        print(focusRate)
        print("心拍数")
        print(latestHeartRate)
        print("緯度")
        print(currentLongitude)
        print("経度")
        print(currentLatitude)
        print("ユーザーのID")
        print(Auth.auth().currentUser!.uid)

        // 書き込むコード。uid(ユーザーのID)とtime(勉強時間)とconcentrate(集中度)
        self.db.collection("studyRecords").document().setData([
            "date": Date(),
            "targetTime": targetTimeInterval,
            "durationTime": count,
            "concentrate": focusRate,
            "heartRate": latestHeartRate,
            "longitude": currentLongitude,
            "latitude": currentLatitude,
            "uid": Auth.auth().currentUser!.uid

        ]) { err in
            if let err = err {
                print("エラー: \(err)")
            } else {
                print("書き込み成功！")
            }
        }
    }

}

extension StudyTimeRecordViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else {
            return
        }

        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)

        self.currentLatitude = location.latitude
        self.currentLongitude = location.longitude
    }
}
