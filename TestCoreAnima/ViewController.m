//
//  ViewController.m
//  TestCoreAnima
//
//  Created by xu li on 16/3/23.
//  Copyright © 2016年 xu li. All rights reserved.
//

#import "ViewController.h"
#import "LXBestAnimaViewController.h"
#import "LXCuteView.h"

@interface ViewController () <LXCuteViewDidClick>
{
    UIView *_dynamicView;
    CAShapeLayer *_indicateLayer;
}
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self testCoreAnima];
}

- (void)testCoreAnima
{
    //画音量调节的效果
    [self test1];
    
    //画一个圈的效果，模仿加载进度
    [self test2];
    
    //显示指定形状的图片或其它视图
    [self test3];
    
    //画UIBezierPath
    [self pathAnimation];
    
    //抖动效果
    [self shakeAnimation];
    
    //旋转动画
    [self rotateAnimation];
    
    //执行的组动画
    [self groupAnimation];
    
#warning 点击或拖动右下角的按钮跳转
    [self createBestAnima];
}

- (void)viewDidDisappear:(BOOL)animated
{
    for (UIView *subview in [self.view subviews]) {
        [subview removeFromSuperview];
    }
    [super viewDidDisappear:YES];
}

#pragma - mark 画音量调节的效果
- (void)test1
{
    _dynamicView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 50, 200)];
    _dynamicView.backgroundColor = [UIColor grayColor];
    _dynamicView.layer.cornerRadius = _dynamicView.frame.size.width/2.0;
    _dynamicView.layer.masksToBounds = YES;
    _dynamicView.clipsToBounds = YES;
    [self.view addSubview:_dynamicView];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeVoice) userInfo:nil repeats:YES];
}

- (void)changeVoice
{
    [self refreshUIWithVoicePower:random()%10];
}

-(void)refreshUIWithVoicePower : (NSInteger)voicePower{
    CGFloat height = (voicePower)*(CGRectGetHeight(_dynamicView.frame)/10);
    
    [_indicateLayer removeFromSuperlayer];
    _indicateLayer = nil;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, CGRectGetHeight(_dynamicView.frame)-height, CGRectGetWidth(_dynamicView.frame), height) cornerRadius:0];
    _indicateLayer = [CAShapeLayer layer];
    _indicateLayer.path = path.CGPath;
    _indicateLayer.fillColor = [UIColor redColor].CGColor;
    [_dynamicView.layer addSublayer:_indicateLayer];
}

#pragma - mark 画一个圈的效果，模仿加载进度
- (void)test2
{
    UIView *_demoView = [[UIView alloc] initWithFrame:CGRectMake(100, 20, 200, 200)];
    [self.view addSubview:_demoView];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:_demoView.bounds];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = _demoView.bounds;
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    [_demoView.layer addSublayer:shapeLayer];
    
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 3.0f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [shapeLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
}

#pragma - mark 显示指定形状的图片视图或其它视图
- (void)test3
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 250, 100, 150)];
    imgView.backgroundColor = [UIColor orangeColor];
    imgView.image = [UIImage imageNamed:@"00"];
    
    [self.view addSubview:imgView];
    
    CAShapeLayer *layer = [self createMaskLayerWithView:imgView];
    imgView.layer.mask = layer;
}

- (CAShapeLayer *)createMaskLayerWithView : (UIView *)view{
    
    CGFloat viewWidth = CGRectGetWidth(view.frame);
    CGFloat viewHeight = CGRectGetHeight(view.frame);
    
    CGFloat rightSpace = 30.0;
    CGFloat topSpace = 35.0;
    
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(viewWidth-rightSpace, 0);
    CGPoint point3 = CGPointMake(viewWidth-rightSpace, topSpace);
    CGPoint point4 = CGPointMake(viewWidth, topSpace);
    CGPoint point5 = CGPointMake(viewWidth-rightSpace, topSpace+rightSpace);
    CGPoint point6 = CGPointMake(viewWidth-rightSpace, viewHeight);
    CGPoint point7 = CGPointMake(0, viewHeight);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path addLineToPoint:point6];
    [path addLineToPoint:point7];
    [path closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    
    return layer;
}

#pragma - mark path动画
-(void)pathAnimation{
    UIView *_demoView = [[UIView alloc] initWithFrame:CGRectMake(200, 280, 20, 20)];
    _demoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_demoView];
    
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(200, 280, 100, 100)];
    anima.path = path.CGPath;
    anima.duration = 2.0f;
    anima.fillMode = kCAFillModeForwards;
    anima.removedOnCompletion = NO;
    anima.repeatCount = 5;
    [_demoView.layer addAnimation:anima forKey:@"pathAnimation"];
}

#pragma - mark 抖动效果
-(void)shakeAnimation{
    UIButton *_demoView = [[UIButton alloc] initWithFrame:CGRectMake(20, 430, 200, 44)];
    _demoView.backgroundColor = [UIColor redColor];
    [_demoView setTitle:@"登陆" forState:UIControlStateNormal];
    [self.view addSubview:_demoView];
    
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];//在这里@"transform.rotation"==@"transform.rotation.z"
    NSValue *value1 = [NSNumber numberWithFloat:-M_PI/180*4];
    NSValue *value2 = [NSNumber numberWithFloat:M_PI/180*4];
    NSValue *value3 = [NSNumber numberWithFloat:-M_PI/180*4];
    anima.values = @[value1,value2,value3];
    anima.repeatCount = MAXFLOAT;
    
    [_demoView.layer addAnimation:anima forKey:@"shakeAnimation"];
}

#pragma - mark 旋转动画
-(void)rotateAnimation{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, 430, 50, 50)];
    imgView.image = [UIImage imageNamed:@"huan"];
    [self.view addSubview:imgView];
    
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//绕着z轴为矢量，进行旋转(@"transform.rotation.z"==@@"transform.rotation")
    anima.toValue = [NSNumber numberWithFloat:M_PI*2];
    anima.duration = 1.0f;
    anima.repeatCount = MAXFLOAT;
    [imgView.layer addAnimation:anima forKey:@"rotateAnimation"];
}

#pragma - mark 执行的组动画
- (void)groupAnimation
{
    UIImageView *_demoView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-20)/2.0, SCREEN_HEIGHT, 20, 20)];
    _demoView.image = [UIImage imageNamed:@"huan"];
    [self.view addSubview:_demoView];
    
    CFTimeInterval currentTime = CACurrentMediaTime();
    //位移动画
    CABasicAnimation *anima1 = [CABasicAnimation animationWithKeyPath:@"position"];
    anima1.fromValue = [NSValue valueWithCGPoint:CGPointMake((SCREEN_WIDTH-20)/2.0, SCREEN_HEIGHT)];
    anima1.toValue = [NSValue valueWithCGPoint:CGPointMake((SCREEN_WIDTH-20)/2.0, SCREEN_HEIGHT-120)];
    anima1.beginTime = currentTime;
    anima1.duration = 1.0f;
    anima1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anima1.fillMode = kCAFillModeForwards;
    anima1.removedOnCompletion = NO;
    [_demoView.layer addAnimation:anima1 forKey:@"aa"];
    
    //缩放动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:1.0f];
    anima2.toValue = [NSNumber numberWithFloat:2.0f];
    anima2.beginTime = currentTime+0.8f;
    anima2.duration = 1.0f;
    anima1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    anima2.fillMode = kCAFillModeForwards;
    anima2.removedOnCompletion = NO;
    [_demoView.layer addAnimation:anima2 forKey:@"bb"];
    
    //旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
    anima3.beginTime = currentTime+1.0f;
    anima3.duration = 1.0f;
    anima3.fillMode = kCAFillModeForwards;
    anima3.removedOnCompletion = NO;
    [_demoView.layer addAnimation:anima3 forKey:@"cc"];
}

#pragma - mark 下一页有完整动画
- (void)createBestAnima
{
    LXCuteView *chatButtonView = [[LXCuteView alloc] initWithPoint:CGPointMake(SCREEN_WIDTH-18-44, SCREEN_HEIGHT-120) superView:self.view];
    chatButtonView.delegate = self;
    chatButtonView.viscosity  = 20;
    chatButtonView.bubbleWidth = 44;
    chatButtonView.bubbleColor = LXColor(233, 75, 75);
    [chatButtonView setUpWithImage:[UIImage imageNamed:@"chat_but_sel"] withHighlightedImage:[UIImage imageNamed:@"chat_but"]];
    //    [chatButtonView.bubbleLabel setTitle:@"点我" forState:UIControlStateNormal];
    [self.view addSubview:chatButtonView];
}

- (void)cuteViewDidClick
{
    [self presentViewController:[[LXBestAnimaViewController alloc] init] animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


