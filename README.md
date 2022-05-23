# flutter_siampiwat

## Build an Android app

From the command line:

Run ```flutter build apk --split-per-abi```

## Build an IOS app

* In Xcode, open **Runner.xcworkspace** in your app’s ios folder.
* select the **Runner** target in the settings view sidebar.
* In the Identity section, update the Version 
* In the Identity section, update the Build identifier to a unique build number
* **Archive** binary, and wait until done
* Open Organizer window click **Validate App**, follow until finish
* Select Distribute and Select Ad Hoc
* Export and Done

## Run an application

From the command line:

``` flutter pub get ```

``` flutter run ```