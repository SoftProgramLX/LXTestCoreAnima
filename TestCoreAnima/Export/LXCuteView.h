//
//  LXCuteView.h
//  LXBaseConfigProject
//
//  Created by LX on 2/26/15.
//  Copyright (c) 2015 LX. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol LXCuteViewDidClick <NSObject>
@optional
- (void)cuteViewDidClick;
@end

@interface LXCuteView : UIView

@property(nonatomic,weak) id<LXCuteViewDidClick> delegate;
//气泡的直径
//bubble's diameter
@property (nonatomic,assign)CGFloat bubbleWidth;
//气泡粘性系数，越大可以拉得越长
//viscosity of the bubble,the bigger you set,the longer you drag
@property (nonatomic,assign)CGFloat viscosity;
//气泡颜色
//bubble's color
@property (nonatomic,strong)UIColor *bubbleColor;

#pragma optional
//父视图
//set the view which you wanna add the 'cuteBubble'
@property (nonatomic,weak)UIView *containerView;
//气泡上显示数字的label
//the label on the bubble
@property (nonatomic,strong)UIButton *bubbleLabel;
//需要隐藏气泡时候可以使用这个属性：self.frontView.hidden = YES;
//if you wanna hidden the bubble, you can ’self.frontView.hidden = YES‘
@property(nonatomic,strong) UIView *frontView;


-(id)initWithPoint:(CGPoint)point superView:(UIView *)view;
-(void)setUpWithImage:(UIImage *)image withHighlightedImage:(UIImage *)highlightedImage;
-(void)addGesture;
- (void)removeTheViewAndAnimation;

@end
