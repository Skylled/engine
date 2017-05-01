// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "flutter/shell/platform/darwin/ios/framework/Headers/FlutterAppDelegate.h"
#include "flutter/shell/platform/darwin/ios/framework/Headers/FlutterViewController.h"
#include "lib/ftl/logging.h"

@implementation FlutterAppDelegate {
  UIBackgroundTaskIdentifier _debugBackgroundTask;
}

// Returns the key window's rootViewController, if it's a FlutterViewController.
// Otherwise, returns nil.
- (FlutterViewController*)rootFlutterViewController {
  UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
  if ([viewController isKindOfClass:[FlutterViewController class]]) {
    return (FlutterViewController*)viewController;
  }
  return nil;
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
  [super touchesBegan:touches withEvent:event];

  // Pass status bar taps to key window Flutter rootViewController.
  if (self.rootFlutterViewController != nil) {
    [self.rootFlutterViewController handleStatusBarTouches:event];
  }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  if ([self.delegate respondsToSelector:@selector(applicationDidBecomeActive:)]) {
    [self.delegate applicationDidBecomeActive:application];
  }
}

- (void)applicationWillResignActive:(UIApplication *)application {
  if ([self.delegate respondsToSelector:@selector(applicationWillResignActive:)]) {
    [self.delegate applicationWillResignActive:application];
  }
}

- (void)applicationWillTerminate:(UIApplication *)application {
  if ([self.delegate respondsToSelector:@selector(applicationWillTerminate:)]) {
    [self.delegate applicationWillTerminate:application];
  }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  #if FLUTTER_RUNTIME_MODE == FLUTTER_RUNTIME_MODE_DEBUG
  // The following keeps the Flutter session alive when the device screen locks
  // in debug mode. It allows continued use of features like hot reload and
  // taking screenshots once the device unlocks again.
  //
  // Note the name is not an identifier and multiple instances can exist.
  _debugBackgroundTask = [application beginBackgroundTaskWithName:@"Flutter debug task"
                                                expirationHandler:^{
      FTL_LOG(WARNING) << "\nThe OS has terminated the Flutter debug connection for being "
                          "inactive in the background for too long.\n\n"
                          "There are no errors with your Flutter application.\n\n"
                          "To reconnect, launch your application again via 'flutter run";
      }];
  #endif  // FLUTTER_RUNTIME_MODE == FLUTTER_RUNTIME_MODE_DEBUG
  if ([self.delegate respondsToSelector:@selector(applicationDidEnterBackground:)]) {
    [self.delegate applicationDidEnterBackground:application];
  }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  #if FLUTTER_RUNTIME_MODE == FLUTTER_RUNTIME_MODE_DEBUG
  [application endBackgroundTask: _debugBackgroundTask];
  #endif  // FLUTTER_RUNTIME_MODE == FLUTTER_RUNTIME_MODE_DEBUG
  if ([self.delegate respondsToSelector:@selector(applicationWillEnterForeground:)]) {
    [self.delegate applicationWillEnterForeground:application];
  }
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
  if ([self.delegate respondsToSelector:@selector(application:openURL:options:)]) {
    return [self.delegate application:app openURL:url options:options];
  } else {
    return NO;
  }
}

- (void)application:(UIApplication *)application
    performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
  if ([self.delegate respondsToSelector:@selector(application:performFetchWithCompletionHandler:)]) {
    [self.delegate application:application performFetchWithCompletionHandler:completionHandler];
  }
}

- (void)application:(UIApplication *)application
    handleEventsForBackgroundURLSession:(NSString *)identifier
                      completionHandler:(void (^)(void))completionHandler {
  if ([self.delegate respondsToSelector:@selector(application:handleEventsForBackgroundURLSession:completionHandler:)]) {
    [self.delegate application:application
      handleEventsForBackgroundURLSession:identifier
                        completionHandler:completionHandler];
  }
}

- (void)application:(UIApplication *)application
    didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
  if ([self.delegate respondsToSelector:@selector(application:didRegisterUserNotificationSettings:)]) {
    [self.delegate application:application didRegisterUserNotificationSettings:notificationSettings];
  }
}

- (void)application:(UIApplication *)application
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  if ([self.delegate respondsToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)]) {
    [self.delegate application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
  }
}

- (void)application:(UIApplication *)application
    didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
  if ([self.delegate respondsToSelector:@selector(application:didFailToRegisterForRemoteNotificationsWithError:)]) {
    [self.delegate application:application didFailToRegisterForRemoteNotificationsWithError:error];
  }
}

- (void)application:(UIApplication *)application
        didReceiveRemoteNotification:(NSDictionary *)userInfo
              fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
  if ([self.delegate respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)]) {
    [self.delegate application:application
      didReceiveRemoteNotification:userInfo
            fetchCompletionHandler:completionHandler];
  }
}

@end
