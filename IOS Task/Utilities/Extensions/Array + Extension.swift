//
//  Array + Extension.swift
//  ScoreOne Sports
//
//  Created by Qoo on 06/06/2023.
//

import Foundation


extension Array {
    
    func safeItemAtIndex(_ index: Int) -> String {
        
        if self.count > index {
            return self[index] as! String
        }
        
        return ""
    }
}
