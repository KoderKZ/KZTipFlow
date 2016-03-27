### KZTipFlow

Created by Kevin Zhou





### Overview



KZTipFlow is a group of classes that helps you create a tutorial for your app. There are currently two types of tutorial included: 

- a spotlight view to highlight a certain view in your app

- a callout view, with an arrow to point to a certain view in your app

- both have a tip you can adjust in the view's json to go along with the callout/spotlight



### License



MIT License, with the full license in License.txt



### Technical requirements



- iOS 9.0 SDK to build



### Using this module



To add this module to your project:

- Add the Tutorial Flow Group, and import the TipFlowController into the class you want to make a tutorial on. 



- Create a json file formatted as the sample does.



- Tag all of your views in the superview you want to start the tutorial in   



- Then, create a TipFlowController, and call:

> ```[tVC startTutorialForView:self.view viewName:@"ViewController"];```



- After that, the module will start the tutorial for you



- To move onto the next tip, tap the screen



- Once the tutorial is over, everything will disappear and the user will be able use the app



### Sample Code



```

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

```



