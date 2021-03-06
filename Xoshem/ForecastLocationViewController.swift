//
//  ForecastLocationViewController.swift
//  Xoshem
//
//  Created by Javier Fuchs on 7/10/16.
//  Copyright © 2015-2016 Mobile Patagonia. All rights reserved.
//

import UIKit
import JFWindguru
import JFCore
import SwiftSpinner

class ForecastLocationViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
//    var notificationToken: NotificationToken?
    let interItemSpacing: CGFloat = 0
    let edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)


    deinit {
//        notificationToken?.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        
        updateForecastView(false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observeNotification()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.flashScrollIndicators()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unobserveNotification()
    }
    
    
    func cellWidth() -> CGFloat {
        return (collectionView!.bounds.size.width - (interItemSpacing * 2) - edgeInsets.left - edgeInsets.right)
    }
    
    func boardCellSize() -> CGSize {
        if collectionView!.bounds.size.height < collectionView!.bounds.size.width {
            return CGSize(width: cellWidth()/3, height: cellWidth()/2 - 24)
        }
        return CGSize(width: cellWidth()/2, height: cellWidth() - 64)
    }


    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
    }

    /// Notifications
    fileprivate func observeNotification()
    {
        unobserveNotification()
        
        let notiCenter = NotificationCenter.default
        let queue = OperationQueue.main

        notiCenter
            .addObserver(forName: EditDidReceiveNotification, object: nil, queue: queue,
                using: {
                    [weak self] note in
                    if let strong = self {
                        if let isEditing: Bool = note.object as? Bool {
                            strong.setEditing(isEditing, animated: true)
                            strong.collectionView.reloadData()
                        }
                    }})
        
        for notification in [ForecastDidUpdateNotification]
        {
            notiCenter
            .addObserver(forName: notification, object: nil, queue: queue,
                using: {
                    [weak self] (note) in
                    self?.updateForecastView(false)
//                    SwiftSpinner.hide()
            })
        }
    }
    
    fileprivate func unobserveNotification()
    {
        for notification in [EditDidReceiveNotification,
                             ForecastDidUpdateNotification]
        {
            NotificationCenter.default.removeObserver(self, name: notification, object: nil)
        }
    }
    
    func reloadView() {
        collectionView.reloadData()
        collectionView.flashScrollIndicators()
    }
    
    func updateForecastView(_ showAlert: Bool)
    {
        reloadView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Common.segue.forecastDetail {
            let vc:ForecastDetailViewController = segue.destination as! ForecastDetailViewController
            if let currentForecast = Facade.instance.locations.first?.selectedPlacemark?.wspotForecast {
                vc.detailItem = currentForecast
                vc.title = currentForecast.spotName()
            }
        }
        else if segue.identifier == Common.segue.search {
            let vc:UIViewController = segue.destination
            vc.title = Common.title.Search
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        Analytics.logMemoryWarning(function: #function, line: #line)
    }
    
}


