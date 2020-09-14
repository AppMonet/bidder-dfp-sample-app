//
//  SampleInterstitialViewController.swift
//  DFP Standalone
//
//  Created by Jose Portocarrero on 9/10/20.
//  Copyright © 2020 Monet. All rights reserved.
//

import Foundation
import UIKit

// Sample Interstitial Controller ... this shows how to extract the view and how to render it on your Controller view.
class SampleInterstitialViewController: UIViewController {
    private var interstitialView: UIView!
    private var closeButton: UIButton?
    private var kCloseButtonPadding: CGFloat = 5.0
    private let kCloseButton = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAoCAYAAACM/rhtAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAZhJREFUeNrsmNttgzAUhq1IVfsWXqq8MgIPVTZoFqiyRzZBSiZoFmCEiAlaOgFMAJnA9W/lRK7rBpsCslv/0lEi48uHD+f4wlhUVNQ04pynwnbCTsJa/l3t5RnqpHOCZcIKnaaua16WpbS26wy8sk02NVx+nR4B8Xo88pftlj+uVvzu/uGLoQzPUEcDzqcAS4S90Qj7w8EI9ZOhLtooQl/J6HBw49N6bQ2mG9qij1EhCe69qpxm7dZsoi+CHOWbw1uPAadCKjOZ/yZapXS34uN3cTXqoo1epigbAlhQQOhwFMU2kKhDUaxDKoFTDEnCsmPdteqAfZB9ddG3koJSF0Bkf5nDhgzs8iIY46KdC+DJ5BJbAJdZpk8GY7oAyrW1L3JNIC5w5GZanFwAZRqwjVAVyAWOjFKOiWVhWjnw2zSN1ctU1Qd73mxYdz6zZLmUhv8owzMb3RprEepeb1YXU5s/FSTepxnvE7XfS533m4Ugtlveb1iD2PIHcWjy/tgZxMHd5uoDEHT1obhx3quPIC6PoqL+mz4FGACIEQjJhTzglwAAAABJRU5ErkJggg=="

    @objc init(interstitialView: UIView) {
        self.interstitialView = interstitialView
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = UIModalPresentationStyle.fullScreen;
        self.closeButtonSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    @objc func presentInterstitial(controller: UIViewController, complete: @escaping (Error?) -> Void) {
        self.layoutAdView(self.interstitialView);
        self.layoutCloseButton()
        controller.present(self, animated: true) {
            complete(nil)
        }
    }

    // this is how the adview gets attached for rendering.
    func layoutAdView(_ adView: UIView?) {
        adView?.frame = view.bounds
        if adView?.subviews != nil && (adView?.subviews.count ?? 0) > 0 {
            adView?.subviews[0].frame = view.bounds
        }
        adView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        if let adView = adView {
            view.addSubview(adView)
        }
    }

    func closeButtonSetup() -> UIButton? {
        if self.closeButton == nil {
            self.closeButton = UIButton(type: .custom)

            let url = URL(string: kCloseButton)
            var imageData: Data? = nil

            if let url = url {
                imageData = try! Data(contentsOf: url)
            }
            var closeButtonBG: UIImage? = nil
            if let imageData = imageData {
                closeButtonBG = UIImage(data: imageData)
            }
            self.closeButton!.setImage(closeButtonBG, for: .normal)
            self.closeButton!.autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]

            self.closeButton!.sizeToFit()
            self.closeButton!.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
            self.closeButton!.accessibilityLabel = "Close Ad"
        }
        return closeButton
    }

    func layoutCloseButton() {
        self.view.addSubview(self.closeButton!)
        let originX: CGFloat = self.view.bounds.size.width -
                kCloseButtonPadding -
                self.closeButton!.bounds.size.width
        self.closeButton!.frame =
                CGRect(x: originX,
                        y: kCloseButtonPadding,
                        width: self.closeButton!.bounds.size.width,
                        height: self.closeButton!.bounds.size.height)

        self.closeButton!.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

        self.closeButton!.isHidden = false

        if #available(iOS 11.0, *) {
            self.closeButton!.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.closeButton!.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: kCloseButtonPadding),
                self.closeButton!.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -kCloseButtonPadding),
            ])
        }
        self.view.bringSubviewToFront(self.closeButton!)
    }

    @objc func closeButtonPressed() {
        AppMonetManager.sharedInstance().cleanInterstitial()
        self.presentingViewController?.dismiss(animated: true) {
        }
    }
}
