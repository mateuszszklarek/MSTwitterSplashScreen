//
//  MSTwitterSplashScreen.m
//  MSTwitterSplashScreen
//
//  Created by Mateusz Szklarek on 24/04/15.
//  Copyright (c) 2015 Mateusz Szklarek. All rights reserved.
//

#import "MSTwitterSplashScreen.h"

@interface MSTwitterSplashScreen()

@property (nonatomic, copy) void(^animationCompletionHandler)();
@property (strong, nonatomic) UIColor *backgroundSplashScreenColor;
@property (strong, nonatomic) CAAnimation *logoAnimation;
@property (strong, nonatomic) CAShapeLayer *logoLayer;
@property (strong, nonatomic) CAGradientLayer *gradientLayer;

@end

@implementation MSTwitterSplashScreen

CGFloat const sizeScale = .2f;

- (instancetype)initSplashScreenWithBezierPath:(UIBezierPath *)bezierPath
                               backgroundColor:(UIColor *)backgroundColor
                                     logoColor:(UIColor *)logoColor
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        _backgroundSplashScreenColor = backgroundColor;
        _logoLayer = [self drawShapeLayerFromBezierPath:bezierPath];
        [self.layer addSublayer:_logoLayer];
        self.backgroundColor = logoColor;
    }
    return self;
}

- (instancetype)initSplashScreenWithBezierPath:(UIBezierPath *)bezierPath
                backgroundWithGradientFromTopColor:(UIColor *)topColor
                                   bottomColor:(UIColor *)bottomColor
                                     logoColor:(UIColor *)logoColor
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        _gradientLayer = [self drawShapeLayerBezierPath:bezierPath withGradientFromTopColor:topColor bottomColor:bottomColor];
        [self.layer addSublayer:_gradientLayer];
        self.backgroundColor = logoColor;
    }
    return self;
}

- (CAGradientLayer *)drawShapeLayerBezierPath:(UIBezierPath *)bezierPath withGradientFromTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor
{
    CGRect layerRectBounds = CGRectInset(self.bounds, -CGRectGetWidth(self.bounds) * sizeScale, -CGRectGetHeight(self.bounds) * sizeScale);
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = layerRectBounds;
    gradientLayer.anchorPoint = CGPointMake(0.5f, 0.5f);
    
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];

    CGMutablePathRef logoPath = CGPathCreateMutable();
    CGPathAddRect(logoPath, nil, layerRectBounds);
    
    CGPoint logoLocation = CGPointMake((CGRectGetWidth(self.bounds) - CGRectGetWidth(bezierPath.bounds))/2,
                                       (CGRectGetHeight(self.bounds) - CGRectGetHeight(bezierPath.bounds))/2);
    CGAffineTransform logoTransform = CGAffineTransformMakeTranslation(logoLocation.x, logoLocation.y);
    CGPathAddPath(logoPath, &logoTransform, bezierPath.CGPath);

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.bounds = layerRectBounds;
    shapeLayer.path = logoPath;
    shapeLayer.anchorPoint = CGPointZero;

    gradientLayer.mask = shapeLayer;

    return gradientLayer;
}

- (CAShapeLayer *)drawShapeLayerFromBezierPath:(UIBezierPath *)bezierPath
{
    CGRect shapeBounds = CGRectInset(self.bounds, -CGRectGetWidth(self.bounds), -CGRectGetHeight(self.bounds));

    CGMutablePathRef mutablePath = CGPathCreateMutable();
    CGPathAddRect(mutablePath, nil, shapeBounds);

    CGPoint logoLocation = CGPointMake((CGRectGetWidth(self.bounds) - CGRectGetWidth(bezierPath.bounds))/2,
                                       (CGRectGetHeight(self.bounds) - CGRectGetHeight(bezierPath.bounds)) /2);
    CGAffineTransform logoTransform = CGAffineTransformMakeTranslation(logoLocation.x, logoLocation.y);
    CGPathAddPath(mutablePath, &logoTransform, bezierPath.CGPath);
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.bounds = shapeBounds;
    shapeLayer.position = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
    shapeLayer.path = mutablePath;
    shapeLayer.anchorPoint = CGPointMake(0.5, 0.5);
    shapeLayer.fillColor = self.backgroundSplashScreenColor.CGColor;

    return shapeLayer;
}

- (void)startAnimation
{
    [self startAnimationWithCompletionHandler:nil];
}

- (void)startAnimationWithCompletionHandler:(void (^)())completionHandler
{
    self.animationCompletionHandler = completionHandler;
    self.logoAnimation.delegate = self;
    [self.gradientLayer addAnimation:self.logoAnimation forKey:nil];
    [self performSelector:@selector(setBackgroundColor:) withObject:[UIColor clearColor] afterDelay:self.durationAnimation * 0.45];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.animationCompletionHandler) {
        self.animationCompletionHandler();
    }
    [self removeFromSuperview];
}

- (CGFloat)durationAnimation
{
    if (!_durationAnimation) {
        _durationAnimation = 1.0f;
    }
    return _durationAnimation;
}

- (CAAnimation *)logoAnimation
{
    if (!_logoAnimation) {
        CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        keyFrameAnimation.values = @[@1, @0.9, @300];
        keyFrameAnimation.keyTimes = @[@0, @0.4, @1];
        keyFrameAnimation.duration = self.durationAnimation;
        keyFrameAnimation.removedOnCompletion = NO;
        keyFrameAnimation.fillMode = kCAFillModeForwards;
        keyFrameAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                              [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        _logoAnimation = keyFrameAnimation;
    }
    return _logoAnimation;
}

@end