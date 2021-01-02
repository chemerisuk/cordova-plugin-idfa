#import <Cordova/CDV.h>

@interface IdfaPlugin : CDVPlugin

- (void)getInfo:(CDVInvokedUrlCommand*)command;

- (void)requestTrackingAuthorization:(CDVInvokedUrlCommand*)command;

@end
