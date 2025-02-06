//
//  ProductModel.swift
//  appdev
//
//  Created by JIDTP1408 on 04/02/25.
//

import Foundation

enum ProductCategory {
    case electronics, clothing, footwear, accessories, food, personalCare, stationery, vehicle, furniture
}

class Product {
    let name: String
    let category: ProductCategory
    let price: Double
    let inStock: Bool
    private(set) var location: String
    let startTime: Date?
    let endTime: Date?
    let imageUrl: String
    
    var usedTime: TimeInterval? {
        guard let start = startTime, let end = endTime else { return nil }
        return end.timeIntervalSince(start)
    }
    
    init(name: String, category: ProductCategory, price: Double, inStock: Bool, location: String, imageUrl: String, startTime: Date? = nil, endTime: Date? = nil) {
        self.name = name
        self.category = category
        self.price = price
        self.inStock = inStock
        self.location = location
        self.imageUrl = imageUrl
        self.startTime = startTime
        self.endTime = endTime
    }
    
    func updateLocation(newLocation: String) {
        self.location = newLocation
    }
    
    func shareLocation() -> String {
        return "The \(name) is currently located in \(location)."
    }
}

class HouseholdProducts {
    static var products: [Product] = [
        Product(name: "Lamp", category: .electronics, price: 29.99, inStock: true, location: "Living Room", imageUrl: "lamp.png"),
        Product(name: "Chair", category: .furniture, price: 59.99, inStock: true, location: "Dining Room", imageUrl: "chair.png"),
        Product(name: "TV", category: .electronics, price: 499.99, inStock: true, location: "Living Room", imageUrl: "tv.png"),
        Product(name: "Smartphone", category: .electronics, price: 799.99, inStock: false, location: "Bedroom", imageUrl: "smartphone.png"),
        Product(name: "Laptop", category: .electronics, price: 1099.99, inStock: true, location: "Office", imageUrl: "laptop.png"),
        Product(name: "Smartwatch", category: .electronics, price: 199.99, inStock: true, location: "Bedroom", imageUrl: "smartwatch.png"),
        Product(name: "T-shirt", category: .clothing, price: 19.99, inStock: true, location: "Wardrobe", imageUrl: "tshirt.png"),
        Product(name: "Sneakers", category: .footwear, price: 89.99, inStock: true, location: "Shoe Rack", imageUrl: "sneakers.png"),
        Product(name: "Sunglasses", category: .accessories, price: 49.99, inStock: true, location: "Drawer", imageUrl: "sunglasses.png"),
        Product(name: "Coffee cup", category: .food, price: 9.99, inStock: true, location: "Kitchen", imageUrl: "coffee_cup.png"),
        Product(name: "Apple", category: .food, price: 0.99, inStock: true, location: "Kitchen", imageUrl: "apple.png"),
        Product(name: "Pizza", category: .food, price: 12.99, inStock: true, location: "Kitchen", imageUrl: "pizza.png"),
        Product(name: "Toothbrush", category: .personalCare, price: 3.99, inStock: true, location: "Bathroom", imageUrl: "toothbrush.png"),
        Product(name: "Shampoo bottle", category: .personalCare, price: 7.99, inStock: true, location: "Bathroom", imageUrl: "shampoo_bottle.png"),
        Product(name: "Razor", category: .personalCare, price: 5.99, inStock: true, location: "Bathroom", imageUrl: "razor.png"),
        Product(name: "Notebook", category: .stationery, price: 2.99, inStock: true, location: "Office", imageUrl: "notebook.png"),
        Product(name: "Pen", category: .stationery, price: 1.49, inStock: true, location: "Office", imageUrl: "pen.png"),
        Product(name: "Printer", category: .electronics, price: 149.99, inStock: true, location: "Office", imageUrl: "printer.png"),
        Product(name: "Car", category: .vehicle, price: 24999.99, inStock: false, location: "Garage", imageUrl: "car.png"),
        Product(name: "Bicycle", category: .vehicle, price: 499.99, inStock: true, location: "Garage", imageUrl: "bicycle.png")
    ]
}
