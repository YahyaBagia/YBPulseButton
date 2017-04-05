//
//  YBPulseButton.h
//  YBPulseButton
//
//  Created by Yahya on 05/04/17.
//  Copyright © 2017 yahya. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface YBPulseButton : UIButton

@property (nonatomic, retain) CAShapeLayer *mainLayer;
@property (nonatomic, retain) CAAnimationGroup *animationGroup;
@property (nonatomic, retain) IBInspectable UIColor *pulseColor;
@property (nonatomic) IBInspectable CGFloat pulseRadius;
@property (nonatomic) IBInspectable CGFloat pulseDuration;
@property (nonatomic, retain) IBInspectable UIColor *buttonColor;
@property (nonatomic) IBInspectable CGFloat cornerRadius;

-(instancetype)initWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)backgroundColor;

@end
