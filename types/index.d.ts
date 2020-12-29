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
    trackingTransparencyStatus?:
        | "NotAvailable"
        | "Authorized"
        | "Denied"
        | "Restricted"
        | "NotDetermined";

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
}

interface CordovaPlugins {
    idfa: IdfaPlugin;
}
