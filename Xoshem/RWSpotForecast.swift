//
//  RWSpotForecast.swift
//  Xoshem
//
//  Created by javierfuchs on 7/18/17.
//  Copyright © 2017 Fuchs. All rights reserved.
//

import Foundation
import RealmSwift
import JFWindguru

class RWSpotForecast: Object {
    dynamic var id_spot = 0
    dynamic var id_user = 0
    dynamic var nickname: String? = nil
    dynamic var spotname: String? = nil
    dynamic var spot: String? = nil
    dynamic var lat: Float = 0.0
    dynamic var lon: Float = 0.0
    dynamic var alt = 0
    dynamic var id_model: String? = nil
    dynamic var model: String? = nil
    dynamic var model_alt = 0
    dynamic var levels = 0
    dynamic var sst: String? = nil
    dynamic var sunrise: String? = nil
    dynamic var sunset: String? = nil
    dynamic var tz: String? = nil
    dynamic var tzutc: String? = nil
    dynamic var utc_offset = 0
    dynamic var tzid: String? = nil
    dynamic var tides = 0
    dynamic var md5chk: String? = nil
    dynamic var fcst : RWForecast?
    dynamic var wgs = false
    let wgs_arr = List<RWindguruStation>()
    dynamic var wgs_wind_avg = 0

    convenience public init(spotForecast: WSpotForecast) {
        self.init()
        id_spot = spotForecast.id_spot ?? 0
        id_user = spotForecast.id_user ?? 0
        nickname = spotForecast.nickname
        spotname = spotForecast.spotname
        spot = spotForecast.spot
        lat = spotForecast.lat ?? 0.0
        lon = spotForecast.lon ?? 0.0
        alt = spotForecast.alt ?? 0
        id_model = spotForecast.id_model
        model = spotForecast.model
        model_alt = spotForecast.model_alt ?? 0
        levels = spotForecast.levels ?? 0
        sst = spotForecast.sst
        sunrise = spotForecast.sunrise
        sunset = spotForecast.sunset
        tz = spotForecast.tz
        tzutc = spotForecast.tzutc
        utc_offset = spotForecast.utc_offset ?? 0
        tzid = spotForecast.tzid
        tides = spotForecast.tides ?? 0
        md5chk = spotForecast.md5chk
        if let forecast = spotForecast.fcst {
            fcst = RWForecast.init(forecast: forecast)
        }
        wgs = spotForecast.wgs ?? false
        if let array = spotForecast.wgs_arr {
            for station in array {
                wgs_arr.append(RWindguruStation.init(windguruStation: station))
            }
        }
    }

}

