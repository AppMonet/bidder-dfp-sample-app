
//
//  AMCustomEventInterstitial.m
//  DFP Standalone
//
//  Created by Jose Portocarrero on 9/10/20.
//  Copyright © 2020 Monet. All rights reserved.
//

#import "AMCustomEventInterstitial.h"
#import "DFP_Standalone-Swift.h"

@interface AMCustomEventInterstitial () <GADCustomEventInterstitial, AMInterstitialAdControllerDelegate>
@property(nonatomic, strong) GADCustomEventRequest *request;
@property(nonatomic, strong) UIView *interstitialView;
@end

@implementation AMCustomEventInterstitial
@synthesize delegate;

// MARK: GADCustomEventInterstitial
- (void)requestInterstitialAdWithParameter:(nullable NSString *)serverParameter label:(nullable NSString *)serverLabel request:(GADCustomEventRequest *)request {
    AMMonetBid *bid = [[AMMonetBid alloc] init];
    bid.cpm = request.additionalParameters[@"__bid_cpm__"];
    bid.id = request.additionalParameters[@"__bid_id__"];

    //Add this so you can know when the ad has successfully loaded
    [[AppMonetManager sharedInstance] interstitial].delegate = self;
    [[[AppMonetManager sharedInstance] interstitial] loadAd:bid];
}

- (void)presentFromRootViewController:(nonnull UIViewController *)rootViewController {
    // You'll probably have your own view controller
    SampleInterstitialViewController *controller = [[SampleInterstitialViewController alloc] initWithInterstitialView:self.interstitialView];

    [controller presentInterstitialWithController:rootViewController complete:^(NSError *error) {
        if (error) {
            [self->delegate customEventInterstitial:self didFailAd:nil];
            return;
        }
        [self->delegate customEventInterstitialWillPresent:self];
    }];
}

// MARK: AMInterstitialAdControllerDelegate
- (void)interstitialDidLoadAd:(AMInterstitialAdController *)interstitial {
    self.interstitialView = [interstitial getInterstitialView];
    [delegate customEventInterstitialDidReceiveAd:self];
}

- (void)interstitialDidReceiveTapEvent:(AMInterstitialAdController *)interstitial {
    [delegate customEventInterstitialWasClicked:self];
}

@end
