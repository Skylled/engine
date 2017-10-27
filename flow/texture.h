// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef FLUTTER_FLOW_TEXTURE_H_
#define FLUTTER_FLOW_TEXTURE_H_

#include <map>
#include "flutter/common/threads.h"
#include "lib/fxl/synchronization/waitable_event.h"
#include "third_party/skia/include/core/SkMatrix.h"
#include "third_party/skia/include/core/SkSurface.h"
#include "third_party/skia/include/gpu/GrBackendSurface.h"
#include "third_party/skia/include/gpu/GrContext.h"
#include "third_party/skia/include/gpu/GrTexture.h"
#include "third_party/skia/include/gpu/GrTypes.h"

namespace flow {

class Texture {
 protected:
  Texture(int64_t id);
 public:
  // Called from GPU thread.
  virtual ~Texture();

  // Called from GPU thread.
  virtual sk_sp<SkImage> MakeSkImage(int width,
                                     int height,
                                     GrContext* grContext) = 0;

  // Called from GPU thread.
  virtual void OnGrContextCreated() = 0;

  // Called from GPU thread.
  virtual void OnGrContextDestroyed() = 0;

  int64_t Id() { return id_; }

 private:
  int64_t id_;

  FXL_DISALLOW_COPY_AND_ASSIGN(Texture);
};

class TextureRegistry {
 public:
  TextureRegistry();
  ~TextureRegistry();

  // Called from GPU thread.
  void RegisterTexture(std::shared_ptr<Texture> texture);

  // Called from GPU thread.
  void UnregisterTexture(int64_t id);

  // Called from GPU thread.
  std::shared_ptr<Texture> GetTexture(int64_t id);

  // Called from GPU thread.
  void OnGrContextCreated();

  // Called from GPU thread.
  void OnGrContextDestroyed();

 private:
  std::map<int64_t, std::shared_ptr<Texture>> mapping_;

  FXL_DISALLOW_COPY_AND_ASSIGN(TextureRegistry);
};

}  // namespace flow

#endif  // FLUTTER_FLOW_TEXTURE_H_
