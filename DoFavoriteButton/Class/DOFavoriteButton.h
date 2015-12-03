//
//  DOFavoriteButton.h
//  DoFavoriteButton
//
//  Created by Alpha Yu on 12/3/15.
//  Copyright © 2015 tlm group. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface DOFavoriteButton : UIButton

@property (nonatomic, strong) IBInspectable UIImage *image;
@property (nonatomic, strong) IBInspectable UIColor *circleColor;
@property (nonatomic, strong) IBInspectable UIColor *lineColor;
@property (nonatomic, strong) IBInspectable UIColor *imageColorOn;
@property (nonatomic, strong) IBInspectable UIColor *imageColorOff;
@property (nonatomic, assign) IBInspectable NSTimeInterval duration;

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image;
- (void)select;
- (void)deselect;

@end
