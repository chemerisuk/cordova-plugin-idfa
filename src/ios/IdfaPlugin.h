#import <Cordova/CDV.h>

@interface IdfaPlugin : CDVPlugin

- (void)getInfo:(CDVInvokedUrlCommand*)command;

- (void)requestPermission:(CDVInvokedUrlCommand*)command;

@end
