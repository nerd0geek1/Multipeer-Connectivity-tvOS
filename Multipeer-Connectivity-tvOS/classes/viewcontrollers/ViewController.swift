//
//  ViewController.swift
//  Multipeer-Connectivity-tvOS
//
//  Created by Kohei Tabata on 10/12/16.
//  Copyright © 2016 Kohei Tabata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var buttonsView: UIView!


    //MARK: - lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMultiPeerNetworking()
    }

    //MARK: - private

    private func setupMultiPeerNetworking() {
        MultipeerSession.sharedInstance.didEstablishConnection = {
            DispatchQueue.main.async {
                self.backgroundView.isHidden = true
                self.buttonsView.isHidden    = true
            }
        }
        MultipeerSession.sharedInstance.didReceiveResource = { resource in
            DispatchQueue.main.async {
                self.textView.text.append(resource.text + "\n\n")
            }
        }

        MultipeerBrowser.sharedInstance.setup(with: MultipeerSession.sharedInstance)
        MultipeerAdvertiser.sharedInstance.setup(with: MultipeerSession.sharedInstance)
    }

    //MARK: - IBAction

    @IBAction
    private func tapMakeGroupButton() {
        MultipeerBrowser.sharedInstance.startBrowsing()
    }

    @IBAction
    private func tapJoinGroupButton() {
        MultipeerAdvertiser.sharedInstance.startAdvertising()
    }
}
