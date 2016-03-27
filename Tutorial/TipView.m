//
//  TipView.m
//  KZTipFlow
//
//  Created by Kevin Zhou on 3/22/16.
//

#import "TipView.h"

@implementation TipView

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_delegate tipViewTapped:self];
}


- (TipView*)initWithTip:(NSString *)tip currentView:(UIView*)currentView tippedView:(UIView*)tippedView{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

-(CGRect)calculateTipRect:(CGSize)labelSize viewFrame:(CGRect)viewFrame superview:(UIView*)superView{
    
    CGFloat viewX = viewFrame.origin.x;
    CGFloat viewY = viewFrame.origin.y;
    CGFloat viewWidth = viewFrame.size.width;
    CGFloat viewHeight = viewFrame.size.height;
    
    CGFloat labelWidth = labelSize.width;
    CGFloat labelHeight = labelSize.height;
    
    //tipRect align with the view on the center vertically
    CGRect tipRect;
    tipRect.size.width = labelWidth+50;
    tipRect.size.height = labelHeight+50;
    tipRect.origin.x = (viewX+(viewWidth/2))-(tipRect.size.width/2);
    
    
    //determine if the tip should be located on the top or the bottom of the view
    if (viewY-tipRect.size.height-TIP_VIEW_MARGIN_TO_VIEW > TIP_VIEW_MARGIN_TO_SIDES && viewY+viewHeight+tipRect.size.height+TIP_VIEW_MARGIN_TO_VIEW < superView.frame.size.height-TIP_VIEW_MARGIN_TO_SIDES){
        if (viewY-tipRect.size.height-TIP_VIEW_MARGIN_TO_VIEW > superView.frame.size.height-viewY+viewHeight+tipRect.size.height+TIP_VIEW_MARGIN_TO_VIEW) {
            tipRect.origin.y = viewY-tipRect.size.height-TIP_VIEW_MARGIN_TO_VIEW;
            _top = YES;
        }
        
        else if (viewY-tipRect.size.height-TIP_VIEW_MARGIN_TO_VIEW < superView.frame.size.height-viewY+viewHeight+tipRect.size.height+TIP_VIEW_MARGIN_TO_VIEW){
            tipRect.origin.y = viewY+viewHeight+TIP_VIEW_MARGIN_TO_VIEW;
            _top = NO;
        }
    }
    
    else if (viewY-tipRect.size.height-TIP_VIEW_MARGIN_TO_VIEW > TIP_VIEW_MARGIN_TO_SIDES){
        tipRect.origin.y = viewY-tipRect.size.height-TIP_VIEW_MARGIN_TO_VIEW;
        _top = YES;
    }
    
    else if (viewY+viewHeight+tipRect.size.height+TIP_VIEW_MARGIN_TO_VIEW < superView.frame.size.height-TIP_VIEW_MARGIN_TO_SIDES){
        tipRect.origin.y = viewY+viewHeight+TIP_VIEW_MARGIN_TO_VIEW;
        _top = NO;
    }
    
    //adjust the tipRect so that it is inside of the view
    if (tipRect.origin.x < TIP_VIEW_MARGIN_TO_SIDES) {
        tipRect.origin.x = TIP_VIEW_MARGIN_TO_SIDES;
    }else if (tipRect.origin.x+tipRect.size.width > superView.frame.size.width-TIP_VIEW_MARGIN_TO_SIDES){
        tipRect.origin.x = superView.frame.size.width-TIP_VIEW_MARGIN_TO_SIDES-tipRect.size.width;
    }
    
    return tipRect;
}




@end
