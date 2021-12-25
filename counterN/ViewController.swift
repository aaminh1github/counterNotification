//
//  ViewController.swift
//  counterN
//
//  Created by amnah alhwaiml on 18/05/1443 AH.
//
import UserNotifications
import UIKit






class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UNUserNotificationCenterDelegate  {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        isTimeCounting = false
        print("recive")
        completionHandler()
    
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        isTimeCounting = true
        completionHandler([.alert, .badge, .sound])
        
        print("present")
    }
    
    var initTime = 0
    
    
    var options = [20,40,60,80,100,120]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return  1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return "\(options[row]) seconds"
       
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        initTime = options[row]
    }
    var isTimeCounting = false
    
    
    var count = 0
    

    let userNotificationCenter = UNUserNotificationCenter.current()

    @IBOutlet weak var timePickView: UIPickerView!
    @IBOutlet weak var countDownLabl: UILabel!
    

    @IBAction func startButtonPressed(_ sender: UIButton) {
        if !isTimeCounting{
        count = initTime
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true) }
        else {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        countDownLabl.text = "0"
        
        timePickView.delegate = self
        timePickView.dataSource = self
        userNotificationCenter.delegate = self
       count = initTime
        initNoti()
        
    }
    func initNoti(){
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        self.userNotificationCenter.requestAuthorization(options: authOptions, completionHandler: {
            (success, error) in
            if let error = error {
                print("Notification Error : ", error)
            }
        })
    }
    func starttimeing(){
        
    
    
    
    }
    

    @objc func update() {
        if(count >= 0) {
            isTimeCounting = true
            countDownLabl.text = String(count)
            count -= 1
        } else {
            isTimeCounting = false
            let center = UNUserNotificationCenter.current()
            let content = UNMutableNotificationContent()
            content.title = "Great job"
            content.body = "You can take a break now"
            content.sound = .default
            content.userInfo = ["value": "Data with local notification"]
            let fireDate = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: Date().addingTimeInterval(2))
            let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)
            let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
            center.add(request) { (error) in
            if error != nil {
                print("Error = \(error?.localizedDescription ?? "error local notification")")}
            
                }
            
        }
    }}
    


    




