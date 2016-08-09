
#CoreAnimation的使用，由见简到难
用CoreAnima框架写了一些常用和炫的动画

源码请点击[github地址](https://github.com/SoftProgramLX/LXTestCoreAnima)下载。<br>
首先看一下如下效果图感兴趣再继续查看。
<br>
![screen.gif](http://upload-images.jianshu.io/upload_images/301102-d3a36d2f4352398b.gif?imageMogr2/auto-orient/strip)
<br>
初级主要功能如下：<br>
```
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
```
高级主要功能如下：<br>
```
    //仿造facebook，点赞动画
    [self clickGoodAnimation];
    //仿Path 菜单动画
    [self pathAnimation];
    //仿造钉钉菜单动画
    [self dingdingAnimation];
```
<br>
1.下面贴出显示指定形状的图片视图或其它视图功能的代码:<br>

```
- (void)test3
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 250, 100, 150)];
    imgView.backgroundColor = [UIColor orangeColor];
    imgView.image = [UIImage imageNamed:@"00"];
    
    [self.view addSubview:imgView];
    
    CAShapeLayer *layer = [self createMaskLayerWithView:imgView];
    imgView.layer.mask = layer;
}

- (CAShapeLayer *)createMaskLayerWithView: (UIView *)view
{
    
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
```
效果如下图：<br>
![screen.png](http://upload-images.jianshu.io/upload_images/301102-342abdd374f880d1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
<br>
就是根据point1～point7这七个点折线围成的一个封闭区域所绘制的一个图形。<br>

----
2.执行的组动画代码如下
```
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
```
----
3.更多功能代码点击[github地址](https://github.com/SoftProgramLX/LXTestCoreAnima)下载源码查看。<br>

----

<br>
###QQ:2239344645    [我的github](https://github.com/SoftProgramLX?tab=repositories)
<br>
