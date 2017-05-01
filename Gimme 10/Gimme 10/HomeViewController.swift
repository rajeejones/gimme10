//
//  HomeViewController.swift
//  Gimme 10
//
//  Created by Rajee Jones on 4/30/17.
//  Copyright © 2017 Rajee Jones. All rights reserved.
//

import UIKit
import CoreData

let logWorkoutSegueIdentifier = "logWorkoutSegue"
let challengeCompleteSegueIdentifier = "challengeCompleteSegue"

class HomeViewController: UIViewController {

  @IBOutlet weak var nextSetLabel: UILabel!
  
  @IBOutlet weak var missLabel: UILabel!
  
  @IBOutlet weak var logWorkoutButton: UIButton!
  @IBOutlet weak var challengeSetupButton: UIButton!
  @IBOutlet weak var completedChallengesButton: UIButton!
  
  var managedContext: NSManagedObjectContext!
  var currentChallenge: Challenge?
  
    override func viewDidLoad() {
        super.viewDidLoad()

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
    //setup view based on current challenge
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
