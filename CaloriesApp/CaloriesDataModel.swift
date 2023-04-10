//
//  CaloriesDataModel.swift
//  CaloriesApp
//
//  Created by Capgemini-DA161 on 4/6/23.
//

import Foundation
import SwiftUI
import CoreData

class CaloriesDataModel: ObservableObject{
    let container : NSPersistentContainer
    @Published var saveBreakfastEntity: [BreakfastEntity] = []
    @Published var saveLunchEntity: [LunchEntity] = []
    @Published var saveValueEntity: [ValueEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "CaloriesApp")
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Error loading data: \(error)")
            }
        }
        fetchData()
    }
    
    func fetchData() {
        let requestBreakfastEntity = NSFetchRequest<BreakfastEntity>(entityName: "BreakfastEntity")
        let requestLunchEntity = NSFetchRequest<LunchEntity>(entityName: "LunchEntity")
        let requestValueEntity = NSFetchRequest<ValueEntity>(entityName: "ValueEntity")
        
        do {
            saveBreakfastEntity = try container.viewContext.fetch(requestBreakfastEntity)
            saveLunchEntity = try container.viewContext.fetch(requestLunchEntity)
            saveValueEntity = try container.viewContext.fetch(requestValueEntity)
        } catch let error {
            print("error fetching data \(error)")
        }
    }
    
    func addBreakfast(icon: String, name: String,ingredients: String,fat: CGFloat, protein: CGFloat, cards: CGFloat) {
        let newMeal = BreakfastEntity(context: container.viewContext)
        newMeal.icon = icon
        newMeal.name = name
        newMeal.ingredients = ingredients
        newMeal.fat = Float(fat)
        newMeal.protein = Float(protein)
        newMeal.cards = Float(cards)
        saveData()
    }
    
    func addLunch(icon: String, name: String,ingredients: String,fat: CGFloat, protein: CGFloat, cards: CGFloat) {
        let newMeal = LunchEntity(context: container.viewContext)
        newMeal.icon = icon
        newMeal.name = name
        newMeal.ingredients = ingredients
        newMeal.fat = Float(fat)
        newMeal.protein = Float(protein)
        newMeal.cards = Float(cards)
        saveData()
    }
    
    func addValue(fat: CGFloat, protein: CGFloat, cards: CGFloat) {
        let newValue = NSFetchRequest<ValueEntity>(entityName: "ValueEntity")
        do {
            let results = try container.viewContext.fetch(newValue)
            if let entity = results.first {
                entity.fat += Float(fat)
                entity.protein += Float(protein)
                entity.cards += Float(cards)
            } else {
                let newValue = ValueEntity(context: container.viewContext)
                newValue.fat = Float(fat)
                newValue.protein = Float(protein)
                newValue.cards = Float(cards)
            }
            saveData()
            fetchData()
        }catch {
            print("\(error)")
        }
        
    }
    
    func addRingCalories(calories: CGFloat){
        let newCal = NSFetchRequest<ValueEntity>(entityName: "ValueEntity")
        do {
            let results = try container.viewContext.fetch(newCal)
            if let entity = results.first {
                entity.ring += Float(Int(calories))
            } else {
                let newEntity = ValueEntity(context: container.viewContext)
                newEntity.ring = 10
            }
        } catch {
            print("error")
        }
        saveData()
        fetchData()
    }
    func addMealTagged(meal: BreakfastEntity) {
        meal.addmeal.toggle()
        saveData()
    }
    
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchData()
        } catch {
            print("Save data failed \(error)")
        }
    }
}
