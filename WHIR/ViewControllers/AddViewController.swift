//
//  AddViewController.swift
//  WHIR
//
//  Created by Bruce Röttgers on 14.02.18.
//  Copyright © 2018 Dirk Hulverscheidt. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController, ManagedObjectContextSettable {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var summarizeTextView: UITextView!
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //dismiss view
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //saving item
    @IBAction func save(_ sender: Any) {
        //text fields cant be nil
        guard let title = titleTextField.text, let summary = summarizeTextView.text else { return }
        
        //save item
        let item = NSEntityDescription.insertNewObject(forEntityName: "Book", into: managedObjectContext) as? Book
        item?.title = title
        item?.summary = summary
        item?.date = NSDate()
        managedObjectContext.saveChanges(viewController: self)
        print("Book successfully saved!")
        
        // call the review requester that sees if the app should now ask for a review
        MarketingAlertHelper().tryToDisplayPrompts(with: self)
        
        //dismiss view
        dismiss(animated: true, completion: nil)
    }

}
