# Cordova plugin for getting Advertising ID (IDFA or AAID)

[![NPM version][npm-version]][npm-url] [![NPM downloads][npm-downloads]][npm-url] [![NPM total downloads][npm-total-downloads]][npm-url] [![PayPal donate](https://img.shields.io/badge/paypal-donate-ff69b4?logo=paypal)][donate-url] [![Twitter][twitter-follow]][twitter-url]

## Index

<!-- MarkdownTOC levels="2" autolink="true" -->

- [Supported Platforms](#supported-platforms)
- [Installation](#installation)
- [API](#api)
- [Example](#example)

<!-- /MarkdownTOC -->

## Supported Platforms

- iOS
- Android

## Installation

    $ cordova plugin add cordova-plugin-idfa

Use variable `ANDROID_PLAY_ADID_VERSION` to override dependency version on Android.

## API

The API is available on the `cordova.plugins.idfa` global object.

### getInfo()

Returns a `Promise<object>` with the following fields:

- `limitAdTracking`: `boolean` - Whether usage of advertising id is allowed by user.
- `idfa`: `string` (_iOS only_) - Identifier for advertisers.
- `trackingTransparencyStatus` (_iOS only_): `"NotAvailable"` | `"Authorized"` | `"Denied"` | `"Restricted"` | `"NotDetermined"` -
   Tracking transparency status, available on iOS 14+ devices. On devices with iOS < 14 the value will always be
   `"NotAvailable"`. For the meaning of other values see [the tracking transparency API docs][authorizationstatus-api-url].
- `aaid`: `string` (_Android only_) - Android advertising ID.

### requestTrackingAuthorization()

_(iOS only)_ A one-time request to authorize or deny access to app-related data that can be used for
tracking the user or the device. See [Apple's API docs][requesttrackingauthorization-api-url]
for more info on the dialog presented to the user. Available only for iOS 14+ devices.

Returns a `Promise<string>` with the same values as [`getInfo()#trackingTransparencyStatus`](#getinfo) field.
On devices with iOS < 14 the promise will always resolve with `"NotAvailable"`.

**Note:** You should make sure to set the `NSUserTrackingUsageDescription` key in your app's
Information Property List file. You can do it with the following code in your Cordova project's `config.xml`:
```xml
<platform name="ios">
    <edit-config target="NSUserTrackingUsageDescription" file="*-Info.plist" mode="merge">
        <string>My tracking usage description</string>
    </edit-config>
</platform>
```
See [Apple's API docs][nsusertrackingusagedescription-api-url] for more info on this configuration key.

## Example

```js
cordova.plugins.idfa.getInfo().then(function(info) {
    if (!info.limitAdTracking) {
        console.log(info.idfa || info.aaid);
    }
});

cordova.plugins.idfa.requestTrackingAuthorization().then(function(status) {
    console.log(status);
});
```

[npm-url]: https://www.npmjs.com/package/cordova-plugin-idfa
[npm-version]: https://img.shields.io/npm/v/cordova-plugin-idfa.svg
[npm-downloads]: https://img.shields.io/npm/dm/cordova-plugin-idfa.svg
[npm-total-downloads]: https://img.shields.io/npm/dt/cordova-plugin-idfa.svg?label=total+downloads
[twitter-url]: https://twitter.com/chemerisuk
[twitter-follow]: https://img.shields.io/twitter/follow/chemerisuk.svg?style=social&label=Follow%20me
[donate-url]: https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=E62XVSR3XUGDE&source=url
[authorizationstatus-api-url]: https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanagerauthorizationstatus
[requesttrackingauthorization-api-url]: https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547037-requesttrackingauthorization
[nsusertrackingusagedescription-api-url]: https://developer.apple.com/documentation/bundleresources/information_property_list/nsusertrackingusagedescription
