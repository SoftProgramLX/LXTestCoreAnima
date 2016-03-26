//
//  TestCoreAnima
//
//  Created by 李旭 on 16/3/25.
//  Copyright © 2016年 xu li. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface LXFireworksButton : UIButton

@property (strong, nonatomic) UIImage *particleImage;
@property (assign, nonatomic) CGFloat particleScale;
@property (assign, nonatomic) CGFloat particleScaleRange;

- (void)animate;
- (void)popOutsideWithDuration:(NSTimeInterval)duration;
- (void)popInsideWithDuration:(NSTimeInterval)duration;

@end
