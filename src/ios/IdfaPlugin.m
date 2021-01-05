#import "IdfaPlugin.h"
#import <AdSupport/ASIdentifierManager.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

@implementation IdfaPlugin

- (void)getInfo:(CDVInvokedUrlCommand *)command {
    [self.commandDelegate runInBackground:^{
        NSString *idfaString = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        BOOL enabled = [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled];
        NSString *trackingPermission;

        if (@available(iOS 14, *)) {
            ATTrackingManagerAuthorizationStatus status = ATTrackingManager.trackingAuthorizationStatus;
            switch (status) {
                case ATTrackingManagerAuthorizationStatusAuthorized:
                    trackingPermission = @"Authorized";
                    enabled = YES;
                    break;

                case ATTrackingManagerAuthorizationStatusDenied:
                    trackingPermission = @"Denied";
                    break;

                case ATTrackingManagerAuthorizationStatusRestricted:
                    trackingPermission = @"Restricted";
                    break;

                default:
                    trackingPermission = @"NotDetermined";
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
            @"isTrackingLimited": [NSNumber numberWithBool:!enabled],
            @"trackingPermission": trackingPermission ?: [NSNull null]
        }];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)requestPermission:(CDVInvokedUrlCommand *)command {
    [self.commandDelegate runInBackground:^{
        if (@available(iOS 14, *)) {
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                NSString *trackingPermission;
                switch (status) {
                    case ATTrackingManagerAuthorizationStatusAuthorized:
                        trackingPermission = @"Authorized";
                        break;

                    case ATTrackingManagerAuthorizationStatusDenied:
                        trackingPermission = @"Denied";
                        break;

                    case ATTrackingManagerAuthorizationStatusRestricted:
                        trackingPermission = @"Restricted";
                        break;

                    default:
                        trackingPermission = @"NotDetermined";
                        break;
                }
                CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:trackingPermission];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }];
        } else {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
}

@end
