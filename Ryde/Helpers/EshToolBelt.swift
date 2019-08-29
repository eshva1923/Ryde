//
//  EshToolBelt.swift
//  Ryde
//
//  Created by Federico Brandani on 19/08/2019.
//  Copyright © 2019 EshvaSoft. All rights reserved.
//

import Foundation
import UIKit

struct DateHelper {
    private static let formatter = DateFormatter()
    static func format(date: Date) -> String {
        formatter.dateFormat = "dd-MM-yy"
        return formatter.string(from: date)
    }
    static func format(string: String) -> Date? {
        return formatter.date(from: string) ?? nil
    }
    static func elapsedFuzzyTime(from: Date) -> String {
        let components = Calendar.current.dateComponents([.hour, .day, .month], from: from, to: Date())
        let hours = components.hour ?? 0
        let days = components.day ?? 0
        let months = components.month ?? 0

        if months > 6 {return "More than 6 months ago"}
        if months > 1 {return "\(months) months ago"}
        if days > 0 { return "\(days) days ago"}
        return "\(hours) hours ago"
    }
}
struct Countries {
    static private let allCountries = [
        Country(flag: "🇮🇹", naturalName: "Italia", englishName: "Italy", code2: "IT", code3: "ITA"),
        Country(flag: "🇫🇷", naturalName: "France", englishName: "France", code2: "FR", code3: "FRA"),
        Country(flag: "🇩🇪", naturalName: "Deutschland", englishName: "Germany", code2: "DE", code3: "GER"),
        Country(flag: "🇮🇪", naturalName: "Eire", englishName: "Ireland", code2: "IE", code3: "IRL"),
        Country(flag: "🇬🇧", naturalName: "United Kingdom", englishName: "United Kingdom", code2: "UK", code3: "UK"),
        Country(flag: "🇪🇸", naturalName: "Espana", englishName: "Spain", code2: "ES", code3: "ESP"),
        Country(flag: "🇷🇴", naturalName: "Romania", englishName: "Romania", code2: "RO", code3: "ROM"),
        Country(flag: "🇦🇹", naturalName: "Austria", englishName: "Austria", code2: "AT", code3: "AUT"),
        Country(flag: "🇺🇦", naturalName: "Україна", englishName: "Ukraina", code2: "UA", code3: "UKR"),
        Country(flag: "🇵🇹", naturalName: "Portugal", englishName: "Portugal", code2: "PT", code3: "PRT"),
        Country(flag: "🇵🇱", naturalName: "Polska", englishName: "Poland", code2: "PL", code3: "POL"),
        Country(flag: "🇳🇱", naturalName: "Nederland", englishName: "Netherlands", code2: "NL", code3: "NLD"),
        Country(flag: "🇨🇭", naturalName: "Suisse", englishName: "Switzerland", code2: "CH", code3: "CHE"),
        Country(flag: "🇸🇪", naturalName: "Sverige", englishName: "Sweden", code2: "SE", code3: "SWE"),
        Country(flag: "🇭🇺", naturalName: "Magyrorszag", englishName: "Hungary", code2: "HU", code3: "HUN"),
        Country(flag: "🇸🇮", naturalName: "Slovenija", englishName: "Slovenia", code2: "SI", code3: "SVN"),
        Country(flag: "🇸🇰", naturalName: "Slovensko", englishName: "Slovakia", code2: "SK", code3: "SVK"),
        Country(flag: "🇷🇸", naturalName: "Srbija", englishName: "Serbia", code2: "RS", code3: "SRB"),
        Country(flag: "🇨🇿", naturalName: "Česká", englishName: "Czech", code2: "CZ", code3: "CZE"),
        Country(flag: "🇳🇴", naturalName: "Norge", englishName: "Norway", code2: "NO", code3: "NOR"),
        Country(flag: "🇲🇩", naturalName: "Moldova", englishName: "Moldavia", code2: "MD", code3: "MDA"),
        Country(flag: "🇲🇹", naturalName: "Malta", englishName: "Malta", code2: "MT", code3: "MLT"),
        Country(flag: "🇱🇺", naturalName: "Luxembourg", englishName: "Luxembourg", code2: "LU", code3: "LUX"),
        Country(flag: "🇱🇹", naturalName: "Lietuva", englishName: "Lithuania", code2: "LT", code3: "LTU"),
        Country(flag: "🇱🇮", naturalName: "Liechtenstein", englishName: "Liechtenstein", code2: "LI", code3: "LIE"),
        Country(flag: "🇱🇻", naturalName: "Latvija", englishName: "Latvia", code2: "LV", code3: "LVA"),
        Country(flag: "🇮🇲", naturalName: "Ellan Vannin", englishName: "Isle of Man", code2: "IM", code3: "IMN"),
        Country(flag: "🇮🇸", naturalName: "Ísland", englishName: "Iceland", code2: "IS", code3: "ISN"),
        Country(flag: "🇬🇷", naturalName: "Hellas", englishName: "Greece", code2: "GR", code3: "GRC"),
        Country(flag: "🇫🇮", naturalName: "Suomi", englishName: "Finland", code2: "FI", code3: "IFN"),
        Country(flag: "🇪🇪", naturalName: "Eesti", englishName: "Estonia", code2: "EE", code3: "EST"),
        Country(flag: "🇩🇰", naturalName: "Danmark", englishName: "Denmark", code2: "DK", code3: "DNK"),
        Country(flag: "🇭🇷", naturalName: "Hrvatska", englishName: "Croatia", code2: "HR", code3: "HRV"),
        Country(flag: "🇨🇾", naturalName: "Kibris", englishName: "Cyprus", code2: "CY", code3: "CYP"),
        Country(flag: "🇧🇬", naturalName: "Balgariya", englishName: "Bulgaria", code2: "BG", code3: "BGR"),
        Country(flag: "🇧🇦", naturalName: "Bosna I Hercegovina", englishName: "Bosnia and Herzegovina", code2: "BA", code3: "BIH"),
        Country(flag: "🇧🇾", naturalName: "Белару́сь", englishName: "Belarus", code2: "BY", code3: "BLR"),
        Country(flag: "🇷🇺", naturalName: "Россия", englishName: "Russia", code2: "RU", code3: "RUS"),
        Country(flag: "🇧🇪", naturalName: "Belgique", englishName: "Belgium", code2: "BE", code3: "BEL"),
        Country(flag: "🇦🇱", naturalName: "Shqiperi", englishName: "Albania", code2: "AL", code3: "ALB"),
        Country(flag: "🇹🇷", naturalName: "Turkiye", englishName: "Turkey", code2: "TR", code3: "TUR"),
        Country(flag: "🇪🇺", naturalName: "Europe", englishName: "Europe", code2: "EU", code3: "EUR")
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
        if country.count == 1 { return self.getCountryByFlag(country) }
        if (country.count == 2 || country.count == 3 ) { return self.getCountryBy(code: country) }
        if let c = self.getCountryBy(name: country) { return c }
        return nil
    }
}
extension Countries {
    static func stringifyRideCountries(_ rideModel: RideModel, mode: CountriesStringMode = .noText, withFlag: Bool = true, adaptive: Bool = true) -> String {
        var selectedMode = mode
        if adaptive {
            switch rideModel.country.split(separator: ",").count {
            case 1:
                selectedMode = .englishName
            case 2:
                selectedMode = .code3
            default:
                selectedMode = .noText
            }
        }
        let countries = rideModel.country.split(separator: ",").compactMap { self.getCountry(String($0))}
        switch selectedMode {
        case .noText:
            return countries.map{ "\($0.flag)" }.joined(separator: " / ")
        case .code3:
            if withFlag { return countries.map{ "\($0.flag) \($0.code3)" }.joined(separator: " / ")}
            return countries.map{ "\($0.code3)" }.joined(separator: " / ")
        case .code2:
            if withFlag { return countries.map{ "\($0.flag) \($0.code2)" }.joined(separator: " / ")}
            return countries.map{ "\($0.code2)" }.joined(separator: " / ")
        case .naturalName:
            if withFlag { return countries.map{ "\($0.flag) \($0.naturalName)" }.joined(separator: " / ")}
            return countries.map{ "\($0.naturalName)" }.joined(separator: " / ")
        case .englishName:
            if withFlag { return countries.map{ "\($0.flag) \($0.englishName)" }.joined(separator: " / ")}
            return countries.map{ "\($0.englishName)" }.joined(separator: " / ")
        }
    }
    
    enum CountriesStringMode {
        case noText
        case code3
        case code2
        case naturalName
        case englishName
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
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}
