//
//  AMCustomEventBanner.m
//  Flame
//
//  Created by Jose Portocarrero on 9/9/20.
//  Copyright © 2020 Monet. All rights reserved.
//

#import "AMCustomEventBanner.h"
#import "DFP_Standalone-Swift.h"

@interface AMCustomEventBanner () <GADCustomEventBanner, AMBannerAdDelegate>

@end

@implementation AMCustomEventBanner

@synthesize delegate;

// MARK: GADCustomEventBanner
- (void)requestBannerAd:(GADAdSize)adSize parameter:(nullable NSString *)serverParameter
                  label:(nullable NSString *)serverLabel request:(nonnull GADCustomEventRequest *)request {
    AMMonetBid *bid = [[AMMonetBid alloc] init];
    bid.cpm = request.additionalParameters[AppMonetManager.bidCpmKey];
    bid.id = request.additionalParameters[AppMonetManager.bidIdKey];
    [[AppMonetManager sharedInstance] adView].delegate = self;
    [[[AppMonetManager sharedInstance] adView] render:bid];
}

// MARK: AMBannerAdDelegate
- (void)wasClicked:(AMAppMonetAdView *)adView {
    [delegate customEventBannerWasClicked:self];
}

- (void)adLoaded:(AMAppMonetAdView *)adView {
    [delegate customEventBanner:self didReceiveAd:[[AppMonetManager sharedInstance] adView]];
}

- (void)adError:(NSError *)error withAdView:(AMAppMonetAdView *)adView {
    [delegate customEventBanner:self didFailAd:nil];
}


// MARK: Cleanup
- (void)dealloc {
    if(self == [[AppMonetManager sharedInstance] adView].delegate){
        [[AppMonetManager sharedInstance] cleanBanner];
    }
}

@end
