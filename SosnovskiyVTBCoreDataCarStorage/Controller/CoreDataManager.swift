//
//  CridentialManager.swift
//  SosnovskiyVTBCoreDataCarStorage
//
//  Created by Gregory Pinetree on 14.07.2020.
//  Copyright © 2020 Gregory Pinetree. All rights reserved.
//

import CoreData

// MARK: - Core data manager
final class CoreDataManager {
    
    //
    // MARK: - Constants
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PersonData")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading store failed \(error)")
            }
        }
        return container
    }()
    
    private enum Keys {
        static let userName = "Person"
        static let carName = "Car"
        static let userKey = "currentAppUser"
        static let carKey = "userCarsKey"
    }
    
    // MARK: - Has profile
    func hasProfile() -> Bool {
        return getPerson() != nil
    }
    
    // MARK: - Get person
    func getPerson() -> Person? {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Person>(entityName: Keys.userName)
        fetchRequest.fetchLimit = 1
        
        do {
            let person = try context.fetch(fetchRequest)
            return person.first
        } catch {
            print("Failed to get person: \(error)")
        }
        return nil
    }
    
    // MARK: - Get cars
    func getCars() -> [Car]? {
        let person = getPerson()
        return person?.cars?.allObjects as? [Car]
    }
    
    // MARK: - Create person
    private func createPerson(_ credentials: [String]) {
        let context = persistentContainer.viewContext
        
        let person = NSEntityDescription.insertNewObject(forEntityName: Keys.userName, into: context) as! Person
        person.firstName = credentials[0]
        person.lastName = credentials[1]
        person.login = credentials[2]
        person.password = credentials[3]
        person.cars = NSSet()
        do {
            try context.save()
        } catch {
            print("Failed to create person: \(error)")
        }
    }
    
    // MARK: - Create car
    private func createCar(_ carName: String) {
        let context = persistentContainer.viewContext
        
        let car = NSEntityDescription.insertNewObject(forEntityName: Keys.carName, into: context) as! Car
        
        car.name = carName
        let person = getPerson()
        person?.cars?.adding(car)
        car.owner = person
        do {
            try context.save()
        } catch {
            print("Failed to create car: \(error)")
        }
    }
    
    // MARK: - Delete person
    private func deletePerson() {
        let context = persistentContainer.viewContext
        if let person = getPerson() {
            context.delete(person)
            do {
                try context.save()
            } catch {
                print("Failed to delete person: \(error)")
            }
        }
    }
    
    // MARK: - Delete car
    private func deleteCar(_ car: Car) {
        let context = persistentContainer.viewContext
        context.delete(car)
        do {
            try context.save()
        } catch {
            print("Failed to delete cars: \(error)")
        }
    }
}

// MARK: - Manage data delegate
extension CoreDataManager: CredentialControlDelegate, CarDelegate, CarCreatingDelegate {
    func removeCar(car: Car) {
        deleteCar(car)
    }
    
    func passCar(_ name: String) {
        createCar(name)
    }
    
    func passCredentials(_ credentials: [String]) {
        createPerson(credentials)
    }
    
    func removeCredentials() {
        deletePerson()
    }
}

