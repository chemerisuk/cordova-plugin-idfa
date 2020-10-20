# Cordova plugin for getting Advertising ID (IDFA or AAID)

[![NPM version][npm-version]][npm-url] [![NPM downloads][npm-downloads]][npm-url] [![Twitter][twitter-follow]][twitter-url]

| [![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)][donate-url] | Your help is appreciated. Create a PR, submit a bug or just grab me :beer: |
|-|-|

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

Use variable `PLAY_SERVICES_ADS_VERSION` to override dependency version on Android.

## API

The API is available on the `cordova.plugins.idfa` global object.

### getInfo()

Returns a `Promise<object>` with the following fields:

- `limitAdTracking`: `boolean` - Whether usage of advertising id is allowed by user.
- `idfa`: `string` (_iOS only_) - Identifier for advertisers.
- `trackingTransparencyStatus` (_iOS only_): `"NotAvailable"` | `"Authorized"` | `"Denied"` | `"Restricted"` | `"NotDetermined"` -
   Tracking transparency status, available on iOS 14+ devices. On devices with iOS < 14 the value will always be
   `"NotAvailable"`. For the meaning of other values see [the tracking transparency API docs][tracking-transparency-api].
- `aaid`: `string` (_Android only_) - Android advertising ID.

## Example

```js
cordova.plugins.idfa.getInfo().then(function(info) {
    if (!info.limitAdTracking) {
        console.log(info.idfa || info.aaid);
    }
});
```

[npm-url]: https://www.npmjs.com/package/cordova-plugin-idfa
[npm-version]: https://img.shields.io/npm/v/cordova-plugin-idfa.svg
[npm-downloads]: https://img.shields.io/npm/dm/cordova-plugin-idfa.svg
[twitter-url]: https://twitter.com/chemerisuk
[twitter-follow]: https://img.shields.io/twitter/follow/chemerisuk.svg?style=social&label=Follow%20me
[donate-url]: https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=E62XVSR3XUGDE&source=url
[tracking-transparency-api]: https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanagerauthorizationstatus
