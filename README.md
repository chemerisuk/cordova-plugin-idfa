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

Use variable `ANDROID_PLAY_ADID_VERSION` to override dependency version on Android:

    $ cordova plugin add cordova-plugin-idfa --variable ANDROID_PLAY_ADID_VERSION='16.+'

## API

The API is available on the `cordova.plugins.idfa` global object.

### getInfo()

Returns a `Promise<object>` with the following fields:

- `isTrackingLimited`: `boolean` - Whether usage of advertising id is allowed by user.
- `idfa`: `string` (_iOS only_) - Identifier for advertisers.
- `trackingPermission` (_iOS only_): [`TrackingPermission`](#trackingpermission)
   Tracking permission status, available on iOS 14+ devices. On devices with iOS < 14 the value will
   always be `null`.
- `aaid`: `string` (_Android only_) - Android advertising ID.

### requestPermission()

_(iOS only)_ A one-time request to authorize or deny access to app-related data that can be used for
tracking the user or the device. See [Apple's API docs][requesttrackingauthorization-api-url]
for more info on the dialog presented to the user. Available only for iOS 14+ devices.

Returns a `Promise<`[`TrackingPermission`](#trackingpermission)`>`. On devices
with iOS < 14 the promise will always resolve with `null`.

**Note:** You should make sure to set the
[`NSUserTrackingUsageDescription`][nsusertrackingusagedescription-api-url] key in your app's
Information Property List file, otherwise your app will crash when you use this API.
You can do it with the following code in your Cordova project's `config.xml`:
```xml
<platform name="ios">
    <edit-config target="NSUserTrackingUsageDescription" file="*-Info.plist" mode="merge">
        <string>My tracking usage description</string>
    </edit-config>
</platform>
```

### TrackingPermission

An `object` containing all possible tracking permission values returned by [`getInfo()#trackingPermission`](#getinfo)
and [`requestPermission()`](#requestPermission).

For the meaning of the values see [the tracking transparency API docs][authorizationstatus-api-url]:

- `Authorized`: `'Authorized'`
- `Denied`: `'Denied'`
- `Restricted`: `'Restricted'`
- `NotDetermined`: `'NotDetermined'`

## Example

```js
const idfaPlugin = cordova.plugins.idfa;
const TrackingPermission = idfaPlugin.TrackingPermission;

idfaPlugin.getInfo()
    .then(info => {
        if (!info.isTrackingLimited) {
            return info.idfa || info.aaid;
        } else if (info.trackingPermission === TrackingPermission.NotDetermined) {
            return idfaPlugin.requestPermission().then(result => {
                if (result !== TrackingPermission.Authorized) {
                    return;
                }

                return idfaPlugin.getInfo().then(info => {
                    return info.idfa || info.aaid;
                });
            });
        }
    })
    .then(idfaOrAaid => {
        if (idfaOrAaid) {
            console.log(idfaOrAaid);
        }
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
