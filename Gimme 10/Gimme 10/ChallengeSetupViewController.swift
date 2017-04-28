//
//  ChallengeSetupViewController.swift
//  Gimme 10
//
//  Created by Rajee Jones on 4/28/17.
//  Copyright © 2017 Rajee Jones. All rights reserved.
//

import UIKit

class ChallengeSetupViewController: UIViewController {

  
  @IBOutlet weak var workoutTextField: UITextField!
  @IBOutlet weak var dailyRepsTextField: UITextField!
  @IBOutlet weak var repsPerSetTextField: UITextField!
  @IBOutlet weak var durationTextField: UITextField!
  @IBOutlet weak var startTimeTextField: UITextField!
  

  
  @IBOutlet weak var submitButton: UIButton!
  
  @IBOutlet weak var descriptionLabel: UILabel!
  
  // variable to keep track if is in workout
  var workoutPicker = UIPickerView()
  var dailyRepsPicker = UIPickerView()
  var repsPerSetPicker = UIPickerView()
  var daysPicker = UIPickerView()
  var startTimePicker = UIPickerView()
  
  var activeTextField: UITextField?
  var previousTextField: UITextField?
  var nextTextField: UITextField?
  
  var workouts = ["","Pushup Challenge", "Crunches Challenge", "Squat Challenge", "Lunges Challenge"]
  var dailyReps = ["",10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200] as [Any]
  var repsPerSet = ["",2,5,10,15,20] as [Any]
  var days = ["",1,3,5,7,10,14,21,30] as [Any]
  var startTime = ["",5,6,7,8,9,10,11,12] as [Any]
  
  let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target:nil, action:nil)
  
  let previousButton = UIBarButtonItem(title: "Previous", style: UIBarButtonItemStyle.plain, target: self, action: #selector(previousPicker))
  let nextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.done, target: self, action: #selector(nextPicker))
  let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(donePicker))
  let customToolbar = UIToolbar()
  
  override func viewDidLoad() {
      super.viewDidLoad()

      setup()
      // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  }
  
  private func setup() {
    
    workoutPicker.delegate = self
    workoutPicker.dataSource = self
    
    dailyRepsPicker.delegate = self
    dailyRepsPicker.dataSource = self
    
    repsPerSetPicker.delegate = self
    repsPerSetPicker.dataSource = self
    
    daysPicker.delegate = self
    daysPicker.dataSource = self
    
    startTimePicker.delegate = self
    startTimePicker.dataSource = self
    
    customToolbar.barStyle = UIBarStyle.default
    customToolbar.isTranslucent = true
    customToolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
    customToolbar.sizeToFit()
    
    customToolbar.setItems([flexSpace, flexSpace, nextButton], animated: true)
    
    workoutTextField.inputView = workoutPicker
    workoutTextField.inputAccessoryView = customToolbar
    workoutTextField.delegate = self
    
    dailyRepsTextField.inputView = dailyRepsPicker
    dailyRepsTextField.inputAccessoryView = customToolbar
    dailyRepsTextField.delegate = self
    
    repsPerSetTextField.inputView = repsPerSetPicker
    repsPerSetTextField.inputAccessoryView = customToolbar
    repsPerSetTextField.delegate = self
    
    durationTextField.inputView = daysPicker
    durationTextField.inputAccessoryView = customToolbar
    durationTextField.delegate = self
    
    startTimeTextField.inputView = startTimePicker
    startTimeTextField.inputAccessoryView = customToolbar
    startTimeTextField.delegate = self
    
    submitButton.isEnabled = false
    submitButton.backgroundColor = UIColor.lightGray
    submitButton.alpha = 0.45
  }
  
  
  func donePicker (sender: UIBarButtonItem) {
    
    
    if ((workoutTextField.text != "") && (dailyRepsTextField.text != "") && (repsPerSetTextField.text != "") && (durationTextField.text != "") && (startTimeTextField.text != "")) {
      let range = durationTextField.text!.range(of: "challenge")
      let durationText = durationTextField.text!.replacingCharacters(in: range!, with: "")
      
      let text = "\(durationText)\(workoutTextField.text!) at \(dailyRepsTextField.text!) reps per day!"
      descriptionLabel.text = text
      submitButton.isEnabled = true
      submitButton.backgroundColor =  UIColor(red: 0/255, green: 168/255, blue: 64/255, alpha: 1)
      submitButton.alpha = 1.0
      
    }
    activeTextField?.resignFirstResponder()
    
  }
  
  func nextPicker (sender: UIBarButtonItem) {
    nextTextField?.becomeFirstResponder()
  }
  
  func previousPicker (sender: UIBarButtonItem) {
    previousTextField?.becomeFirstResponder()
  }
 

  @IBAction func submitButtonPressed(_ sender: Any) {
    
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
   
    */
  
}

extension ChallengeSetupViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    
    if textField == workoutTextField {
      previousTextField = nil
      nextTextField = dailyRepsTextField
      customToolbar.setItems([flexSpace, flexSpace, nextButton], animated: true)
    } else if textField == dailyRepsTextField {
      previousTextField = workoutTextField
      nextTextField = repsPerSetTextField
      customToolbar.setItems([previousButton, flexSpace, nextButton], animated: true)
    } else if textField == repsPerSetTextField {
      previousTextField = dailyRepsTextField
      nextTextField = durationTextField
      customToolbar.setItems([previousButton, flexSpace, nextButton], animated: true)
    } else if textField == durationTextField {
      previousTextField = repsPerSetTextField
      nextTextField = startTimeTextField
      customToolbar.setItems([previousButton, flexSpace, nextButton], animated: true)
    } else if textField == startTimeTextField {
      previousTextField = durationTextField
      nextTextField = nil
      customToolbar.setItems([previousButton, flexSpace, doneButton], animated: true)
    }
    
    activeTextField = textField
    
    
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
    var rows: Int = 0
    
    if pickerView == workoutPicker {
      rows = self.workouts.count
    } else if pickerView == dailyRepsPicker {
      rows = dailyReps.count
    } else if pickerView == repsPerSetPicker {
      rows = repsPerSet.count
    } else if pickerView == daysPicker {
      rows = days.count
    } else if pickerView == startTimePicker {
      rows = startTime.count
    }
    
    return rows
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView == workoutPicker {
      workoutTextField.text = workouts[row]
    } else if pickerView == dailyRepsPicker {
      dailyRepsTextField.text = String(describing: dailyReps[row])
    } else if pickerView == repsPerSetPicker {
      repsPerSetTextField.text = String(describing: repsPerSet[row])
    } else if pickerView == daysPicker {
      let challenge = String(describing: days[row])
      durationTextField.text = challenge == "" ? "" : "\(challenge) day challenge"
    } else if pickerView == startTimePicker {
      let time = String(describing: startTime[row])
      startTimeTextField.text = time == "" ? "" : "\(time) a.m"
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
    var titleRow = ""
    
    if pickerView == workoutPicker {
      titleRow = workouts[row]
    } else if pickerView == dailyRepsPicker {
      let rep = String(describing: dailyReps[row])
      titleRow = rep
    } else if pickerView == repsPerSetPicker {
      let set = String(describing: repsPerSet[row])
      titleRow = set
    } else if pickerView == daysPicker {
      let challenge = String(describing: days[row])
      titleRow = challenge == "" ? "" : "\(challenge) day challenge"
    } else if pickerView == startTimePicker {
      let time = String(describing: startTime[row])
      titleRow = time == "" ? "" : "\(time) a.m"
    }
    return titleRow
  }
  
}
