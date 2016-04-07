//
//  ViewController.m
//  PopMenuDemo
//
//  Created by langyue on 16/4/7.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "ViewController.h"
#import "PopMenu.h"
#import "MenuItem.h"
#import "XHRealTimeBlur.h"
#import "FRDLivelyButton.h"


#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define kKeyWindow [UIApplication sharedApplication].keyWindow



#define weakify(...) \
rac_keywordify \
metamacro_foreach_cxt(rac_weakify_,, __weak, __VA_ARGS__)



#define strongify(...) \
rac_keywordify \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
metamacro_foreach(rac_strongify_,, __VA_ARGS__) \
_Pragma("clang diagnostic pop")





@interface ViewController ()
{
    PopMenu * _myPopMenu;
    
    
}

@property(nonatomic,strong)FRDLivelyButton * rightBtn;
@property(nonatomic,strong)PopMenu * myPopMenu;


@end

@implementation ViewController


-(void)setupNavBtn{
    
    _rightBtn = [[FRDLivelyButton alloc] initWithFrame:CGRectMake(0, 0, 18.5, 18.5)];
    [_rightBtn setOptions:@{kFRDLivelyButtonLineWidth: @(1.0f),kFRDLivelyButtonColor: [UIColor whiteColor]}];
    [_rightBtn setStyle:kFRDLivelyButtonStylePlus animated:NO];
    [_rightBtn addTarget:self action:@selector(addItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * btnItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    self.navigationItem.rightBarButtonItem = btnItem;
    
}

-(void)addItemClicked:(id)sender{
    
    if (_rightBtn.buttonStyle == kFRDLivelyButtonStylePlus) {
        [_rightBtn setStyle:kFRDLivelyButtonStyleClose animated:YES];
        [_myPopMenu showMenuAtView:kKeyWindow startPoint:CGPointMake(0, -100) endPoint:CGPointMake(0, -100)];
    }else{
        
        [_myPopMenu dismissMenu];
        
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    
    [self setupNavBtn];
    
    NSArray * menuItems = @[[MenuItem itemWithTitle:@"项目" iconName:@"pop_Project" index:0],
        [MenuItem itemWithTitle:@"任务" iconName:@"pop_Task" index:1],
        [MenuItem itemWithTitle:@"冒泡" iconName:@"pop_Tweet" index:2],
        [MenuItem itemWithTitle:@"添加好友" iconName:@"pop_User" index:3],
        [MenuItem itemWithTitle:@"私信" iconName:@"pop_Message" index:4],
        [MenuItem itemWithTitle:@"两步验证" iconName:@"pop_2FA" index:5]];
    
    
    
    
    _myPopMenu = [[PopMenu alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)   items:menuItems];
    _myPopMenu.perRowItemCount = 3;
    _myPopMenu.menuAnimationType = kPopMenuAnimationTypeSina;
    
    __weak typeof (self) weakSelf = self;
    
    //@weakify(self);
    _myPopMenu.didSelectedItemCompletion = ^(MenuItem* selectedItem){
        
        //weakSelf.myPopMenu.realTimeBlurFooter.disMissDuration = 2;
        [weakSelf.myPopMenu.realTimeBlurFooter disMiss];
        
        //@strongify(self);
        [weakSelf.rightBtn setStyle:kFRDLivelyButtonStylePlus animated:YES];
        if (!selectedItem) {
            return;
        }
        
        
        switch (selectedItem.index) {
                
                
                
            case 0:
                [self goToNewProjectVC];
                break;
            case 1:
                [self goToNewTaskVC];
                break;
            case 2:
                [self goToNewTweetVC];
                break;
            case 3:
                [self goToAddUserVC];
                break;
            case 4:
                [self goToMessageVC];
                break;
            case 5:
                [self goTo2FA];
                break;
            default:
                NSLog(@"%@",selectedItem.title);
                break;
        }
        
        [weakSelf.rightBtn setStyle:kFRDLivelyButtonStylePlus animated:YES];
        
    };
    
    
    
    
    
}

-(void)goToNewProjectVC{
    
    NSLog(@"goToNewProjectVC");

}

-(void)goToNewTaskVC{
    NSLog(@"goToNewTaskVC");
    
}
-(void)goToNewTweetVC{
    NSLog(@"goToNewTweetVC");
    
}
-(void)goToAddUserVC{
    NSLog(@"goToAddUserVC");
    
}

-(void)goToMessageVC{
    NSLog(@"goToMessageVC");
}
-(void)goTo2FA{
    NSLog(@"goTo2FA");
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
