//
//  User.swift
//  Team-Panda
//
//  Created by Salmaan Rizvi on 8/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Firebase

class TPUser {
    
    var email : String
    var uid : String
    
    var tellUsAnswer : String
    var wouldYouRatherAnswer : String
    var interestsAnswer : [String]
    
    var dictionary : [String : AnyObject] {
        return ["email"             : self.email,
                "tell us"           : self.tellUsAnswer,
                "would you rather"  : self.wouldYouRatherAnswer,
                "interests"         : self.interestsAnswer]
    }
    
    init(withEmail email : String, uid : String) {
        
        self.email = email
        self.uid = uid
        
        self.tellUsAnswer = ""
        self.wouldYouRatherAnswer = ""
        self.interestsAnswer = [""]
    }
    
    func updateDatabase() {
        
        let ref = FIRDatabase.database().referenceFromURL(databaseRefURL)
        
        ref.child("users/\(self.uid)").updateChildValues(self.dictionary) { (error, dbRef) in
            if let error = error {
                print("Error error error: \(error.localizedDescription)")
            } else {
                print("This is the database reference description: \(dbRef.description())")
                print("This is the new user's Dictionary: \(self.dictionary)")
            }
        }
    }
    
    func updateUserProfile() {
        
        guard let user = FIRAuth.auth()?.currentUser else {fatalError("Couldn't get current user.") }
        
        user.updateEmail(self.email) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        self.updateDatabase()
    }
    
    class func userFromDictionary(dictionary : [String : AnyObject], uid : String) -> TPUser? {
        
        let email = dictionary["email"] as? String
        
        let tellUsAnswer = dictionary["tell us"] as? String
        let wouldYouRatherAnswer = dictionary["would you rather"] as? String
        let interests = dictionary["interests"] as? [String]
        
        if let email = email,
            let tellUs = tellUsAnswer, let wouldYouRather = wouldYouRatherAnswer, let interests = interests
        {
            
            let pandaUser = TPUser(withEmail: email, uid: uid)
            pandaUser.tellUsAnswer = tellUs
            pandaUser.wouldYouRatherAnswer = wouldYouRather
            pandaUser.interestsAnswer = interests
            
            return pandaUser
        }
        else {
            print("Couldn't create user from dictionary")
            return nil
        }
    }
    
    class func getUserFromFirebase(uid : String, completion: (TPUser?)->()) {
        
        let ref = FIRDatabase.database().referenceFromURL(databaseRefURL)
        
        ref.child("users/\(uid)").observeSingleEventOfType(.Value, withBlock: { (userSnapshot) in
            
            if let userSnapshot = userSnapshot.value as? [String : AnyObject] {
                
                completion(TPUser.userFromDictionary(userSnapshot, uid: uid))
            } else {
                print("This is the user snapshot: \(userSnapshot)")
            }
            
        })
        
    }
}