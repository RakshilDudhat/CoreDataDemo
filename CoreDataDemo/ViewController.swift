//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Raxil Dudhat on 11/02/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var addressTextFiled: UITextField!
    @IBOutlet weak var salaryTextFiled: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    var arrStudents: [StudentsDetails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func insertUsers() {
        //        AppDelegate
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let viewContext = appDelegate.persistentContainer.viewContext
        
        let studentEntity = NSEntityDescription.entity(forEntityName: "Students", in: viewContext)!
        
        let studentManagedObject = NSManagedObject(entity: studentEntity, insertInto: viewContext)
        studentManagedObject.setValue(nameTextFiled.text ?? "", forKey: "name")
        studentManagedObject.setValue(addressTextFiled.text ?? "", forKey: "address")
        studentManagedObject.setValue(Double(salaryTextFiled.text ?? "0"), forKey: "salary")
        
        do{
            try viewContext.save()
            print("Data Saved SuccessFully")
            nameTextFiled.text = ""
            addressTextFiled.text = ""
            salaryTextFiled.text = ""
            getStudents()
        } catch let error as NSError {
            print(error.localizedDescription)
            messageLabel.text = error.localizedDescription
        }
        
        //        for i in 0...5 {
        //            let studentManagedObject = NSManagedObject(entity: studentEntity, insertInto: viewContext)
        //            studentManagedObject.setValue("Student\(i+1)", forKey: "name")
        //            studentManagedObject.setValue("Student\(i+1) Address", forKey: "address")
        //            studentManagedObject.setValue(Double(i+100), forKey: "salary")
        //            do{
        //                try viewContext.save()
        //                print("Student\(i) data saved successfully")
        //            } catch let error as NSError {
        //                print(error.localizedDescription)
        //            }
        //
        //        }
        
    }
    
    private func getStudents() {
        //        AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let viewContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Students")
        
        do {
            let students =  try viewContext.fetch(fetchRequest)
            arrStudents = []
            for student in students as! [NSManagedObject] {
                let name = student.value(forKey: "name") ?? ""
                let address = student.value(forKey: "address") ?? ""
                let salary = student.value(forKey: "salary") ?? 0.0
                let studentObject = StudentsDetails.init(name: name as! String, address: address as! String, salary: salary as! Double)
                arrStudents.append(studentObject)
                print("Student name is \(name)")
                print("Student address is \(address)")
                print("Student salary is \(salary)")
            }
            print(arrStudents)
            
            if arrStudents.count > 0 {
                //                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                //                let employeeListViewController = storyboard?.instantiateViewController(withIdentifier: "EmployeeListViewController") as! EmployeeListViewController
                //                employeeListViewController.arrEmployee = arrEmployee
                //                navigationController?.pushViewController(employeeListViewController, animated: true)
            } else {
                print("No Data Found")
            }
            
        } catch let error as NSError {
            
        }
    }
    
    private func deleteUsers() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let viewContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Students")
        
        //    fetchRequest.predicate = NSPredicate(format: "name = %f", Float(salaryTextFiled.text ?? "0.0") ?? 0.0)
        
        do {
            let students = try viewContext.fetch(fetchRequest)
            for student in students as! [NSManagedObject]{
                try viewContext.save()
                print("Data deleted successfully")
                messageLabel.text = "Data deleted successfully"
                nameTextFiled.text = ""
                addressTextFiled.text = ""
                salaryTextFiled.text = ""
                getStudents()
            }
        } catch let error as NSError{
            print(error.localizedDescription)
            messageLabel.text = error.localizedDescription
        }
    }
    private func updateUsers() {
        // AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let viewContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Students")
        // fetchRequest.predicate = NSPredicate(format: "name = %@", nameTextFiled.text ?? "")
        do {
            let students = try viewContext.fetch(fetchRequest)
            for student in students as! [NSManagedObject]{
                let tempStudent = student
                //       tempStudent.setValue(nameTextFiled.text ?? "", forKey: "name")
                //  tempStudent.setValue(addressTextFiled.text ?? "", forKey: "address")
                tempStudent.setValue(Double(salaryTextFiled.text ?? ""), forKey: "salary")
                try viewContext.save()
                print("Data saved successfully")
                messageLabel.text = "Data saved successfully"
                nameTextFiled.text = ""
                addressTextFiled.text = ""
                //salaryTextFiled.text = ""
                getStudents()
            }
        } catch let error as NSError{
            print(error.localizedDescription)
            messageLabel.text = error.localizedDescription
        }
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        //        Insert Rahul
        if nameTextFiled.text?.count == 0 || addressTextFiled.text?.count == 0 ||
            salaryTextFiled.text?.count == 0 {
            print("please enter missing details")
            return
        }
        insertUsers()
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        getStudents()
    }
    
    
    @IBAction func updatedButtonClicked(_ sender: UIButton) {
        //        if nameTextFiled.text?.count == 0 || addressTextFiled.text?.count == 0 ||
        //            salaryTextFiled.text?.count == 0 {
        //            print("please enter missing details")
        //            return
        //        }
        
        if salaryTextFiled.text?.count == 0 {
            print("please enter missing details")
            return
        }
        //        if nameTextFiled.text?.count == 0{
        //            print("please enter missing details")
        //            return
        //        }
        updateUsers()
    }
    
    @IBAction func deleteButtonClicked(_ sender: UIButton) {
        //        if nameTextFiled.text?.count == 0 || addressTextFiled.text?.count == 0 ||
        //            salaryTextFiled.text?.count == 0 {
        //            print("please enter missing details")
        //            return
        //        }
        deleteUsers()
    }
    
    
    
}

struct StudentsDetails {
    var name: String
    var address: String
    var salary: Double
}
