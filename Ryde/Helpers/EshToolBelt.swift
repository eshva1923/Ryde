//
//  EshToolBelt.swift
//  Ryde
//
//  Created by Federico Brandani on 19/08/2019.
//  Copyright © 2019 EshvaSoft. All rights reserved.
//

import Foundation
import UIKit
struct Countries {
    static private let allCountries = [
        Country(flag: "🇮🇹", naturalName: "Italia", englishName: "Italy", code2: "IT", code3: "ITA"),
        Country(flag: "🇫🇷", naturalName: "France", englishName: "France", code2: "FR", code3: "FRA"),
        Country(flag: "🇩🇪", naturalName: "Deutschland", englishName: "Germany", code2: "DE", code3: "GER"),
        Country(flag: "🇮🇪", naturalName: "Eire", englishName: "Ireland", code2: "IE", code3: "IRL"),
        Country(flag: "🇬🇧", naturalName: "United Kingdom", englishName: "United Kingdom", code2: "UK", code3: "UK"),
        Country(flag: "🇪🇸", naturalName: "Espana", englishName: "Spain", code2: "ES", code3: "ESP"),
    ]
    static private func getCountryBy(code: String) -> Country? {
        if code.count == 3 {
            return Countries.allCountries.first { $0.code3 == code}
        } else if code.count == 2 {
            return Countries.allCountries.first { $0.code2 == code }
        }
        return nil
    }
    static private func getCountryBy(name: String) -> Country? {
        if let engName = Countries.allCountries.first(where: { $0.englishName == name }) {
            return engName
        } else if let naturalName = Countries.allCountries.first(where: { $0.naturalName == name}) {
            return naturalName
        }
        return nil
    }
    static private func getCountryByFlag(_ flag: String) -> Country? {
        return Countries.allCountries.first {$0.flag == flag}
    }

    static func getCountry(_ country: String) -> Country? {
        if country.count == 1 {
            return self.getCountryByFlag(country)
        }
        if (country.count == 2 || country.count == 3 ) {
            return self.getCountryBy(code: country)
        }
        if let c = self.getCountryBy(name: country) {
            return c
        }
        return nil
    }
}
struct Country {
    let flag: String
    let naturalName: String
    let englishName: String
    let code2: String
    let code3: String
}

@IBDesignable
class GradientView: UIView {
    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}

    override public class var layerClass: AnyClass { return CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors    = [startColor.cgColor, endColor.cgColor]
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}
