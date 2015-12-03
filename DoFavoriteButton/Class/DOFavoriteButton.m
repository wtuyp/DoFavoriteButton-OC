//
//  DOFavoriteButton.m
//  DoFavoriteButton
//
//  Created by Alpha Yu on 12/3/15.
//  Copyright © 2015 tlm group. All rights reserved.
//

#import "DOFavoriteButton.h"

@implementation DOFavoriteButton {
    CAShapeLayer *imageShape;
    CAShapeLayer *circleShape;
    CAShapeLayer *circleMask;
    
    NSMutableArray<CAShapeLayer *> *lines;
    
    CAKeyframeAnimation *circleTransform;
    CAKeyframeAnimation *circleMaskTransform;
    CAKeyframeAnimation *lineStrokeStart;
    CAKeyframeAnimation *lineStrokeEnd;
    CAKeyframeAnimation *lineOpacity;
    CAKeyframeAnimation *imageTransform;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _circleColor = [UIColor colorWithRed:255.0 / 255.0 green:172.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
        _lineColor = [UIColor colorWithRed:250.0 / 255.0 green:120.0 / 255.0 blue:68.0 / 255.0 alpha:1.0];
        _imageColorOn = [UIColor colorWithRed:255.0 / 255.0 green:172.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
        _imageColorOff = [UIColor colorWithRed:136.0 / 255.0 green:153.0 / 255.0 blue:166.0 / 255.0 alpha:1.0];
        
        circleTransform = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        circleMaskTransform = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        lineStrokeStart = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
        lineStrokeEnd = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
        lineOpacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        imageTransform = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        
        [self addTargets];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image {
    self = [super initWithFrame:frame];
    if (self) {
        _image = image;
        
        _circleColor = [UIColor colorWithRed:255.0 / 255.0 green:172.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
        _lineColor = [UIColor colorWithRed:250.0 / 255.0 green:120.0 / 255.0 blue:68.0 / 255.0 alpha:1.0];
        _imageColorOn = [UIColor colorWithRed:255.0 / 255.0 green:172.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
        _imageColorOff = [UIColor colorWithRed:136.0 / 255.0 green:153.0 / 255.0 blue:166.0 / 255.0 alpha:1.0];
        
        circleTransform = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        circleMaskTransform = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        lineStrokeStart = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
        lineStrokeEnd = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
        lineOpacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        imageTransform = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        
        [self createLayers:_image];
        [self addTargets];
    }
    return self;
}

- (void)createLayers:(UIImage *)image {
    self.layer.sublayers = nil;
    
    CGRect imageFrame = CGRectMake(self.frame.size.width / 2.0 - 8.0, self.frame.size.height / 2.0 - 8.0, 16.0, 16.0);
    CGPoint imgCenterPoint = CGPointMake(CGRectGetMidX(imageFrame), CGRectGetMidY(imageFrame));
    CGRect lineFrame = CGRectInset(imageFrame, -4.0, -4.0);
    
    //===============
    // circle layer
    //===============
    circleShape = [CAShapeLayer layer];
    circleShape.bounds = imageFrame;
    circleShape.position = imgCenterPoint;
    circleShape.path = [UIBezierPath bezierPathWithOvalInRect:imageFrame].CGPath;
    circleShape.fillColor = _circleColor.CGColor;
    circleShape.transform = CATransform3DMakeScale(0.0, 0.0, 1.0);
    [self.layer addSublayer:circleShape];
    
    circleMask = [CAShapeLayer layer];
    circleMask.bounds = imageFrame;
    circleMask.position = imgCenterPoint;
    circleMask.fillRule = kCAFillRuleEvenOdd;
    circleShape.mask = circleMask;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:imageFrame];
    [maskPath addArcWithCenter:imgCenterPoint radius:0.1 startAngle:0.0 endAngle:M_PI * 2 clockwise:YES];
    circleMask.path = maskPath.CGPath;
    
    //===============
    // line layer
    //===============
    lines = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 5; i++) {
        CAShapeLayer *line = [CAShapeLayer layer];
        line.bounds = lineFrame;
        line.position = imgCenterPoint;
        line.masksToBounds = YES;
        line.actions = @{@"strokeStart": [NSNull null], @"strokeEnd": [NSNull null]};
        line.strokeColor = _lineColor.CGColor;
        line.lineWidth = 1.25;
        line.miterLimit = 1.25;
        line.path = ({
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathMoveToPoint(path, nil, CGRectGetMidX(lineFrame), CGRectGetMidY(lineFrame));
            CGPathAddLineToPoint(path, nil, lineFrame.origin.x + lineFrame.size.width / 2, lineFrame.origin.y);
            path;
        });
        line.lineCap = kCALineCapRound;
        line.lineJoin = kCALineJoinRound;
        line.strokeStart = 0.0;
        line.strokeEnd = 0.0;
        line.opacity = 0.0;
        line.transform = CATransform3DMakeRotation(M_PI / 5.0 * (i * 2.0 + 1.0), 0.0, 0.0, 1.0);
        [self.layer addSublayer:line];
        [lines addObject:line];
    }
    
    //===============
    // image layer
    //===============
    imageShape = [CAShapeLayer layer];
    imageShape.bounds = imageFrame;
    imageShape.position = imgCenterPoint;
    imageShape.path = [UIBezierPath bezierPathWithRect:imageFrame].CGPath;
    imageShape.fillColor = _imageColorOff.CGColor;
    imageShape.actions = @{@"fillColor": [NSNull null]};
    [self.layer addSublayer:imageShape];
    
    imageShape.mask = [CALayer layer];
    imageShape.mask.contents = (__bridge id _Nullable)(_image.CGImage);
    imageShape.mask.bounds = imageFrame;
    imageShape.mask.position = imgCenterPoint;
    
    //==============================
    // circle transform animation
    //==============================
    circleTransform.duration = 0.333; // 0.0333 * 10
    circleTransform.values = @[
                               [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0,  0.0,  1.0)],
                               [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5,  0.5,  1.0)],
                               [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0,  1.0,  1.0)],
                               [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2,  1.2,  1.0)],
                               [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3,  1.3,  1.0)],
                               [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.37, 1.37, 1.0)],
                               [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.4,  1.4,  1.0)],
                               [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.4,  1.4,  1.0)]
                              ];
    circleTransform.keyTimes = @[
                                @0.0,    //  0/10
                                @0.1,    //  1/10
                                @0.2,    //  2/10
                                @0.3,    //  3/10
                                @0.4,    //  4/10
                                @0.5,    //  5/10
                                @0.6,    //  6/10
                                @1.0     // 10/10
                                ];
    
    circleMaskTransform.duration = 0.333; // 0.0333 * 10
    circleMaskTransform.values = @[
                                  [NSValue valueWithCATransform3D:CATransform3DIdentity],                                                                       //  0/10
                                  [NSValue valueWithCATransform3D:CATransform3DIdentity],                                                                       //  2/10
                                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(imageFrame.size.width * 1.25,  imageFrame.size.height * 1.25,  1.0)],  //  3/10
                                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(imageFrame.size.width * 2.688,  imageFrame.size.height * 2.688,  1.0)],//  4/10
                                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(imageFrame.size.width * 3.923,  imageFrame.size.height * 3.923,  1.0)],//  5/10
                                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(imageFrame.size.width * 4.375,  imageFrame.size.height * 4.375,  1.0)],//  6/10
                                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(imageFrame.size.width * 4.731,  imageFrame.size.height * 4.731,  1.0)],//  7/10
                                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(imageFrame.size.width * 5.0,  imageFrame.size.height * 5.0,  1.0)],    //  9/10
                                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(imageFrame.size.width * 5.0,  imageFrame.size.height * 5.0,  1.0)]     // 10/10
                                  ];
    circleMaskTransform.keyTimes = @[
                                    @0.0,    //  0/10
                                    @0.2,    //  2/10
                                    @0.3,    //  3/10
                                    @0.4,    //  4/10
                                    @0.5,    //  5/10
                                    @0.6,    //  6/10
                                    @0.7,    //  7/10
                                    @0.9,    //  9/10
                                    @1.0     // 10/10
                                    ];
    
    //==============================
    // line stroke animation
    //==============================
    lineStrokeStart.duration = 0.6; //0.0333 * 18
    lineStrokeStart.values = @[
                              @0.0,    //  0/18
                              @0.0,    //  1/18
                              @0.18,   //  2/18
                              @0.2,    //  3/18
                              @0.26,   //  4/18
                              @0.32,   //  5/18
                              @0.4,    //  6/18
                              @0.6,    //  7/18
                              @0.71,   //  8/18
                              @0.89,   // 17/18
                              @0.92    // 18/18
                              ];
    lineStrokeStart.keyTimes = @[
                                @0.0,    //  0/18
                                @0.056,  //  1/18
                                @0.111,  //  2/18
                                @0.167,  //  3/18
                                @0.222,  //  4/18
                                @0.278,  //  5/18
                                @0.333,  //  6/18
                                @0.389,  //  7/18
                                @0.444,  //  8/18
                                @0.944,  // 17/18
                                @1.0,    // 18/18
                                ];
    
    lineStrokeEnd.duration = 0.6; //0.0333 * 18
    lineStrokeEnd.values = @[
                            @0.0,    //  0/18
                            @0.0,    //  1/18
                            @0.32,   //  2/18
                            @0.48,   //  3/18
                            @0.64,   //  4/18
                            @0.68,   //  5/18
                            @0.92,   // 17/18
                            @0.92    // 18/18
                            ];
    lineStrokeEnd.keyTimes = @[
                              @0.0,    //  0/18
                              @0.056,  //  1/18
                              @0.111,  //  2/18
                              @0.167,  //  3/18
                              @0.222,  //  4/18
                              @0.278,  //  5/18
                              @0.944,  // 17/18
                              @1.0,    // 18/18
                              ];
    
    lineOpacity.duration = 1.0; //0.0333 * 30
    lineOpacity.values = @[
                          @1.0,    //  0/30
                          @1.0,    // 12/30
                          @0.0     // 17/30
                          ];
    lineOpacity.keyTimes = @[
                            @0.0,    //  0/30
                            @0.4,    // 12/30
                            @0.567   // 17/30
                            ];
    
    //==============================
    // image transform animation
    //==============================
    imageTransform.duration = 1.0; //0.0333 * 30
    imageTransform.values = @[
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 1.0)],   //  0/30
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 1.0)],   //  3/30
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)],   //  9/30
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.25, 1.25, 1.0)], // 10/30
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)],   // 11/30
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],   // 14/30
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.875, 0.875, 1.0)],// 15/30
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.875, 0.875, 1.0)],// 16/30
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],   // 17/30
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.013, 1.013, 1.0)],// 20/30
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.025, 1.025, 1.0)],// 21/30
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.013, 1.013, 1.0)],// 22/30
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.96, 0.96, 1.0)], // 25/30
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1.0)], // 26/30
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.96, 0.96, 1.0)], // 27/30
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.99, 0.99, 1.0)], // 29/30
                              [NSValue valueWithCATransform3D:CATransform3DIdentity]                    // 30/30
                              ];
    imageTransform.keyTimes = @[
                               @0.0,    //  0/30
                               @0.1,    //  3/30
                               @0.3,    //  9/30
                               @0.333,  // 10/30
                               @0.367,  // 11/30
                               @0.467,  // 14/30
                               @0.5,    // 15/30
                               @0.533,  // 16/30
                               @0.567,  // 17/30
                               @0.667,  // 20/30
                               @0.7,    // 21/30
                               @0.733,  // 22/30
                               @0.833,  // 25/30
                               @0.867,  // 26/30
                               @0.9,    // 27/30
                               @0.967,  // 29/30
                               @1.0     // 30/30
                               ];
    
    
}

- (void)setImage:(UIImage *)image {
    _image = image;
    [self createLayers:_image];
}

- (void)setCircleColor:(UIColor *)circleColor {
    _circleColor = circleColor;
    circleShape.fillColor = _circleColor.CGColor;
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    for (CAShapeLayer *line in lines) {
        line.strokeColor = _lineColor.CGColor;
    }
}

- (void)setImageColorOn:(UIColor *)imageColorOn {
    _imageColorOn = imageColorOn;
    if (self.selected) {
        imageShape.fillColor = _imageColorOn.CGColor;
    }
}

- (void)setImageColorOff:(UIColor *)imageColorOff {
    _imageColorOff = imageColorOff;
    if (!self.selected) {
        imageShape.fillColor = _imageColorOff.CGColor;
    }
}

- (void)setDuration:(NSTimeInterval )duration {
    _duration = duration;
    
    circleTransform.duration = 0.333 * _duration;       // 0.0333 * 10
    circleMaskTransform.duration = 0.333 * _duration;   // 0.0333 * 10
    lineStrokeStart.duration = 0.6 * _duration;         //0.0333 * 18
    lineStrokeEnd.duration = 0.6 * _duration;           //0.0333 * 18
    lineOpacity.duration = 1.0 * _duration;             //0.0333 * 30
    imageTransform.duration = 1.0 * _duration;          //0.0333 * 30
}

- (void)select {
    self.selected = YES;
    imageShape.fillColor = _imageColorOn.CGColor;
    
    [CATransaction begin];
    [circleShape addAnimation:circleTransform forKey:@"transform"];
    [circleMask addAnimation:circleMaskTransform forKey:@"transform"];
    [imageShape addAnimation:imageTransform forKey:@"transform"];
    
    for (NSInteger i = 0; i < 5; i++) {
        [lines[i] addAnimation:lineStrokeStart forKey:@"strokeStart"];
        [lines[i] addAnimation:lineStrokeEnd forKey:@"strokeEnd"];
        [lines[i] addAnimation:lineOpacity forKey:@"opacity"];
    }
    
    [CATransaction commit];
}

- (void)deselect {
    self.selected = NO;
    imageShape.fillColor = _imageColorOff.CGColor;
    
    // remove all animations
    [circleShape removeAllAnimations];
    [circleMask removeAllAnimations];
    [imageShape removeAllAnimations];
    [lines[0] removeAllAnimations];
    [lines[1] removeAllAnimations];
    [lines[2] removeAllAnimations];
    [lines[3] removeAllAnimations];
    [lines[4] removeAllAnimations];
}

- (void)addTargets {
    [self addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(touchDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [self addTarget:self action:@selector(touchDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(touchCancel:) forControlEvents:UIControlEventTouchCancel];
}

- (void)touchDown:(DOFavoriteButton *)sender {
    self.layer.opacity = 0.4;
}

- (void)touchUpInside:(DOFavoriteButton *)sender {
    self.layer.opacity = 1.0;
}

- (void)touchDragExit:(DOFavoriteButton *)sender {
    self.layer.opacity = 1.0;
}

- (void)touchDragEnter:(DOFavoriteButton *)sender {
    self.layer.opacity = 0.4;
}

- (void)touchCancel:(DOFavoriteButton *)sender {
    self.layer.opacity = 1.0;
}
@end
