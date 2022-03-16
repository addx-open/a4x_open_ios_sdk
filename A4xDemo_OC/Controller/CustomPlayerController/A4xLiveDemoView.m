//
//  A4xLiveDemoView.m
//  A4xDeviceDemo_OC
//
//  Created by 郭建恒 on 2021/9/16.
//

#import "A4xLiveDemoView.h"
#import "Masonry.h"

@implementation A4xLiveDemoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self layoutAllviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutAllviews];
    }
    return self;
}

- (void)layoutAllviews
{
    self.videoView = [[UIView alloc]initWithFrame:self.bounds];
    NSLog(@"self.videoView.frame:%@",NSStringFromCGRect(self.videoView.frame));
    self.videoView.backgroundColor = [UIColor clearColor];
    //self.videoView.frame = self.bounds;
    self.videoView.translatesAutoresizingMaskIntoConstraints = YES;
    [self addSubview:self.videoView];
    
}

- (void)updatePlayerModel:(A4xObjcPlayerModel *)playerModel
{
    A4xObjcPlayerStateType playType = playerModel.playState;
    UIImage * thumbImage = playerModel.thumbImage;
    switch (playType) {
        case A4xObjcPlayerStateTypeNone:
        {
            self.image = thumbImage;
        }
            break;
        case A4xObjcPlayerStateTypeLoading:
        {
            self.image = thumbImage;
        }
            break;
        case A4xObjcPlayerStateTypePlaying:
        {
            self.videoView.hidden = NO;
        }
            break;
        case A4xObjcPlayerStateTypePaused:
        {
            self.image = thumbImage;
        }
            break;
        case A4xObjcPlayerStateTypeFinish:
        {
            
        }
            break;
        case A4xObjcPlayerStateTypeError:
        {
            self.image = thumbImage;
        }
            break;
        case A4xObjcPlayerStateTypeUpdating:
        {
            self.image = thumbImage;
        }
            break;
        case A4xObjcPlayerStateTypePausedp2p:
        {
            self.image = thumbImage;
        }
            break;
        default:
        {
            
        }
            break;
    }
}

- (void)updateNoneState
{
    
}


@end
