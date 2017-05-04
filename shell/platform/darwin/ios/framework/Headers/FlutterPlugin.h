// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef FLUTTER_FLUTTERPLUGIN_H_
#define FLUTTER_FLUTTERPLUGIN_H_

#include "FlutterBinaryMessenger.h"
#include "FlutterChannels.h"
#include "FlutterCodecs.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FlutterPlugin <NSObject>
@optional
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result;
- (void)applicationDidBecomeActive:(UIApplication*)application;
- (void)applicationWillResignActive:(UIApplication*)application;
- (void)applicationDidEnterBackground:(UIApplication*)application;
- (void)applicationWillEnterForeground:(UIApplication*)application;
- (void)applicationWillTerminate:(UIApplication*)application;
- (BOOL)application:(UIApplication*)application
            openURL:(NSURL*)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id>*)options;
@end

@protocol FlutterPluginRegistrar
- (NSObject<FlutterBinaryMessenger>*) messenger;
- (void)publish:(NSObject*)value;
- (void)addMethodCallDelegate:(NSObject<FlutterPlugin>*)delegate
                      channel:(FlutterMethodChannel*)channel;
- (void)addApplicationDelegate:(NSObject<FlutterPlugin>*)delegate;
@end

@protocol FlutterPluginRegistry
- (NSObject<FlutterPluginRegistrar>*)registrarForPlugin:(NSString*)pluginKey;
- (BOOL)hasPlugin:(NSString*)pluginKey;
- (NSObject*)valuePublishedByPlugin:(NSString*)pluginKey;
@end

NS_ASSUME_NONNULL_END;

#endif  // FLUTTER_FLUTTERPLUGIN_H_
