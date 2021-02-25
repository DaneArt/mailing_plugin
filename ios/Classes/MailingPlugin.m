#import "MailingPlugin.h"
#if __has_include(<mailing_plugin/mailing_plugin-Swift.h>)
#import <mailing_plugin/mailing_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "mailing_plugin-Swift.h"
#endif

@implementation MailingPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMailingPlugin registerWithRegistrar:registrar];
}
@end
