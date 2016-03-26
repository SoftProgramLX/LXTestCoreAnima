//
//  LXCuteView.h
//  LXBaseConfigProject
//
//  Created by LX on 2/26/15.
//  Copyright (c) 2015 LX. All rights reserved.
//


#import "LXCuteView.h"

@implementation LXCuteView
{
    UIBezierPath *cutePath;
    UIColor *fillColorForCute;
    UIDynamicAnimator *animator;
    UISnapBehavior  *snap;
    
    UIView *backView;
    CGFloat r1; // backView
    CGFloat r2; // frontView
    CGFloat x1;
    CGFloat y1;
    CGFloat x2;
    CGFloat y2;
    CGFloat centerDistance;
    CGFloat cosDigree;
    CGFloat sinDigree;
    
    CGPoint pointA; //A
    CGPoint pointB; //B
    CGPoint pointD; //D
    CGPoint pointC; //C
    CGPoint pointO; //O
    CGPoint pointP; //P
    
    CGRect oldBackViewFrame;
    CGPoint initialPoint;
    CGPoint oldBackViewCenter;
    CAShapeLayer *shapeLayer;
    
}

-(id)initWithPoint:(CGPoint)point superView:(UIView *)view
{
    self = [super initWithFrame:CGRectMake(point.x, point.y, self.bubbleWidth, self.bubbleWidth)];
    if(self){
        
        initialPoint = point;
        self.containerView = view;
        [self.containerView addSubview:self];
    }
    return self;
}

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self setUp];
//        [self addGesture];
//    }
//    return self;
//}

//每隔一帧刷新屏幕的定时器
-(void)displayLinkAction:(CADisplayLink *)dis
{
    x1 = backView.center.x;
    y1 = backView.center.y;
    x2 = self.frontView.center.x;
    y2 = self.frontView.center.y;

    centerDistance = sqrtf((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1));
    if (centerDistance == 0) {
        cosDigree = 1;
        sinDigree = 0;
    }else{
        cosDigree = (y2-y1)/centerDistance;
        sinDigree = (x2-x1)/centerDistance;
    }
//    NSLog(@"%f", acosf(cosDigree));
    r1 = oldBackViewFrame.size.width / 2 - centerDistance/self.viscosity;
    
    pointA = CGPointMake(x1-r1*cosDigree, y1+r1*sinDigree);  // A
    pointB = CGPointMake(x1+r1*cosDigree, y1-r1*sinDigree); // B
    pointD = CGPointMake(x2-r2*cosDigree, y2+r2*sinDigree); // D
    pointC = CGPointMake(x2+r2*cosDigree, y2-r2*sinDigree);// C
    pointO = CGPointMake(pointA.x + (centerDistance / 2)*sinDigree, pointA.y + (centerDistance / 2)*cosDigree);
    pointP = CGPointMake(pointB.x + (centerDistance / 2)*sinDigree, pointB.y + (centerDistance / 2)*cosDigree);
    
    [self drawRect];
}

-(void)drawRect
{
    backView.center = oldBackViewCenter;
    backView.bounds = CGRectMake(0, 0, r1*2, r1*2);
    backView.layer.cornerRadius = r1;

    cutePath = [UIBezierPath bezierPath];
    [cutePath moveToPoint:pointA];
    [cutePath addQuadCurveToPoint:pointD controlPoint:pointO];
    [cutePath addLineToPoint:pointC];
    [cutePath addQuadCurveToPoint:pointB controlPoint:pointP];
    [cutePath moveToPoint:pointA];
    
    if (backView.hidden == NO) {
        shapeLayer.path = [cutePath CGPath];
        shapeLayer.fillColor = [fillColorForCute CGColor];
        [self.containerView.layer insertSublayer:shapeLayer below:self.frontView.layer];
    }
}

-(void)setUpWithImage:(UIImage *)image withHighlightedImage:(UIImage *)highlightedImage
{
    shapeLayer = [CAShapeLayer layer];
    
    self.backgroundColor = [UIColor clearColor];
    self.frontView = [[UIView alloc]initWithFrame:CGRectMake(initialPoint.x,initialPoint.y, self.bubbleWidth, self.bubbleWidth)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(frontViewDidClick)];
    self.frontView.userInteractionEnabled = YES;
    [self.frontView addGestureRecognizer:tap];
    
    r2 = self.frontView.bounds.size.width / 2;
    self.frontView.layer.cornerRadius = r2;
    //self.frontView.backgroundColor = self.bubbleColor;
    
    backView = [[UIView alloc]initWithFrame:self.frontView.frame];
    r1 = backView.bounds.size.width / 2;
    backView.layer.cornerRadius = r1;
    backView.backgroundColor = self.bubbleColor;
    
    self.bubbleLabel = [[UIButton alloc]init];
    self.bubbleLabel.frame = CGRectMake(0, 0, self.frontView.bounds.size.width, self.frontView.bounds.size.height);
    [self.bubbleLabel setBackgroundImage:image forState:UIControlStateNormal];
    [self.bubbleLabel setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    [self.bubbleLabel addTarget:self action:@selector(frontViewDidClick) forControlEvents:UIControlEventTouchUpInside];
    //self.bubbleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.frontView insertSubview:self.bubbleLabel atIndex:0];

    [self.containerView addSubview:backView];
    [self.containerView addSubview:self.frontView];
    
    x1 = backView.center.x;
    y1 = backView.center.y;
    x2 = self.frontView.center.x;
    y2 = self.frontView.center.y;
    
    pointA = CGPointMake(x1-r1,y1);   // A
    pointB = CGPointMake(x1+r1, y1);  // B
    pointD = CGPointMake(x2-r2, y2);  // D
    pointC = CGPointMake(x2+r2, y2);  // C
    pointO = CGPointMake(x1-r1,y1);   // O
    pointP = CGPointMake(x2+r2, y2);  // P
    
    oldBackViewFrame = backView.frame;
    oldBackViewCenter = backView.center;

    backView.hidden = YES;//为了看到frontView的气泡晃动效果，需要展示隐藏backView
    [self AddAniamtionLikeGameCenterBubble];
    [self addGesture];
}

-(void)addGesture
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragMe:)];
    [self.frontView addGestureRecognizer:pan];
}

-(void)dragMe:(UIPanGestureRecognizer *)ges
{
    CGPoint dragPoint = [ges locationInView:self.containerView];

    if (ges.state == UIGestureRecognizerStateBegan) {
        backView.hidden = NO;
        fillColorForCute = self.bubbleColor;
        [self RemoveAniamtionLikeGameCenterBubble];
//        if (displayLink == nil) {
//            displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction:)];
//            [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
//        }

    }else if (ges.state == UIGestureRecognizerStateChanged){
        self.frontView.center = dragPoint;
        if (r1 <= 6) {

            fillColorForCute = [UIColor clearColor];
            backView.hidden = YES;
            [shapeLayer removeFromSuperlayer];
//            [displayLink invalidate];
//            displayLink = nil;
        }

    }else if (ges.state == UIGestureRecognizerStateEnded || ges.state ==UIGestureRecognizerStateCancelled || ges.state == UIGestureRecognizerStateFailed){
        
        backView.hidden = YES;
        fillColorForCute = [UIColor clearColor];
        [shapeLayer removeFromSuperlayer];
        [UIView animateWithDuration:0.5 delay:0.0f usingSpringWithDamping:0.4f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.frontView.center = oldBackViewCenter;
        } completion:^(BOOL finished) {
            
            if (finished) {
                [self AddAniamtionLikeGameCenterBubble];
//                [displayLink invalidate];
//                displayLink = nil;
            }
            
        }];
    
    }
    
    //bb-coder:after delete displaylink , we should add this method
    [self displayLinkAction:nil];
}

//----类似GameCenter的气泡晃动动画------
-(void)AddAniamtionLikeGameCenterBubble
{
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.repeatCount = INFINITY;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.duration = 5.0;
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGRect circleContainer = CGRectInset(self.frontView.frame, self.frontView.bounds.size.width / 2 - 3, self.frontView.bounds.size.width / 2 - 3);
    CGPathAddEllipseInRect(curvedPath, NULL, circleContainer);
    
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    [self.frontView.layer addAnimation:pathAnimation forKey:@"myCircleAnimation"];
    
    CAKeyframeAnimation *scaleX = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleX.duration = 1;
    scaleX.values = @[@1.0, @1.1, @1.0];
    scaleX.keyTimes = @[@0.0, @0.5, @1.0];
    scaleX.repeatCount = INFINITY;
    scaleX.autoreverses = YES;

    scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.frontView.layer addAnimation:scaleX forKey:@"scaleXAnimation"];
    
    CAKeyframeAnimation *scaleY = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleY.duration = 1.5;
    scaleY.values = @[@1.0, @1.1, @1.0];
    scaleY.keyTimes = @[@0.0, @0.5, @1.0];
    scaleY.repeatCount = INFINITY;
    scaleY.autoreverses = YES;
    scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.frontView.layer addAnimation:scaleY forKey:@"scaleYAnimation"];
}

-(void)RemoveAniamtionLikeGameCenterBubble
{
    [self.frontView.layer removeAllAnimations];
}

- (void)frontViewDidClick
{
    if ([self.delegate respondsToSelector:@selector(cuteViewDidClick)]) {
        [self.delegate cuteViewDidClick];
    }
}

- (void)removeTheViewAndAnimation
{
    [self.frontView removeFromSuperview];
    self.frontView = nil;
    
    [self RemoveAniamtionLikeGameCenterBubble];
    
}

@end



