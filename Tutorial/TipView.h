//
//  TipView.h
//  KZTipFlow
//
//  Created by Kevin Zhou on 3/22/16.
//

#import <UIKit/UIKit.h>
#define TIP_VIEW_MARGIN_TO_SIDES 25
#define TIP_VIEW_MARGIN_TO_VIEW 10


@protocol TipViewDelegate <NSObject>

-(void)tipViewTapped:(UIView*)view;

@end

@interface TipView : UIView

@property (nonatomic, strong) NSString *tip;
@property (nonatomic, strong) id<TipViewDelegate> delegate;
@property (nonatomic) CGRect tipRect;
@property (nonatomic) BOOL top;


// currentView: the view the tip is on
// tippedView: a subview on tippedView that will be taught by a tipView
- (TipView*)initWithTip:(NSString *)tip currentView:(UIView*)currentView tippedView:(UIView*)tippedView;
-(CGRect)calculateTipRect:(CGSize)labelSize viewFrame:(CGRect)viewFrame superview:(UIView*)superView;

@end