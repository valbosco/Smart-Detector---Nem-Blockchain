//
//  MyData.swift
//  final
//

import Foundation

enum Mode {
    case add
    case edit
}
struct MyData {
    var userId: String = ""
    var orderNumber: String = "No orders yet"
    var address: String = ""
    var name: String = ""
    var progress: String = "status"
    // var status: Bool = false // false = in transit, true = completed
    
}
//struct MyData {
//     var orderNumber: String = ""
//    var address: String = ""
//    var name: String = ""
//    var status: Bool = false // false = in transit, true = completed
//
//}
struct NewOrder {
    var number: String = ""
    var iconImage: String = ""
    var title: String = ""
    var subTitle: String  = ""
    var stepCompleted: Bool = false
}

struct locationData {
    var street: String = ""
    var city: String = ""
    var state: String = ""
    var country: String = ""
    
}
struct CarrierData {
    var name: String = ""
    var address: String = ""
    var rating: String = ""
    var deliveryNo: String = ""
    
}
struct MedData {
    var name: String = ""
    var price: Int = 0
    var productId: String = ""
    var productImage: String = ""
    var category: String = ""
    
}
