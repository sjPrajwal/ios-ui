//
//  Bus.swift
//  transportApp
//
//  Created by Mac HD on 08/08/20.
//  Copyright © 2020 Mac HD. All rights reserved.
//

import Foundation

struct Bus: Codable{
    var BusId: Int?
    var BusName: String = "Test"
    var Capacity: String = "50"
    var fuel: String? = "80"
    var Lat: Float?
    var Long: Float?
    var Occupied: String = "25"
    var AvailableSeat: String?
    
//    let name = "A->B"
//    let totalOccupancy = 50
//    let currentOccupancy = 25
    var isIncidentOccured = false
    
    func getOccupancyRate() -> Float{
        let cap = Float(Capacity) ?? 0.0
        let occ = Float(Occupied) ?? 0.0
        return occ/cap
    }
}
