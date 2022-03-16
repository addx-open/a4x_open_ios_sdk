//
//  A4xWebRtcGenerateImage.h
//  A4xAi
//
//  Created by addx-wjin on 2021/7/1.
//  Copyright © 2021 a4x.ai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebRTC/WebRTC.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSObject (A4xWebRtcGenerateImage)
- (void)generateImage :(RTCVideoFrame *)frame comple:(void (^)(UIImage *))animations;
@end

NS_ASSUME_NONNULL_END
