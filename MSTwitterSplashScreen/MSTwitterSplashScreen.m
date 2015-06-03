//
//  MSTwitterSplashScreen.m
//  MSTwitterSplashScreen
//
//  Created by Mateusz Szklarek on 24/04/15.
//  Copyright (c) 2015 Mateusz Szklarek. All rights reserved.
//

#import "MSTwitterSplashScreen.h"

@interface MSTwitterSplashScreen ()

@property(nonatomic, copy) void(^animationCompletionHandler)();
@property(strong, nonatomic) CAAnimation *logoAnimation;
@property(strong, nonatomic) CALayer *gradientLayer;

@end

@implementation MSTwitterSplashScreen

static CGFloat const sizeScale = .2f;

- (instancetype)initSplashScreenWithBezierPath:(UIBezierPath *)bezierPath
                               backgroundColor:(UIColor *)backgroundColor
                                     logoColor:(UIColor *)logoColor
{
    return [self initSplashScreenWithBezierPath:bezierPath
             backgroundWithGradientFromTopColor:backgroundColor
                                    bottomColor:backgroundColor
                                      logoColor:logoColor];
}

- (instancetype)initSplashScreenWithBezierPath:(UIBezierPath *)bezierPath
            backgroundWithGradientFromTopColor:(UIColor *)topColor
                                   bottomColor:(UIColor *)bottomColor
                                     logoColor:(UIColor *)logoColor
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        if ([topColor isEqual:bottomColor]) {
            _gradientLayer = [self configureLayerWithLogoFromBezierPath:bezierPath withGradientFromTopColor:topColor bottomColor:topColor];
        }
        else {
            _gradientLayer = [self configureLayerWithLogoFromBezierPath:bezierPath withGradientFromTopColor:topColor bottomColor:bottomColor];
        }
        [self.layer addSublayer:_gradientLayer];
        self.backgroundColor = logoColor;
    }
    return self;
}

#pragma mark - Define size of layer

- (CGRect)layerSizeRect
{
    return CGRectInset(self.bounds, -CGRectGetWidth(self.bounds) * sizeScale, -CGRectGetHeight(self.bounds) * sizeScale);
}

- (CGMutablePathRef)mutableLogoPath
{
    CGMutablePathRef logoPath = CGPathCreateMutable();
    CGPathAddRect(logoPath, nil, [self layerSizeRect]);

    return logoPath;
}

#pragma mark - Layer with logo shape

- (CAShapeLayer *)getLayerFromBezierPath:(UIBezierPath *)bezierPath
{
    CGMutablePathRef logoPath = [self mutableLogoPath];
    
    CGPoint logoLocation = CGPointMake((CGRectGetWidth(self.bounds) - CGRectGetWidth(bezierPath.bounds)) / 2,
                                       (CGRectGetHeight(self.bounds) - CGRectGetHeight(bezierPath.bounds)) / 2);
    CGAffineTransform logoTransform = CGAffineTransformMakeTranslation(logoLocation.x, logoLocation.y);
    CGPathAddPath(logoPath, &logoTransform, bezierPath.CGPath);
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.bounds = [self layerSizeRect];
    shapeLayer.path = logoPath;
    shapeLayer.anchorPoint = CGPointZero;
    return shapeLayer;
}

#pragma mark - Layer with gradient

- (CAGradientLayer *)createGradientLayerWithGradientFromTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = [self layerSizeRect];
    gradientLayer.anchorPoint = CGPointMake(0.5f, 0.5f);
    gradientLayer.colors = [NSArray arrayWithObjects:(id) [topColor CGColor], (id) [bottomColor CGColor], nil];

    return gradientLayer;
}

- (CAGradientLayer *)configureLayerWithLogoFromBezierPath:(UIBezierPath *)bezierPath withGradientFromTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor
{
    CAGradientLayer *gradientLayer = [self createGradientLayerWithGradientFromTopColor:topColor bottomColor:bottomColor];
    CAShapeLayer *shapeLayer = [self getLayerFromBezierPath:bezierPath];
    gradientLayer.mask = shapeLayer;
    return gradientLayer;
}

#pragma mark - Animations

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