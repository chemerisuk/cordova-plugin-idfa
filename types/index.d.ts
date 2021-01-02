type TrackingTransparencyStatus =
    | "NotAvailable"
    | "Authorized"
    | "Denied"
    | "Restricted"
    | "NotDetermined";

/**
 * The data retrieved by the Idfa plugin.
 */
interface IdfaData {
    /**
     * Whether usage of advertising id is allowed by user.
     */
    limitAdTracking: boolean;

    /**
     * Identifier for advertisers _(iOS only)_.
     */
    idfa?: string;

    /**
     * Tracking transparency status _(iOS only)_. Available only for iOS 14+ devices.
     * On devices with iOS < 14 the value will always be `"NotAvailable"`.
     * For the meaning of other values see
     * [the tracking transparency API docs](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanagerauthorizationstatus).
     */
    trackingTransparencyStatus?: TrackingTransparencyStatus;

    /**
     * Android advertising ID _(Android only)_.
     */
    aaid?: string;
}

/**
 * Cordova plugin for getting Advertising ID (IDFA or AAID).
 */
interface IdfaPlugin {
    /**
     * Retrieve the advertising id info for the current platform.
     *
     * @example
     *
     * cordova.plugins.idfa.getInfo().then((info) => {
     *     if (!info.limitAdTracking) {
     *         console.log(info.idfa || info.aaid);
     *     }
     * });
     */
    getInfo(): Promise<IdfaData>;

    /**
     * _(iOS only)_ A one-time request to authorize or deny access to app-related data
     * that can be used for tracking the user or the device. See
     * [Apple's API docs](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547037-requesttrackingauthorization)
     * for more info. Available only for iOS 14+ devices. On devices with iOS < 14 the
     * returned promise will always resolve with `"NotAvailable"`.
     *
     * **Note:** You should make sure to set the `NSUserTrackingUsageDescription` key in your app's
     * Information Property List file. See
     * [Apple's API docs](https://developer.apple.com/documentation/bundleresources/information_property_list/nsusertrackingusagedescription)
     * for more info.
     *
     * @example
     *
     * // config.xml
     * <platform name="ios">
     *     <edit-config target="NSUserTrackingUsageDescription" file="*-Info.plist" mode="merge">
     *         <string>My tracking usage description</string>
     *     </edit-config>
     * </platform>
     *
     * // index.ts
     * cordova.plugins.idfa.requestTrackingAuthorization().then((status) => {
     *     console.log(status);
     * });
     */
    requestTrackingAuthorization(): Promise<TrackingTransparencyStatus>;
}

interface CordovaPlugins {
    idfa: IdfaPlugin;
}
