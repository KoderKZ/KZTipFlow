//
//  TipFlow.m
//  KZTipFlow
//
//  Created by Kevin Zhou on 2/8/16.
//

#import "TipFlow.h"
#import "FlowTip.h"

@implementation TipFlow

+ (instancetype)sharedInstance
{
    static TipFlow *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TipFlow alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

-(NSArray*)flowForView:(NSString*)viewName{
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@Tips", viewName] ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *flow = (NSArray *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSMutableArray *flowTipArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<[flow count]; i++) {
        NSDictionary *viewAndTip = (NSDictionary*)[flow objectAtIndex:i];
        FlowTip *flowTip = [[FlowTip alloc]init];
        flowTip.tip = [viewAndTip objectForKey:@"tip"];
        flowTip.viewName = [viewAndTip objectForKey:@"viewName"];
        flowTip.viewTag = [viewAndTip objectForKey:@"tag"];
        flowTip.type = [viewAndTip objectForKey:@"type"];
        [flowTipArray addObject:flowTip];
    }
    
    
    return flowTipArray;
}

@end
