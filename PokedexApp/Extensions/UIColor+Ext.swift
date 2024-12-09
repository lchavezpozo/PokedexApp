//
//  UIColor+.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 8/12/24.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    func darken(by percentage: CGFloat = 0.1) -> UIColor {
         var hue: CGFloat = 0
         var saturation: CGFloat = 0
         var brightness: CGFloat = 0
         var alpha: CGFloat = 0

         if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
             brightness -= percentage
             brightness = max(brightness, 0)
             return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
         }
         return self
     }
}
