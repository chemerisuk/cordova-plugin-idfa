#import "IdfaPlugin.h"
#import <AdSupport/ASIdentifierManager.h>

@implementation IdfaPlugin

- (void)getInfo:(CDVInvokedUrlCommand *)command {
    [self.commandDelegate runInBackground:^{
        NSString *idfaString = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        BOOL enabled = [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled];

        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:@{
            @"idfa": idfaString,
            @"limitAdTracking": [NSNumber numberWithBool:!enabled]
        }];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

@end
