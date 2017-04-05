//
//  YBPulseButton.m
//  YBPulseButton
//
//  Created by Yahya on 05/04/17.
//  Copyright © 2017 yahya. All rights reserved.
//

#import "YBPulseButton.h"

@implementation YBPulseButton


-(instancetype)initWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)backgroundColor{
    self = [super initWithFrame:frame];
    _buttonColor = backgroundColor;
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self setup];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    CAShapeLayer *pulse = [self createPulse];
    [self.layer insertSublayer:pulse below:_mainLayer];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        //Background Thread
        [self createAnimationGroup];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [pulse addAnimation:_animationGroup forKey:@"pulse"];
        });
    });
    
}

-(void)setup{
    _mainLayer = [CAShapeLayer new];
    _mainLayer.backgroundColor = _buttonColor.CGColor;
    _mainLayer.bounds = self.bounds;
    _mainLayer.cornerRadius = _cornerRadius;
    _mainLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _mainLayer.zPosition = -1;
    
    [self.layer addSublayer:_mainLayer];
}

-(CAShapeLayer *)createPulse{
    CAShapeLayer *pulse = [CAShapeLayer new];
    pulse.backgroundColor = _pulseColor.CGColor;
    pulse.contentsScale = [UIScreen mainScreen].scale;
    pulse.bounds = self.bounds;
    pulse.cornerRadius = _cornerRadius;
    pulse.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    pulse.zPosition = -2;
    pulse.opacity = 0;
    return pulse;
}

-(void)createAnimationGroup{
    _animationGroup = [CAAnimationGroup new];
    _animationGroup.animations = @[[self createScaleAnimation], [self createOpacityAnimation]];
    _animationGroup.duration = (CFTimeInterval)_pulseDuration;
}

-(CABasicAnimation *)createScaleAnimation{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = [NSNumber numberWithInteger:1];
    scaleAnimation.toValue = [NSNumber numberWithDouble:(((double)_pulseRadius)/10) + 1.0];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return scaleAnimation;
}

-(CAKeyframeAnimation *)createOpacityAnimation{
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.values = @[@0.8, @0.4, @0];//[[NSNumber numberWithFloat:0.8], [NSNumber numberWithFloat:0.4],[NSNumber numberWithFloat:0]];
    opacityAnimation.keyTimes = @[@0, @0.5, @1];
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return opacityAnimation;
}

#pragma mark - Setters

-(void)setButtonColor:(UIColor *)buttonColor{
    _buttonColor = buttonColor;
    self.layer.backgroundColor = buttonColor.CGColor;
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

@end
