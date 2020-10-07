#import "IdfaPlugin.h"
#import <AdSupport/ASIdentifierManager.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

@implementation IdfaPlugin

- (void)getInfo:(CDVInvokedUrlCommand *)command {
    [self.commandDelegate runInBackground:^{
        NSString *idfaString = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        BOOL enabled = [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled];
        NSString *trackingTransparencyStatus = @"NotAvailable";

        if (@available(iOS 14, *)) {
            ATTrackingManagerAuthorizationStatus status = ATTrackingManager.trackingAuthorizationStatus;
            switch (status) {
                case ATTrackingManagerAuthorizationStatusAuthorized:
                    trackingTransparencyStatus = @"Authorized";
                    enabled = YES;
                    break;

                case ATTrackingManagerAuthorizationStatusDenied:
                    trackingTransparencyStatus = @"Denied";
                    break;

                case ATTrackingManagerAuthorizationStatusRestricted:
                    trackingTransparencyStatus = @"Restricted";
                    break;

                default:
                    trackingTransparencyStatus = @"NotDetermined";
                    break;
            }

            // workaround, as long as Apple deferred the roll-out of manadatory tracking permission popup
            // we'll assume that if the idfa string is not nullish, then it's allowed by user
            if (!enabled && idfaString != nil && ![@"00000000-0000-0000-0000-000000000000" isEqualToString:idfaString]) {
                enabled = YES;
            }
        }

        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:@{
            @"idfa": idfaString,
            @"limitAdTracking": [NSNumber numberWithBool:!enabled],
            @"trackingTransparencyStatus": trackingTransparencyStatus
        }];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

@end
