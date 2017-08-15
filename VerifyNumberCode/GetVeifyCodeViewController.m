//
//  GetVeifyCodeViewController.m
//  VerifyNumberCode
//
//  Created by xie on 2017/8/14.
//  Copyright © 2017年 xie. All rights reserved.
//

#import "GetVeifyCodeViewController.h"
#import "verifyCodeView.h"
#define VerifyCodeHeight   50
#define VerifyCodeSpacing  20
@interface GetVeifyCodeViewController()
///   返回按钮
@property(nonatomic,strong)UIButton * backBtn;

/// 验证码view
@property(nonatomic,strong)verifyCodeView * verifyView;


/// 重新获取
@property(nonatomic,strong)UIButton * reacquireBtn;

@property(nonatomic,strong)UIButton * ensureBtn;



@end

@implementation GetVeifyCodeViewController

/// override  viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}
/// override  viewWillDisappear
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}
/// override  viewDidLoad
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 80, 40)];
    
    self.backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    
    [self.view addSubview:self.backBtn];
    
    [self.backBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [self.backBtn addTarget: self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * label = [[UILabel alloc]init];
    
    [self.view addSubview:label];
    
    label.frame = CGRectMake(20, 100, self.view.frame.size.width-40, 40);
    
    label.text = @"输入验证码";
    
    label.font = [UIFont boldSystemFontOfSize:16];
    
    label.font = [UIFont fontWithName:@ "Arial Rounded MT Bold"  size:(20.0)];
    
    self.verifyView = [[verifyCodeView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-4*VerifyCodeHeight-VerifyCodeSpacing * 3)/2,150,  4*VerifyCodeHeight+VerifyCodeSpacing * 3, VerifyCodeHeight) andLabelCount:4 andLabelDistance:VerifyCodeSpacing isCircle:_isCircle];
    
    
    [self.view addSubview:self.verifyView];
    
    
    self.reacquireBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, 200, self.view.frame.size.width-80, 60)];
    
    [self.reacquireBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [self.view addSubview:self.reacquireBtn];
    
    
    [self.reacquireBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [self.reacquireBtn addTarget:self action:@selector(reacquireClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self getNumBtnAction];
    
    
    self.ensureBtn  = [[UIButton alloc]initWithFrame:CGRectMake(20, 300, self.view.frame.size.width-40, 50)];
    
    
    [self.view addSubview:self.ensureBtn];
    
    
    [self.ensureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    [self.ensureBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    self.reacquireBtn.userInteractionEnabled = NO;
}



/// 倒计时操作
- (void)getNumBtnAction{
    
    [self.reacquireBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    __block NSInteger second = 60;
    //全局队列    默认优先级
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //定时器模式  事件源
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    //NSEC_PER_SEC是秒，＊1是每秒
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), NSEC_PER_SEC * 1, 0);
    //设置响应dispatch源事件的block，在dispatch源指定的队列上运行
    dispatch_source_set_event_handler(timer, ^{
        //回调主线程，在主线程中操作UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second >= 0) {
                [_reacquireBtn setTitle:[NSString stringWithFormat:@"%ld秒后重新获取",second] forState:UIControlStateNormal];
                second--;
                
                
            }
            else
            {
                //这句话必须写否则会出问题
                dispatch_source_cancel(timer);
                [_reacquireBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
                [_reacquireBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                
                _reacquireBtn.userInteractionEnabled = YES;
            }
        });
    });
    //启动源
    dispatch_resume(timer);
    
    
}
/// 点击按钮
-(void)reacquireClick{
   
    _reacquireBtn.userInteractionEnabled = NO;
    [self getNumBtnAction];
    
    NSLog(@"重新获取验证码");

}

///pop back
-(void)goBack{
  
    [self.navigationController popViewControllerAnimated:YES];
 

}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
