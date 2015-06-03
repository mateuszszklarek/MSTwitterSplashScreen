//
//  MSTwitterSplashViewController.m
//  MSTwitterSplashScreenExample
//
//  Created by Mateusz Szklarek on 24/04/15.
//  Copyright (c) 2015 Mateusz Szklarek. All rights reserved.
//

#import "MSTwitterSplashViewController.h"
#import "MSTwitterSplashScreen.h"
#import "UIBezierPath+LogoShape.h"

@interface MSTwitterSplashViewController()

@property (strong, nonatomic) MSTwitterSplashScreen *twitterSplashScreen;

@end

@implementation MSTwitterSplashViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *backgroundColor = [UIColor colorWithRed:0.275 green:0.604 blue:0.915 alpha:1.000];
    UIColor *topColor = [UIColor colorWithRed:0.683 green:0.808 blue:0.998 alpha:1.000];
    UIColor *bottomColor = [UIColor colorWithRed:0.088 green:0.410 blue:0.997 alpha:1.000];
    
    UIColor *logoColor = [UIColor whiteColor];
    UIBezierPath *bezierPath = [UIBezierPath logoShape];
    
    //For layer with gradient from two colors
    MSTwitterSplashScreen *splashScreen = [[MSTwitterSplashScreen alloc] initSplashScreenWithBezierPath:bezierPath
                                                                     backgroundWithGradientFromTopColor:topColor
                                                                                            bottomColor:bottomColor
                                                                                              logoColor:logoColor];
    
    //For layer with background color
//    MSTwitterSplashScreen *splashScreen = [[MSTwitterSplashScreen alloc] initSplashScreenWithBezierPath:bezierPath
//                                                                                        backgroundColor:backgroundColor
//                                                                                              logoColor:logoColor];
    splashScreen.durationAnimation = 1.8;

    self.twitterSplashScreen = splashScreen;
    [self.view addSubview:self.twitterSplashScreen];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.twitterSplashScreen startAnimation];
    });
}

@end
