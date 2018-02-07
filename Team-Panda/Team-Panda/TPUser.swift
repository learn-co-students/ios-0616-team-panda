//
//  User.swift
//  Team-Panda
//
//  Created by Salmaan Rizvi on 8/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class TPUser {
    
    var email : String
    var uid : String
    
    var tellUsAnswer : String
    var wouldYouRatherAnswer : String
    var interestsAnswer : [String]
    var favoritesArray : [String]
    
    var socCodes : [Int]
    
    var dictionary : [String : Any] {
        return ["email"             : self.email,
                "tell us"           : self.tellUsAnswer,
                "would you rather"  : self.wouldYouRatherAnswer,
                "interests"         : self.interestsAnswer,
                "soc codes"         : self.socCodes,
                "favorites"         : self.favoritesArray]
    }
    
    init(withEmail email : String, uid : String) {
        
        self.email = email
        self.uid = uid
        
        self.tellUsAnswer = ""
        self.wouldYouRatherAnswer = ""
        self.interestsAnswer = [""]
        self.socCodes = [0]
        self.favoritesArray = [""]
    }
    
    func updateDatabase() {
        
        let ref = Database.database().reference(fromURL: databaseRefURL)
        
        ref.child("users/\(self.uid)").updateChildValues(self.dictionary) { (error, dbRef) in
            if let error = error {
                print("Error error error: \(error.localizedDescription)")
            } else {
                //  print("This is the database reference description: \(dbRef.description())")
                //print("This is the new user's Dictionary: \(self.dictionary)")
            }
        }
        
        DataStore.store.tpUser = self
    }
    
    func updateUserProfile(withEmail newEmail : String, completion: @escaping (UIAlertController, String)->()) {
        
        guard let user = Auth.auth().currentUser else {fatalError("Couldn't get current user.") }
        
        DataStore.store.tpUser?.email = newEmail
        self.email = newEmail
        
        user.updateEmail(to: self.email) { (error) in
            if let error = error {
                
                print(error.localizedDescription)
                
                let errorAlert = Constants.displayAlertWithVerify("Something Went Wrong!", message: error.localizedDescription)
                
                completion(errorAlert, "Error")
                
            }
            else {
                let alert = Constants.displayAlertWith("Success!", message: "Your email was saved as \(self.email)", actionLabel: "Done", style: .default, actionHandler: { })
                
                self.updateDatabase()
                
                completion(alert, "Success")
            }
        }
    }
    
    class func userFromDictionary(_ dictionary : [String : Any], uid : String) -> TPUser? {
        
        let email = dictionary["email"] as? String
        
        let tellUsAnswer = dictionary["tell us"] as? String
        let wouldYouRatherAnswer = dictionary["would you rather"] as? String
        let interests = dictionary["interests"] as? [String]
        let codes = dictionary["soc codes"] as? [Int]
        let favoritesArray = dictionary["favorites"] as? [String] ?? [""]
        
        if  let email = email,
            let tellUs = tellUsAnswer,
            let wouldYouRather = wouldYouRatherAnswer,
            let interests = interests,
            let codes = codes
        {
            
            let pandaUser = TPUser(withEmail: email, uid: uid)
            pandaUser.tellUsAnswer = tellUs
            pandaUser.wouldYouRatherAnswer = wouldYouRather
            pandaUser.interestsAnswer = interests
            pandaUser.socCodes = codes
            pandaUser.favoritesArray = checkAndRemoveEmptyStringFromFirebaseArray(favoritesArray)
            
            return pandaUser
        }
        else {
            print("Couldn't create user from dictionary")
            return nil
        }
    }
    
    class func checkAndRemoveEmptyStringFromFirebaseArray(_ array: [String]) -> [String] {
        
        var favoritesArray2 = array
        for code in favoritesArray2 {
            if code == "" {
                let indexOfCode = favoritesArray2.index(of: code)
                
                if let index = indexOfCode {
                    favoritesArray2.remove(at: index)
                }
            }
        }
        return favoritesArray2
    }
    
    class func getUserFromFirebase(_ uid : String, completion: @escaping (TPUser?)->()) {
        
        if uid == Secrets.genericUserUID {
            completion(TPUser(withEmail: Secrets.genericUserEmail, uid: Secrets.genericUserUID))
        }
        else {
            let ref = Database.database().reference(fromURL: databaseRefURL)
            
            ref.child("users/\(uid)").observeSingleEvent(of: .value, with: { (userSnapshot) in
                
                if let userSnapshot = userSnapshot.value as? [String : Any] {
                    
                    completion(TPUser.userFromDictionary(userSnapshot, uid: uid))
                    
                }
                
            }) { (error) in
                
                print("Error in getting snapshot for UID \(uid)")
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
