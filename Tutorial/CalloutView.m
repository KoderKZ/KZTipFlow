//
//  CalloutView.m
//  KZTipFlow
//
//  Created by Kevin Zhou on 2/18/16.
//

#import "CalloutView.h"
#import "TipView.h"

@implementation CalloutView{
    NSMutableArray *_typeArray;
    NSMutableArray *_pointArray;
    CGPoint _point1;
    CGPoint _base1;
    CGPoint _base2;
    int _startingIndex;
    CAShapeLayer *_layer;
    UILabel *_tipLabel;
    CGPoint _arrowPoint;
    CGRect _rect;
    int _baseWidth;
    int _radius;
}


- (TipView*)initWithTip:(NSString *)tip currentView:(UIView*)currentView tippedView:(UIView*)tippedView;{
    self = [super initWithFrame:currentView.frame];
    CGSize maximumLabelSize = CGSizeMake(currentView.frame.size.width-2*TIP_VIEW_MARGIN_TO_SIDES, currentView.frame.size.height-2*TIP_VIEW_MARGIN_TO_SIDES);
    CGRect labelRect = [tip boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}
                                         context:nil];
    CGRect tipRect = [self calculateTipRect:labelRect.size viewFrame:tippedView.frame superview:currentView];
    [self drawCallout:tip arrowBaseWidth:CALLOUT_VIEW_ARROW_BASE_WIDTH calloutFrame:tipRect rectRadius:25 view:tippedView top:self.top];
    return self;
}

-(void)drawCallout:(NSString *)calloutText arrowBaseWidth:(int)arrowBaseWidth calloutFrame:(CGRect)calloutFrame rectRadius:(int)rectRadius view:(UIView*)view top:(BOOL)top{
    _baseWidth = arrowBaseWidth;
    _rect = calloutFrame;
    _radius = rectRadius;
    
    _arrowPoint = [self getArrowPoint:calloutFrame arrowHeight:TIP_VIEW_MARGIN_TO_VIEW view:view top:top];
    [self setUpRoundedRectPoints];
    [self setUpArrow];
    [self insertArrowPoints];
    [self drawCallout];
    [self addLabel:calloutText];
}


-(CGPoint)getArrowPoint:(CGRect)calloutRect arrowHeight:(int)arrowHeight view:(UIView*)view top:(BOOL)top{
    CGPoint arrowPoint;
    arrowPoint.x = view.frame.origin.x+view.frame.size.width/2;
    if (top) {
        arrowPoint.y = calloutRect.origin.y+calloutRect.size.height+arrowHeight;
        
    }else{
        arrowPoint.y = view.frame.origin.y+view.frame.size.height+TIP_VIEW_MARGIN_TO_VIEW;
        
    }
    return arrowPoint;
}

-(void)setUpRoundedRectPoints{
    
    CGFloat originX = _rect.origin.x;
    CGFloat originY = _rect.origin.y;
    CGFloat width = _rect.size.width;
    CGFloat height = _rect.size.height;
    
    _pointArray = [[NSMutableArray alloc]init];
    
    _point1 = CGPointMake(originX, originY+_radius);
    
    CGPoint point2 = CGPointMake(originX, originY+height-_radius);
    [_pointArray addObject:[NSValue valueWithCGPoint:point2]];
    
    CGPoint point3 = CGPointMake(originX + _radius, originY+height-_radius);
    [_pointArray addObject:[NSValue valueWithCGPoint:point3]];
    
    CGPoint point4 = CGPointMake(originX + width - _radius, originY+height);
    [_pointArray addObject:[NSValue valueWithCGPoint:point4]];
    
    CGPoint point5 = CGPointMake(originX + width-_radius, originY+height-_radius);
    [_pointArray addObject:[NSValue valueWithCGPoint:point5]];
    
    CGPoint point6 = CGPointMake(originX+ width, originY + _radius);
    [_pointArray addObject:[NSValue valueWithCGPoint:point6]];
    
    CGPoint point7 = CGPointMake(originX+width-_radius, originY+_radius);
    [_pointArray addObject:[NSValue valueWithCGPoint:point7]];
    
    CGPoint point8 = CGPointMake(originX+_radius, originY);
    [_pointArray addObject:[NSValue valueWithCGPoint:point8]];
    
    CGPoint point9 = CGPointMake(originX+_radius, originY+_radius);
    [_pointArray addObject:[NSValue valueWithCGPoint:point9]];
    
    _typeArray = [[NSMutableArray alloc] initWithArray:@[@"line",@"arc",@"line",@"arc",@"line",@"arc",@"line",@"arc"]];
}


-(void)setUpArrow{
    BOOL checkBaseX;
    BOOL checkBaseY;
    
    if (_arrowPoint.y < _rect.origin.y) {//check if above
        _base2.y = _rect.origin.y;
        _base1.y = _base2.y;
        _base2.x = _arrowPoint.x - _baseWidth/2;
        _base1.x = _arrowPoint.x + _baseWidth/2;
        checkBaseX = YES;
        checkBaseY = NO;
        
        _startingIndex = 6;
    }else if(_arrowPoint.y > _rect.origin.y + _rect.size.height){// check if below
        _base1.y = _rect.origin.y + _rect.size.height;
        _base2.y = _base1.y;
        _base1.x = _arrowPoint.x - _baseWidth/2;
        _base2.x = _arrowPoint.x + _baseWidth/2;
        checkBaseX = YES;
        checkBaseY = NO;
        
        _startingIndex = 2;
    }else if (_arrowPoint.y > _rect.origin.y && _arrowPoint.y < _rect.origin.y + _rect.size.height){
        
        if (_arrowPoint.x < _rect.origin.x) {//check if to the left
            _base1.x = _rect.origin.x;
            _base2.x = _base1.x;
            _base2.y = _arrowPoint.y+_baseWidth/2;
            _base1.y = _arrowPoint.y-_baseWidth/2;
            _startingIndex = 0;
        }else if(_arrowPoint.x > _rect.origin.x + _rect.size.width){//check if to the right
            _base1.x = _rect.origin.x + _rect.size.width;
            _base2.x = _base1.x;
            _base1.y = _arrowPoint.y+_baseWidth/2;
            _base2.y = _arrowPoint.y-_baseWidth/2;
            _startingIndex = 4;
        }
        checkBaseX = NO;
        checkBaseY = YES;
    }
    
    if (checkBaseX) {//check if the base goes outside
        if (_base1.x < _rect.origin.x + _radius && _base1.x < _base2.x) {
            _base2.x = _rect.origin.x + _radius + _baseWidth;
            _base1.x = _rect.origin.x + _radius;
        }else if (_base1.x > _rect.origin.x + _rect.size.width - _radius && _base1.x > _base2.x) {
            _base1.x = _rect.origin.x + _rect.size.width - _radius;
            _base2.x = _rect.origin.x + _rect.size.width - _radius - _baseWidth;
        }
        
        if (_base2.x < _rect.origin.x + _radius && _base2.x < _base1.x) {
            _base2.x = _rect.origin.x + _radius;
            _base1.x = _rect.origin.x + _radius + _baseWidth;
        }else if (_base2.x > _rect.origin.x + _rect.size.width - _radius && _base2.x > _base1.x) {
            _base1.x = _rect.origin.x + _rect.size.width - _radius - _baseWidth;
            _base2.x = _rect.origin.x + _rect.size.width - _radius;
        }
    }
    
    if (checkBaseY) {//check if the base goes outside
        if (_base1.y < _rect.origin.y + _radius) {
            _base1.y = _rect.origin.y + _radius;
            _base2.y = _rect.origin.y + _radius + _baseWidth;
        }else if (_base1.y > _rect.origin.y + _rect.size.height - _radius) {
            _base1.y = _rect.origin.y + _rect.size.height - _radius;
            _base2.y = _rect.origin.y + _rect.size.height - _radius - _baseWidth;
        }
    }
    
}

-(void)insertArrowPoints{
    
    NSValue *base1Point = [NSValue valueWithCGPoint:_base1];
    [_pointArray insertObject:base1Point atIndex:_startingIndex];
    [_typeArray insertObject:@"line" atIndex:_startingIndex];
    
    NSValue *arrowPoint = [NSValue valueWithCGPoint:_arrowPoint];
    [_pointArray insertObject:arrowPoint atIndex:_startingIndex+1];
    [_typeArray insertObject:@"line" atIndex:_startingIndex+1];
    
    NSValue *base2Point = [NSValue valueWithCGPoint:_base2];
    [_pointArray insertObject:base2Point atIndex:_startingIndex+2];
    [_typeArray insertObject:@"line" atIndex:_startingIndex+2];
    
}

-(void)drawCallout{
    UIBezierPath *linePath = [[UIBezierPath alloc]init];
    
    double startAngle = M_PI;
    double endAngle = M_PI_2;
    
    [linePath moveToPoint:_point1];
    for (int i = 0; i < [_pointArray count]; i++) {
        
        NSString *type = [_typeArray objectAtIndex:i];
        
        if ([type isEqualToString:@"line"]) {
            NSValue *value = [_pointArray objectAtIndex:i];
            CGPoint point = value.CGPointValue;
            [linePath addLineToPoint:point];
            
        }else if([type isEqualToString:@"arc"]){
            NSValue *value = [_pointArray objectAtIndex:i];
            CGPoint point = value.CGPointValue;
            [linePath addArcWithCenter:point radius:_radius startAngle:startAngle endAngle:endAngle clockwise:NO];
            startAngle = endAngle;
            endAngle = endAngle - M_PI_2;
        }
    }
    
    _layer = [CAShapeLayer layer];
    _layer.path = linePath.CGPath;
    _layer.fillColor = [UIColor whiteColor].CGColor;
    _layer.strokeColor = [UIColor blackColor].CGColor;
    _layer.lineWidth = 2;
    [self.layer addSublayer:_layer];
}


-(void)addLabel:(NSString *)calloutText{
    _tipLabel = [[UILabel alloc]initWithFrame:_rect];
    _tipLabel.text = calloutText;
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_tipLabel];
}

@end

