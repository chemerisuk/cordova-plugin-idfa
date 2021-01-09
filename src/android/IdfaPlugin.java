package by.chemerisuk.cordova.advertising;

import android.content.Context;

import by.chemerisuk.cordova.support.CordovaMethod;
import by.chemerisuk.cordova.support.ReflectiveCordovaPlugin;

import com.google.android.gms.ads.identifier.AdvertisingIdClient;

import org.apache.cordova.CallbackContext;
import org.json.JSONObject;


public class IdfaPlugin extends ReflectiveCordovaPlugin {
    private static final String TAG = "IdfaPlugin";

    @CordovaMethod(ExecutionThread.WORKER)
    protected void getInfo(CallbackContext callbackContext) throws Exception {
        Context context = this.cordova.getActivity().getApplicationContext();
        AdvertisingIdClient.Info info = AdvertisingIdClient.getAdvertisingIdInfo(context);

        JSONObject result = new JSONObject();
        result.put("aaid", info.getId());
        result.put("trackingLimited", info.isLimitAdTrackingEnabled());
        callbackContext.success(result);
    }
}
