//
//  BikeDetailsVC.swift
//  Ryde
//
//  Created by Federico Brandani on 30/12/2019.
//  Copyright © 2019 EshvaSoft. All rights reserved.
//

import UIKit
import SPAlert

class BikeDetailsVC: UIViewController {
    var thisBike: BikeModel?
    @IBOutlet var detailsTitle: UILabel!
    @IBOutlet var txt_nickname: UITextField!
    @IBOutlet var txt_make: UITextField!
    @IBOutlet var txt_model: UITextField!
    @IBOutlet var txt_year: UITextField!
    @IBOutlet var img_bikePhoto: UIImageView!
    @IBOutlet var lbl_comment: UILabel!

    @IBOutlet var lbl_mileage: UILabel!
    @IBOutlet var lbl_service: UILabel!
    @IBOutlet var lbl_oil: UILabel!
    @IBOutlet var lbl_air: UILabel!
    @IBOutlet var lbl_chain: UILabel!
    @IBOutlet var lbl_coolant: UILabel!

    @IBOutlet var btn_oil: UIButton!
    @IBOutlet var btn_air: UIButton!
    @IBOutlet var btn_chain: UIButton!
    @IBOutlet var btn_coolant: UIButton!
    @IBOutlet var btn_service: UIButton!
    @IBOutlet var btn_mileage: UIButton!


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }

    func refresh() {
        if let bike = thisBike {
            if let photoRef = bike.getBikePhotoReference() { img_bikePhoto.sd_setImage(with: photoRef) }
            detailsTitle.text = "Edit your bike"
            txt_nickname.text = bike.nickname ?? nil
            txt_year.text =  "\(bike.year)"
            txt_make.text = bike.make
            txt_model.text = bike.model
            lbl_comment.text = bike.comment ?? "Write a comment or some notes about the bike here"
            lbl_comment.textColor = bike.comment != nil ? #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

            lbl_mileage.text = "\(bike.info.mileageKm)"
            lbl_service.text = "\(bike.info.nextServiceKm)"
            lbl_oil.text = "\(bike.info.oilChangeIntervalKm)"
            lbl_air.text = "\(bike.info.airFilterChangeIntervalKm)"
            lbl_chain.text = "\(bike.info.chainLubeIntervalKm)"
            lbl_coolant.text = "\(bike.info.coolantChangeIntervalKm)"
        } else {
            img_bikePhoto.image = nil
            detailsTitle.text = "Register a new bike"
            txt_nickname.text = nil
            txt_make.text = nil
            txt_model.text = nil
            txt_year.text = nil
            lbl_comment.text = "Write a comment or some notes about the bike here"
            lbl_comment.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)

            lbl_mileage.text = "-"
            lbl_service.text = "-"
            lbl_oil.text = "-"
            lbl_air.text = "-"
            lbl_chain.text = "-"
            lbl_coolant.text = "-"
        }
    }

    @IBAction func btn_saveDidTap(sender: UIButton) {
        saveBike()
    }
    @IBAction func btn_cancelDidTap(sender: UIButton) {

    }
    @IBAction func btn_commentDidTap(sender: UIButton) {
        presentEditingAlertForEntry(.comment)
    }

    @IBAction func btn_maintenanceDidTap(sender: UIButton) {
        switch sender {
            case btn_air:
                presentEditingAlertForEntry(.air)
            case btn_oil:
                presentEditingAlertForEntry(.oil)
            case btn_chain:
                presentEditingAlertForEntry(.chain)
            case btn_coolant:
                presentEditingAlertForEntry(.coolant)
            case btn_mileage:
                presentEditingAlertForEntry(.mileage)
            case btn_service:
                presentEditingAlertForEntry(.service)
            default:
            return
        }

    }

    private func saveBike() {
        guard let make = txt_make.text,
            let model = txt_model.text,
            let yearString = txt_year.text,
            let year = Int(yearString) else {return}

        let updBike = BikeModel(photo: nil,
                                nickname: txt_nickname.text, owner: nil, comment: lbl_comment.text,
                                make: make, tags: [], model: model, year: year,
                                info: BikeInfoDetails(mileageKm: Int(lbl_mileage.text ?? "0") ?? 0,
                                                      oilChangeIntervalKm: Int(lbl_oil.text ?? "0") ?? 0,
                                                      airFilterChangeIntervalKm: Int(lbl_air.text ?? "0") ?? 0,
                                                      chainLubeIntervalKm: Int(lbl_chain.text ?? "0") ?? 0,
                                                      coolantChangeIntervalKm: Int(lbl_coolant.text ?? "0") ?? 0,
                                                      nextServiceKm: Int(lbl_service.text ?? "0") ?? 0, tyresLifeKm: 0))
        thisBike = updBike
        ///SAVE THE BIKE HERE
        SPAlert.present(title: "Saved!", message: nil, preset: .done)
    }
    private func presentEditingAlertForEntry(_ entry: MaintenanceEntry) {
        var previousValue: Any? = nil
        if let bike = thisBike {
            switch entry {
                case .mileage:
                    previousValue = bike.info.mileageKm
                case .oil:
                    previousValue = bike.info.oilChangeIntervalKm
                case .air:
                    previousValue = bike.info.airFilterChangeIntervalKm
                case .chain:
                    previousValue = bike.info.chainLubeIntervalKm
                case .coolant:
                    previousValue = bike.info.coolantChangeIntervalKm
                case .service:
                    previousValue = bike.info.nextServiceKm
                case .comment:
                    previousValue = bike.comment
            }
        }
        let alert = UIAlertController(title: entry.title(), message: entry.message(), preferredStyle: .alert)
        alert.addTextField { textfield in
            textfield.placeholder = entry.title()
            if let oldValue = previousValue, (oldValue as? Int) != 0 {
                textfield.text = "\(oldValue)"
            } else {
                textfield.text = "-"
            }
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
            self.editEntry(entry, withValue: alert.textFields!.first?.text)
            alert.dismiss(animated: true) { print("DISMISSING") }
        }))
        self.present(alert, animated: true, completion: nil)
    }

    private func editEntry(_ entry: MaintenanceEntry, withValue value: String?) {

        if entry == .comment { lbl_comment.text = value; return}
        
        guard let theValue = value, let newValue = Int(theValue) else { return }
        switch entry {
            case .mileage:
                lbl_mileage.text = newValue != 0 ? "\(newValue)" : nil
            case .oil:
                lbl_oil.text = newValue != 0 ? "\(newValue)" : nil
            case .air:
                lbl_air.text = newValue != 0 ? "\(newValue)" : nil
            case .chain:
                lbl_chain.text = newValue != 0 ? "\(newValue)" : nil
            case .coolant:
                lbl_coolant.text = newValue != 0 ? "\(newValue)" : nil
            case .service:
                lbl_service.text = newValue != 0 ? "\(newValue)" : nil
            default:
            return
        }
    }
}
extension BikeDetailsVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}
private enum MaintenanceEntry: String {
    case mileage = "Mileage"
    case oil = "Oil change interval"
    case air = "Air filter change interval"
    case chain = "Chain lube interval"
    case service = "Next service at"
    case coolant = "Coolant liquid change interval"
    case comment = "Write a comment"

    func title() -> String {
        return self.rawValue
    }
    func message() -> String? {
        switch self {
            case .mileage:
                return "Insert new total mileage in Km"
            case .oil:
                return "Change engine oil every (Km)"
            case .air:
                return "Change or clean the air filter every (Km)"
            case .chain:
                return "Lube or inspect the chain every (Km)"
            case .service:
                return "Next bike service is due at (Km)"
            case .coolant:
                return "Change coolant liquid every (Km)"
            case .comment:
            return nil
        }
    }
}
