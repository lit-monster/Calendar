//
//  TargetViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/08/24.
//

import Foundation
import UIKit
//import RealmSwift

class TargetViewController: UIViewController {
    
    @IBOutlet weak var picker: UIDatePicker! {
        didSet {
            picker.datePickerMode = .countDownTimer
        }
    }

    @IBOutlet weak var calendarBackgroundBlurView: UIVisualEffectView! {
        didSet {
            calendarBackgroundBlurView.layer.cornerRadius = 16
            calendarBackgroundBlurView.layer.cornerCurve = .continuous
            calendarBackgroundBlurView.clipsToBounds = true
        }
    }

    let calendarView = UICalendarView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendarView.calendar = gregorianCalendar
        calendarView.locale = Locale(identifier: "ja_JP")
        calendarView.fontDesign = .rounded
        calendarView.delegate = self
        calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarBackgroundBlurView.contentView.addSubview(calendarView)
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: calendarBackgroundBlurView.contentView.topAnchor, constant: 16),
            calendarBackgroundBlurView.contentView.bottomAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 16),
            calendarView.leadingAnchor.constraint(equalTo: calendarBackgroundBlurView.contentView.leadingAnchor, constant: 16),
            calendarBackgroundBlurView.contentView.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor, constant: 16),
        ])
    }

    @IBAction func start() {
        performSegue(withIdentifier: "tocountdown", sender: .none)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tocountdown"{
            let vc = segue.destination as! StopWatchViewController
            vc.targetTimeInterval = picker.countDownDuration
        }
    }
}

extension TargetViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return .image(UIImage.init(systemName: "sun.max.fill"), color: .systemOrange, size: .large)
    }
}

extension TargetViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        if let month = dateComponents?.month, let day = dateComponents?.day {
            print("\(month)月\(day)日")
        }
    }
}
