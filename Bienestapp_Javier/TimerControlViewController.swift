import UIKit
import Alamofire

class TimerControlViewController: UIViewController {
    
    @IBOutlet weak var max_hour_text: UITextField!
    @IBOutlet weak var from_hour_text: UITextField!
    @IBOutlet weak var to_hour_text: UITextField!
    
    private var datePicker: UIDatePicker?
    private var SegdatePicker: UIDatePicker?
    private var TerdatePicker: UIDatePicker?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .time
        datePicker?.addTarget(self, action: #selector(TimerControlViewController.dateChanged(datePicker:)), for: .valueChanged)
        datePicker?.locale = NSLocale.init(localeIdentifier: "es_ES") as Locale
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TimerControlViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        max_hour_text.inputView = datePicker
        /////////////////
        SegdatePicker = UIDatePicker()
        SegdatePicker?.datePickerMode = .time
        SegdatePicker?.addTarget(self, action: #selector(TimerControlViewController.SegdateChanged(datePicker:)), for: .valueChanged)
        SegdatePicker?.locale = NSLocale.init(localeIdentifier: "es_ES") as Locale
        
        let SegtapGesture = UITapGestureRecognizer(target: self, action: #selector(TimerControlViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(SegtapGesture)
        from_hour_text.inputView = SegdatePicker
        /////////////////
        TerdatePicker = UIDatePicker()
        TerdatePicker?.datePickerMode = .time
        TerdatePicker?.addTarget(self, action: #selector(TimerControlViewController.TerdateChanged(datePicker:)), for: .valueChanged)
        TerdatePicker?.locale = NSLocale.init(localeIdentifier: "es_ES") as Locale
        
        let TerdateChanged = UITapGestureRecognizer(target: self, action: #selector(TimerControlViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(TerdateChanged)
        to_hour_text.inputView = TerdatePicker
        
    }
    
    @objc func viewTapped (gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged (datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        max_hour_text.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func SegdateChanged (datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        from_hour_text.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func TerdateChanged (datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        to_hour_text.text = dateFormatter.string(from: datePicker.date)
    }
    
    @IBAction func save_changes_details(_ sender: Any) {
//        print(global_id_app)
//        print(max_hour_text.text!)
//        print(from_hour_text.text!)
//        print(to_hour_text.text!)
        addRestriction(maxTime: max_hour_text.text!, fromTime: from_hour_text.text!, toTime: to_hour_text.text!)
    }
    
    func addRestriction(maxTime: String, fromTime: String, toTime: String) {
        
        let url = URL(string: "http://localhost:8888/BienestarDigital/public/index.php/api/restrictions/"+global_id_app)
        
        let userToken : String = UserDefaults.standard.value(forKey: "token") as! String
        let userTokenHeaders = ["Authorization" : userToken]
        
        let json = ["MaxTime": maxTime, "InitTime": fromTime, "EndTime": toTime]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: userTokenHeaders).responseJSON {
            (response) in
            
            switch(response.response?.statusCode){
            case 200:
                    self.performSegue(withIdentifier: "returnDetails", sender: nil)
                    print("guardado")
            case 401:
                if let json = response.result.value as? [String: Any] {
                    
                    let message = json["message"] as! String
                    print(message)
                }
            default:
                print("DEFAULT")
                
            }
        }
    }
    
    
    
    
    
}
