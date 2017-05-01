//
//  HomeViewController.swift
//  Gimme 10
//
//  Created by Rajee Jones on 4/30/17.
//  Copyright © 2017 Rajee Jones. All rights reserved.
//

import UIKit
import CoreData
import Firebase

let logWorkoutSegueIdentifier = "logWorkoutSegue"
let challengeCompleteSegueIdentifier = "challengeCompleteSegue"

class HomeViewController: UIViewController {

  @IBOutlet weak var nextSetLabel: UILabel!
  
  @IBOutlet weak var missLabel: UILabel!
  
  @IBOutlet weak var logWorkoutButton: UIButton!
  @IBOutlet weak var challengeSetupButton: UIButton!
  @IBOutlet weak var completedChallengesButton: UIButton!
  
  @IBOutlet weak var bannerAdView: GADBannerView!
  var managedContext: NSManagedObjectContext!
  var currentChallenge: Challenge?
  var setTimer = Timer()
  
  override func viewDidLoad() {
    super.viewDidLoad()
      
    //Switch between Test and Release
    configureBannerAd()

    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    
    managedContext = appDelegate.persistentContainer.viewContext
    
    do {
      let request:NSFetchRequest<Challenge> = Challenge.fetchRequest()
      request.predicate = NSPredicate(format: "isCurrent == true")
      
      let results = try managedContext.fetch(request)
      currentChallenge = results.first
      
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
    
    nextSetLabel.isHidden = currentChallenge == nil
    configureNextSetLabel()
    //setup view based on current challenge
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func configureBannerAd() {
    
    if let id = adMobPlist?[bannerAdKey] as? String {
      bannerAdView.adUnitID = id
    }
    
    let request = GADRequest()
    
    #if DEBUG
      print("In debug Jones!")
      request.testDevices = [kGADSimulatorID, "33e2d80be81844b513faf16c5ddd8ab2"]
      
    #else
      print("NOT DEBUG!")
    #endif
    
    bannerAdView.rootViewController = self
    bannerAdView.load(request)
  }
  
  func configureLabels() {
    
  }
  
  func configureNextSetLabel() {
    if let _ = currentChallenge {
      
      nextSetLabel.isHidden = false
      updateSetLabel()
      runSetTimer()
    }
  }
  
  func updateSetLabel() {
    if let challenge = currentChallenge {
      let endDate = challenge.endDate! as Date
      let now = Date()
    
      let formatter = DateComponentsFormatter()
      formatter.unitsStyle = .full
      //formatter.allowedUnits = [.hour,.minute,.second]
      formatter.allowedUnits = [.minute,.second]
      formatter.maximumUnitCount = 2
    
      let diff = formatter.string(from: now, to: endDate)
      print("Its due in: \(String(describing: diff))")
      nextSetLabel.text = "Next Set:" + diff!
      
      let calendar = Calendar.current
      let components = calendar.dateComponents([.second], from: now, to: endDate)
      if components.second! <= 0 {
        setTimer.invalidate()
        nextSetLabel.text = "Log your set!"
        //start log timer
      }
    }
  }
  
  func runSetTimer() {
    setTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSetLabel), userInfo: nil, repeats: true)
  }
    
  @IBAction func logWorkoutPressed(_ sender: Any) {
    if let _ = currentChallenge {
      self.performSegue(withIdentifier: logWorkoutSegueIdentifier, sender: self)
    }
  }
  
  @IBAction func completedChallengesPressed(_ sender: Any) {
    if let _ = currentChallenge {
      self.performSegue(withIdentifier: challengeCompleteSegueIdentifier, sender: self)
    }
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
