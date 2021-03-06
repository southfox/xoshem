//
//  ForecastDayListViewCell.swift
//  Xoshem
//
//  Created by Javier Fuchs on 8/2/16.
//  Copyright © 2015-2016 Mobile Patagonia. All rights reserved.
//

import UIKit
import FontWeather_swift

class ForecastDayListViewCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView?
    @IBOutlet weak var keyLabel: UILabel?
    @IBOutlet weak var valueLabel: UILabel?
    
    func configure()
    {
        if let iconView = iconView {
            iconView.alpha = 0
            iconView.layer.masksToBounds = false
            iconView.layer.cornerRadius = 20
            iconView.clipsToBounds = true
        }
        if let keyLabel = keyLabel {
            keyLabel.alpha = 0
        }
        if let valueLabel = valueLabel {
            valueLabel.alpha = 0
        }
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func configure(_ iconName: String?, key: String?, value: String?)
    {
        configure()
        if let iconName = iconName,
           let iconView = iconView {
            iconView.alpha = 1
            let image = UIImage.fontWeatherIconWithCode(code: iconName, textColor: .white, size: CGSize.init(width: 30, height: 30))
            iconView.image = image
        }
        if let key = key,
           let keyLabel = keyLabel {
            keyLabel.alpha = 1
            keyLabel.text = key + ": "
        }
        if let value = value,
           let valueLabel = valueLabel {
            valueLabel.alpha = 1
            valueLabel.text = value
        }
    }

}
