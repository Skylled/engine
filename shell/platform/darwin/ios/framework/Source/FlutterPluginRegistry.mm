// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "flutter/shell/platform/darwin/ios/framework/Headers/FlutterPluginRegistry.h"

@implementation FlutterPluginRegistry {
  NSMutableArray* _plugins;
}

-(instancetype)init {
  if (self = [super init]) {
    _plugins = [NSMutableArray new];
  }
  return self;
}

- (void)dealloc {
  [_plugins release];
  [super dealloc];
}

- (void)registerPlugin:(id)plugin {
  [_plugins addObject:plugin];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  for (id plugin in _plugins) {
    if ([plugin respondsToSelector:@selector(applicationDidBecomeActive:)]) {
      [plugin applicationDidBecomeActive:application];
    }
  }
}

- (void)applicationWillResignActive:(UIApplication *)application {
  for (id plugin in _plugins) {
    if ([plugin respondsToSelector:@selector(applicationWillResignActive:)]) {
      [plugin applicationWillResignActive:application];
    }
  }
}

- (void)applicationWillTerminate:(UIApplication *)application {
  for (id plugin in _plugins) {
    if ([plugin respondsToSelector:@selector(applicationWillTerminate:)]) {
      [plugin applicationWillTerminate:application];
    }
  }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  for (id plugin in _plugins) {
    if ([plugin respondsToSelector:@selector(applicationWillEnterForeground:)]) {
      [plugin applicationWillEnterForeground:application];
    }
  }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  for (id plugin in _plugins) {
    if ([plugin respondsToSelector:@selector(applicationDidEnterBackground:)]) {
      [plugin applicationDidEnterBackground:application];
    }
  }
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
  for (id plugin in _plugins) {
    if ([plugin respondsToSelector:@selector(application:openURL:options:)]) {
      if ([plugin application:app openURL:url options:options]) {
        return YES;
      }
    }
  }
  return NO;
}

- (void)application:(UIApplication *)application
    performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
  for (id plugin in _plugins) {
    if ([plugin respondsToSelector:@selector(application:performFetchWithCompletionHandler:)]) {
      [plugin application:application performFetchWithCompletionHandler:completionHandler];
    }
  }
}

- (void)application:(UIApplication *)application
    handleEventsForBackgroundURLSession:(NSString *)identifier
                      completionHandler:(void (^)(void))completionHandler {
  for (id plugin in _plugins) {
    if ([plugin respondsToSelector:@selector(application:handleEventsForBackgroundURLSession:completionHandler:)]) {
      [plugin application:application
        handleEventsForBackgroundURLSession:identifier
                          completionHandler:completionHandler];
    }
  }
}

- (void)application:(UIApplication *)application
    didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
  for (id plugin in _plugins) {
    if ([plugin respondsToSelector:@selector(application:didRegisterUserNotificationSettings:)]) {
      [plugin application:application didRegisterUserNotificationSettings:notificationSettings];
    }
  }
}

- (void)application:(UIApplication *)application
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  for (id plugin in _plugins) {
    if ([plugin respondsToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)]) {
      [plugin application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    }
  }
}

- (void)application:(UIApplication *)application
    didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
  for (id plugin in _plugins) {
    if ([plugin respondsToSelector:@selector(application:didFailToRegisterForRemoteNotificationsWithError:)]) {
      [plugin application:application didFailToRegisterForRemoteNotificationsWithError:error];
    }
  }
}

- (void)application:(UIApplication *)application
    didReceiveRemoteNotification:(NSDictionary *)userInfo
          fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
  for (id plugin in _plugins) {
    if ([plugin respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)]) {
      [plugin application:application
        didReceiveRemoteNotification:userInfo
              fetchCompletionHandler:completionHandler];
    }
  }
}
@end
