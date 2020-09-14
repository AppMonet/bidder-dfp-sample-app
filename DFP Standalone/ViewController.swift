//
//  ViewController.swift
//
//  Created by Jose Portocarrero on 9/9/20.
//  Copyright © 2020 Monet. All rights reserved.
//

import UIKit
import AppMonet_Bidder
import GoogleMobileAds

class ViewController: UIViewController, GADInterstitialDelegate {
    @IBOutlet weak var dfpAdView: DFPBannerView!
    var interstitial: DFPInterstitial!

    override func viewDidLoad() {
        super.viewDidLoad()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        self.dfpAdView.adUnitID = "<BANNER_AD_UNIT_ID>"
        self.dfpAdView.rootViewController = self
    }

    // Banner loading
    @IBAction func loadAd(_ sender: Any) {
        AppMonetManager.sharedInstance().adView?.requestAds({ (bid: AMMonetBid?) in
            if let bid = bid {
                self.dfpAdView.load(AppMonetManager.sharedInstance().createDFPRequest(bid: bid))
            }
        })
    }

    //Interstitial loading
    @IBAction func loadInterstitial(_ sender: Any) {
        interstitial = getInterstitial()
        interstitial.delegate = self;

        AppMonetManager.sharedInstance().interstitial.requestAds({ (bid: AMMonetBid?) in
            if let bid = bid {
                self.interstitial.load(AppMonetManager.sharedInstance().createDFPRequest(bid: bid))
            }
        })
    }

    func getInterstitial() -> DFPInterstitial {
        DFPInterstitial(adUnitID: "<INTERSTITIAL_AD_UNIT_ID>")
    }

    // MARK: GADInterstitialDelegate
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        ad.present(fromRootViewController: self)
    }
}

