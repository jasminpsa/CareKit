import Foundation
 



enum CareTeamRelation: String  {
    case doctor, physician, nurse
    
   /* var contact: CNContactRelation {
        return CNContactRelation(name: self.rawValue)
    }
    
    
    static var allContacts: [CNContactRelation] {
        return [
            CNContactRelation(name: self.doctor.rawValue),
            CNContactRelation(name: self.physician.rawValue),
            CNContactRelation(name: self.nurse.rawValue)
        ]
    }*/
}

@objc public class Contact: OCKContact {
    var id:String = ""
    
}
