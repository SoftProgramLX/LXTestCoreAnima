//
//  TestCoreAnima
//
//  Created by 李旭 on 16/3/25.
//  Copyright © 2016年 xu li. All rights reserved.
//

@import UIKit;

@protocol LXPathCenterButtonDelegate <NSObject>

- (void)centerButtonTapped;

@end

@interface LXPathCenterButton : UIImageView

@property (weak, nonatomic) id<LXPathCenterButtonDelegate> delegate;

@end
