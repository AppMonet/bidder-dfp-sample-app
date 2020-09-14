//
//  AppMonetManager.swift
//  Flame
//
//  Created by Jose Portocarrero on 9/9/20.
//  Copyright © 2020 Monet. All rights reserved.
//

import Foundation
import AppMonet_Bidder
import GoogleMobileAds

struct Constants {
    static let kCpmKey = "__bid_cpm__";
    static let kIdKey = "__bid_id__";
}

class AppMonetManager: NSObject {
    @objc let adView = AMAppMonetAdView(adUnitId: "test_banner", size: MONET_MEDIUM_RECT_SIZE);
    @objc let interstitial: AMInterstitialAdController = AMInterstitialAdController(forAdUnitId: "test_interstitial");

    static let _singletonInstance = AppMonetManager()

    private override init() {
    }

    @objc class func sharedInstance() -> AppMonetManager {
        AppMonetManager._singletonInstance
    }

    @objc func cleanInterstitial() {
        interstitial.delegate = nil
    }

    @objc func cleanBanner() {
        adView?.delegate = nil
    }

    func createDFPRequest(bid: AMMonetBid) -> DFPRequest {
        let dfpRequest = DFPRequest()
        dfpRequest.customTargeting = ["mm_cpm": bid.cpm.stringValue, "mm_10": (round(bid.cpm.doubleValue * 10)) / 10.00]

        let extras = GADCustomEventExtras()
        
        extras.setExtras([Constants.kIdKey: bid.id!, Constants.kCpmKey: bid.cpm.stringValue], forLabel: "appmonet")
        dfpRequest.register(extras)
        NSLog("bid id: %@", bid.id)
        return dfpRequest
    }

    @objc class func bidCpmKey() -> String {
        Constants.kCpmKey
    }

    @objc class func bidIdKey() -> String {
        Constants.kIdKey
    }
}
