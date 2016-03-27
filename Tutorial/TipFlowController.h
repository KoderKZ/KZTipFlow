//
//  TipFlowController.h
//  WordSearch
//
//  Created by Kevin Zhou on 2/18/16.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TipView.h"
@interface TipFlowController : NSObject <TipViewDelegate>

-(void)startTutorialForView:(UIView*)view viewName:(NSString*)viewName;

@end
