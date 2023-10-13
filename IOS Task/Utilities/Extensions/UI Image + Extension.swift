//
//  UI Image + Extension.swift
//  ScoreOne Sports
//
//  Created by Qoo on 03/06/2023.
//

import Foundation
import UIKit


extension UIImage {
    
    func convertImageToBase64String () -> String {
        return self.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
}
