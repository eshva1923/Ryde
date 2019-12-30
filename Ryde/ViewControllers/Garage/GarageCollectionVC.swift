//
//  GarageCollectionVC.swift
//  Ryde
//
//  Created by Federico Brandani on 30/12/2019.
//  Copyright © 2019 EshvaSoft. All rights reserved.
//

import UIKit

class GarageCollectionVC: UIViewController {
    var bikesArray: Array<BikeModel> = []
    @IBOutlet var garageCollection: UICollectionView!
    @IBOutlet var lbl_mileage: UILabel!
    @IBOutlet var lbl_nextOilChange: UILabel!
    @IBOutlet var lbl_nextService: UILabel!
    @IBOutlet var lbl_nextAirFiletChange: UILabel!
    @IBOutlet var btn_editDetails: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        garageCollection.delegate = self
        garageCollection.dataSource = self
        loadBikes()
    }

    private func loadBikes() {
        bikesArray.removeAll()
        DataLayer.shared.getMyBikes { myBikes in
            self.bikesArray = myBikes
            self.bikesArray.append(BikeModel.test())
            self.garageCollection.reloadData()
            self.btn_editDetails.isEnabled = false
            if myBikes.count > 0 {
                self.loadInfo(myBikes.first!)
                self.btn_editDetails.isEnabled = true
            }
        }
    }

    private func loadInfo(_ bike: BikeModel) {
        lbl_mileage.text = "\(bike.info.mileageKm) Km"
        let nextService = bike.info.kmLeftForMaintenance(bike.info.nextServiceKm)
        let nextOil = bike.info.kmLeftForMaintenance(bike.info.oilChangeIntervalKm)
        let nextAir = bike.info.kmLeftForMaintenance(bike.info.airFilterChangeIntervalKm)
        lbl_nextService.text = nextService != nil ? "\(nextService!) Km" : "-"
        lbl_nextOilChange.text = nextOil != nil ? "\(nextOil!) Km" : "-"
        lbl_nextAirFiletChange.text =  nextAir != nil ? "\(nextAir!) Km" : "-"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editBike",
            let destVC = segue.destination as? BikeDetailsVC,
            let selectedIndexPath = garageCollection.indexPathsForSelectedItems?.first {
            let selectedBike = bikesArray[selectedIndexPath.row]
            destVC.thisBike = selectedBike


        }
    }
}

//MARK: - Delegation
extension GarageCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? bikesArray.count : 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bikeCell", for: indexPath) as! BikeCell
            cell.setupWithModel(bikesArray[indexPath.row])
            return cell
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "addBikeCell", for: indexPath)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return indexPath.section == 0 ? CGSize(width: 255, height: 390) : CGSize(width: 150, height: 390)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            loadInfo(bikesArray[indexPath.row])
        }
    }
}

//MARK: - BikeCell
class BikeCell: UICollectionViewCell {
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var nickname: UILabel!
    @IBOutlet var lbl_info: UILabel!

    func setupWithModel(_ model: BikeModel) {
        nickname.text = model.nickname
        lbl_info.text = model.stringifyInfo()
        if let photoRef = model.getBikePhotoReference() { backgroundImage.sd_setImage(with: photoRef) }

    }

}
