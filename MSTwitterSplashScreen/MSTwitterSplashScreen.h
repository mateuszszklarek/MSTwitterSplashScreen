//
//  MSTwitterSplashScreen.h
//  MSTwitterSplashScreen
//
//  Created by Mateusz Szklarek on 24/04/15.
//  Copyright (c) 2015 Mateusz Szklarek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSTwitterSplashScreen : UIView

@property (nonatomic, assign) CGFloat durationAnimation;

- (instancetype)initSplashScreenWithBezierPath:(UIBezierPath *)bezierPath
                               backgroundColor:(UIColor *)backgroundColor
                                     logoColor:(UIColor *)logoColor;

- (instancetype)initSplashScreenWithBezierPath:(UIBezierPath *)bezierPath
            backgroundWithGradientFromTopColor:(UIColor *)topColor
                                   bottomColor:(UIColor *)bottomColor
                                     logoColor:(UIColor *)logoColor;

- (void)startAnimation;

@end
