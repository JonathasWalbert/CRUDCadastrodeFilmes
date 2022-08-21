//
//  UIViewController+Context.swift
//  AppAula
//
//  Created by jonathas on 22/07/22.
//

import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
}
