//
//  TipFlow.h
//  KZTipFlow
//
//  Created by Kevin Zhou on 2/8/16.
//

#import <Foundation/Foundation.h>

@interface TipFlow : NSObject

+ (instancetype)sharedInstance;
-(NSArray*)flowForView:(NSString*)viewName;
@end

