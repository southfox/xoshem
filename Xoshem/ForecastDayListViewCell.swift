//
//  ForecastDayListViewCell.swift
//  Xoshem
//
//  Created by Javier Fuchs on 8/2/16.
//  Copyright © 2015-2016 Mobile Patagonia. All rights reserved.
//

import UIKit

class ForecastDayListViewCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView?
    @IBOutlet weak var keyLabel: UILabel?
    @IBOutlet weak var valueLabel: UILabel?
    
    func configure()
    {
        if let iconView = iconView {
            iconView.alpha = 0
        }
        if let keyLabel = keyLabel {
            keyLabel.alpha = 0
        }
        if let valueLabel = valueLabel {
            valueLabel.alpha = 0
        }
    }
    
    func configure(_ iconName: String?, key: String?, value: String?)
    {
        configure()
        if let iconName = iconName,
           let iconView = iconView {
            iconView.alpha = 1
            iconView.image = UIImage.init(named:
                iconName)
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
