//
//  SpotlightView.m
//  KZTipFlow
//
//  Created by Kevin Zhou on 12/5/15.
//

#import "SpotlightView.h"

@implementation SpotlightView{
    CGFloat _kRadius;
    UIBezierPath *_path;
    CGRect _circleRect;
    UIView *_currentView;
    UILabel *_tipLabel;
}

-(void)initHelp{
    [self setUpSpotlightSubview];
    _tipLabel = [[UILabel alloc]init];
}

- (TipView*)initWithTip:(NSString *)tip currentView:(UIView*)currentView tippedView:(UIView*)tippedView{
    self = [super initWithFrame:CGRectMake(0, 0, currentView.frame.size.width*3, currentView.frame.size.height*3)];
    [self initHelp];

    CGRect tippedViewRect = tippedView.frame;
    _currentView = currentView;

    //calculate spotlight radius
    if (tippedViewRect.size.width > tippedViewRect.size.height) {
        _kRadius = (tippedViewRect.size.width/2)+SPOTLIGHT_VIEW_EXCESS_RADIUS_SPACE;
    }else if (tippedViewRect.size.width < tippedViewRect.size.height){
        _kRadius = (tippedViewRect.size.height/2)+SPOTLIGHT_VIEW_EXCESS_RADIUS_SPACE;
    }

    self.center = tippedView.center;

    //calculate tip location
    _tipLabel.text = tip;
    CGSize maximumLabelSize = CGSizeMake(currentView.frame.size.width-2*TIP_VIEW_MARGIN_TO_SIDES, currentView.frame.size.height-2*TIP_VIEW_MARGIN_TO_SIDES);
    CGRect labelRect = [tip boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}
                                         context:nil];
    CGRect tipRect = [self calculateTipRect:labelRect.size viewFrame:tippedView.frame superview:currentView];
    self.tipRect = tipRect;
    self.tip = tip;
    [self setUpTipLabel];
    
    return self;
}

- (void)setUpSpotlightSubview {
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    self.autoresizingMask = 0;
}

-(void)setUpTipLabel{
    [self addMaskToSpotlightView];
    CGRect rect = self.tipRect;
    CGRect viewRect = [_tipLabel convertRect:rect toView:self];
    _tipLabel = [[UILabel alloc]initWithFrame:viewRect];
    _tipLabel.text = self.tip;
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.textColor = [UIColor whiteColor];
    _tipLabel.numberOfLines = 0;
    [self addSubview:_tipLabel];
}

- (void)addMaskToSpotlightView {
    CGRect bounds = self.bounds;
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.fillColor = [UIColor blackColor].CGColor;

    _circleRect = CGRectMake(CGRectGetMidX(bounds) - _kRadius,
                                         CGRectGetMidY(bounds) - _kRadius,
                                         2 * _kRadius, 2 * _kRadius);
    _path = [UIBezierPath bezierPathWithOvalInRect:_circleRect];
    [_path appendPath:[UIBezierPath bezierPathWithRect:bounds]];
    maskLayer.path = _path.CGPath;
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    
    self.layer.mask = maskLayer;
}


@end
