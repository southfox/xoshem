//
//  ForecastDetailViewController.swift
//  Xoshem
//
//  Created by Javier Fuchs on 7/14/16.
//  Copyright © 2015-2016 Mobile Patagonia. All rights reserved.
//

import UIKit
import JFCore
import JFWindguru

class ForecastDetailViewController: BaseViewController {

    @IBOutlet weak var dayListContainer: UIView!
    @IBOutlet weak var hierarchyContainer: UIView!
    
    var detailItem: WSpotForecast? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            title = detail.spotName()
        }
        showComponent(1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    func showComponent(_ id: Int) {
        let array = [dayListContainer, hierarchyContainer]
        
        for subview in array {
            if subview != nil {
                subview?.alpha = 0
            }
        }
        
        if let subview = array[id-1] {
            UIView.animate(withDuration: 0.5, animations: {
                subview.alpha = 1
            })
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        NotificationCenter.default.post(name: EditDidReceiveNotification, object: editing)
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Common.segue.forecastDayList {
            let vc = segue.destination as! ForecastDayListViewController
            vc.spotForecast = detailItem
            vc.title = detailItem?.spotName()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        Analytics.logMemoryWarning(function: #function, line: #line)
    }
    

}

