//
//  TipFlowController.m
//  KZTipFlow
//
//  Created by Kevin Zhou on 2/18/16.
//

#import "TipFlowController.h"
#import "CalloutView.h"
#import "FlowTip.h"
#import "TipFlow.h"
#import "SpotlightView.h"

@interface TipFlowController (){
    BOOL _top;
    int _index;
    UIView *_view;
    NSArray *_tips;
}

@end

@implementation TipFlowController


-(void)startTutorialForView:(UIView*)view viewName:(NSString*)viewName{
    
    _index = 0;
    _view = view;
    
    //get tips from json
    _tips = [[TipFlow sharedInstance]flowForView:viewName];
    
    [self addTipView];

}

-(void)addTipView{
    FlowTip *flowTip = [_tips objectAtIndex:_index];
    TipView *tipView = [self createTipViewForTip:flowTip];
    
    tipView.delegate = self;
    [_view addSubview:tipView];
}


-(TipView*)createTipViewForTip:(FlowTip*)tip{
    
    int tag = [tip.viewTag intValue];
    UIView *view = [_view viewWithTag:tag];

    CGRect tippedViewFrame = [view.superview convertRect:view.frame toView:_view];
    UIView *tippedView = [[UIView alloc]initWithFrame:tippedViewFrame];
    
    TipView *tipView = nil;
    NSString *typeString = tip.type;
    
    if ([typeString isEqualToString:@"callout"]) {
        
        tipView = [[CalloutView alloc]initWithTip:tip.tip currentView:_view tippedView:tippedView];

    }else if([typeString isEqualToString:@"spotlight"]){
        tipView = [[SpotlightView alloc]initWithTip:tip.tip currentView:_view tippedView:tippedView];
    }
    
    return tipView;
    
}


-(void)tipViewTapped:(UIView *)view{
    _index++;
    [view removeFromSuperview];
    if (_index < [_tips count]) {
        [self addTipView];
    }

    
}

@end
