// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef FLUTTER_FLUTTERPLUGINREGISTRY_H_
#define FLUTTER_FLUTTERPLUGINREGISTRY_H_

#import <UIKit/UIKit.h>

#include "FlutterMacros.h"

FLUTTER_EXPORT
@interface FlutterPluginRegistry : NSObject<UIApplicationDelegate>
- (void)registerPlugin:(id)plugin;
@end

#endif  // FLUTTER_FLUTTERPLUGINREGISTRY_H_
