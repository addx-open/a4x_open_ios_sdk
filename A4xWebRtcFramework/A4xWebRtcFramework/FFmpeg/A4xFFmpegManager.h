//
//  A4xFFmpegManager.h
//  A4xAi
//
//  Created by addx-wjin on 2021/7/1.
//  Copyright © 2021 a4x.ai. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "KMMedia.h"

NS_ASSUME_NONNULL_BEGIN

@protocol A4xFFmpegManagerDelegate <NSObject>

@optional
//- (void)ts2Mp4Result:(KMMediaAssetExportSessionStatus) status outputPath: (NSString *) outputfilePath;

@end

@interface A4xFFmpegManager : NSObject

+ (instancetype)sharedInstance;

+ (BOOL)muxerMP4File:(NSString *)mp4file withH264File:(NSString *)h264File codecName:(NSString *)codecName;
// 转换Mp4视频
+ (BOOL)turnMp4Video:(NSString *)inputPath outputPath:(NSString *)outputPath;

// TS转换Mp4视频
- (BOOL)ts2Mp4:(NSString *)inputPath outputPath:(NSString *)outputPath;

// 代理
@property(nonatomic, weak) id<A4xFFmpegManagerDelegate> adFFmpegMuxerDelegate;

@end

NS_ASSUME_NONNULL_END
