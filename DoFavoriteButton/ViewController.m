//
//  ViewController.m
//  DoFavoriteButton
//
//  Created by Alpha Yu on 12/3/15.
//  Copyright © 2015 tlm group. All rights reserved.
//

#import "ViewController.h"
#import "DOFavoriteButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat width = (self.view.frame.size.width - 44.0) / 4.0;
    CGFloat x = width / 2.0;
    CGFloat y = self.view.frame.size.height / 2.0 - 22.0;
    
    DOFavoriteButton *starButton = [[DOFavoriteButton alloc] initWithFrame:CGRectMake(x, y, 44, 44) image:[UIImage imageNamed:@"star"]];
    [starButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:starButton];
    x += width;
    
    DOFavoriteButton *heartButton = [[DOFavoriteButton alloc] initWithFrame:CGRectMake(x, y, 44, 44) image:[UIImage imageNamed:@"heart"]];
    heartButton.imageColorOn = [UIColor colorWithRed:254.0 / 255.0 green:110.0 / 255.0 blue:111.0 / 255.0 alpha:1.0];
    heartButton.circleColor = [UIColor colorWithRed:254.0 / 255.0 green:110.0 / 255.0 blue:111.0 / 255.0 alpha:1.0];
    heartButton.lineColor = [UIColor colorWithRed:226.0 / 255.0 green:96.0 / 255.0 blue:96.0 / 255.0 alpha:1.0];
    [heartButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:heartButton];
    x += width;
    
    DOFavoriteButton *likeButton = [[DOFavoriteButton alloc] initWithFrame:CGRectMake(x, y, 44, 44) image:[UIImage imageNamed:@"like"]];
    likeButton.imageColorOn = [UIColor colorWithRed:52.0 / 255.0 green:152.0 / 255.0 blue:219.0 / 255.0 alpha:1.0];
    likeButton.circleColor = [UIColor colorWithRed:52.0 / 255.0 green:152.0 / 255.0 blue:219.0 / 255.0 alpha:1.0];
    likeButton.lineColor = [UIColor colorWithRed:41.0 / 255.0 green:128.0 / 255.0 blue:185.0 / 255.0 alpha:1.0];
    [likeButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:likeButton];
    x += width;
    
    DOFavoriteButton *smileButton = [[DOFavoriteButton alloc] initWithFrame:CGRectMake(x, y, 44, 44) image:[UIImage imageNamed:@"smile"]];
    smileButton.imageColorOn = [UIColor colorWithRed:45.0 / 255.0 green:204.0 / 255.0 blue:112.0 / 255.0 alpha:1.0];
    smileButton.circleColor = [UIColor colorWithRed:45.0 / 255.0 green:204.0 / 255.0 blue:112.0 / 255.0 alpha:1.0];
    smileButton.lineColor = [UIColor colorWithRed:45.0 / 255.0 green:195.0 / 255.0 blue:106.0 / 255.0 alpha:1.0];
    [smileButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:smileButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tappedButton:(DOFavoriteButton *)sender {
    if (sender.selected) {
        [sender deselect];
    } else {
        [sender select];
    }
}
@end
