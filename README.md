# bidder-dfp-sample-app

This sample app demonstrates how to use the AppMonet "bidder" standalone SDK in DFP or MoPub. This allows you to include AppMonet without any other mediation dependencies.

## Key files

- [AppMonetManager.swift](/DFP Standalone/AppMonetManager.swift) - demonstrates how to initialize & manage lifecycle of our SDK
- [AMCustomEventBanner.m](/DFP Standalone/AMCustomEventBanner.m) - this is the custom event banner class you would put in the DFP yield group. Note that you can create a similar class for MoPub
- [ViewController.swift](/DFP Standalone/ViewController.swift) - this demonstrates the usage of the "AppMonetManager" class
