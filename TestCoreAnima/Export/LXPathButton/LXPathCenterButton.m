//
//  TestCoreAnima
//
//  Created by 李旭 on 16/3/25.
//  Copyright © 2016年 xu li. All rights reserved.
//

#import "LXPathCenterButton.h"

@implementation LXPathCenterButton

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage 
{
    if (self = [super initWithImage:image highlightedImage:highlightedImage]) {
        
        self.userInteractionEnabled = YES;
        
        self.image = image;
        self.highlightedImage = highlightedImage;
        
    }
    return self;
}

#pragma mark - Scale Center Button Frame to 5x

- (CGRect)scaleRect:(CGRect)originRect
{
    return CGRectMake(- originRect.size.width,
                      - originRect.size.height,
                      originRect.size.width * 3,
                      originRect.size.height * 3);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.highlighted = YES;
    
    // Center button Begin Tapped
    if ([_delegate respondsToSelector:@selector(centerButtonTapped)]) {
        [_delegate centerButtonTapped];
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint currentLocation = [[touches anyObject]locationInView:self];
    
    
    // Cancel button highlight when the touch location is out of 5x area
    //
    if (!CGRectContainsPoint([self scaleRect:self.bounds] , currentLocation)) {
        self.highlighted = NO;
        return ;
    }
    
    // If moving in the 3x area, keep the highlight state
    //
    self.highlighted = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.highlighted = NO;
}

@end
