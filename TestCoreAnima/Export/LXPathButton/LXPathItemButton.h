//
//  TestCoreAnima
//
//  Created by 李旭 on 16/3/25.
//  Copyright © 2016年 xu li. All rights reserved.
//

@import UIKit;

@class LXPathItemButton;

@protocol LXPathItemButtonDelegate <NSObject>

- (void)itemButtonTapped:(LXPathItemButton *)itemButton;

@end

@interface LXPathItemButton : UIImageView

@property (assign, nonatomic) NSUInteger index;
@property (weak, nonatomic) id<LXPathItemButtonDelegate> delegate;

- (id)initWithImage:(UIImage *)image
   highlightedImage:(UIImage *)highlightedImage
    backgroundImage:(UIImage *)backgroundImage
backgroundHighlightedImage:(UIImage *)backgroundHighlightedImage;

@end
