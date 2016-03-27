//
//  ViewController.m
//  KZTipFlow
//
//  Created by Kevin Zhou on 3/25/16.
//

#import "ViewController.h"
#import "TipFlowController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *settingButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [self startTutorial];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)startTutorial{
    _settingButton.tag = TIP_VIEW_CONTROLLER_TAG_OFFSET+1;
    _playButton.tag = TIP_VIEW_CONTROLLER_TAG_OFFSET+2;
    _moreButton.tag = TIP_VIEW_CONTROLLER_TAG_OFFSET+3;
    TipFlowController * tVC = [[TipFlowController alloc] init];
    [tVC startTutorialForView:self.view viewName:@"ViewController"];
}

@end
