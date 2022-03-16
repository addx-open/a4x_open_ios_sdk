//
//  A4xLiveDemoView.h
//  A4xDeviceDemo_OC
//
//  Created by 郭建恒 on 2021/9/16.
//

#import <UIKit/UIKit.h>
#import <A4xLiveSDK/A4xLiveSDK-Swift.h>


NS_ASSUME_NONNULL_BEGIN

@protocol A4xLiveDemoViewDelegate <NSObject>

-(void)videoReconnectAction;

@end

@interface A4xLiveDemoView : UIImageView

@property (nonatomic,assign) BOOL showVideoSpeed;

@property (nonatomic,weak) id<A4xLiveDemoViewDelegate> delegate;

@property (nonatomic,copy) NSString * videoSpeed;

@property (nonatomic,strong) UIView * videoView;

@property (nonatomic,assign) A4xObjcPlayerStateType videoState;

// 更新playerModel 同时更新UI
- (void)updatePlayerModel:(A4xObjcPlayerModel *)playerModel;

@end

NS_ASSUME_NONNULL_END
