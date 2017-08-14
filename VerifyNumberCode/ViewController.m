//
//  ViewController.m
//  VerifyNumberCode
//
//  Created by xie on 2017/8/14.
//  Copyright © 2017年 xie. All rights reserved.
//

#import "ViewController.h"
#import "GetVeifyCodeViewController.h"
@interface ViewController ()
{

    BOOL isCircle;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"获取验证码";
    
    UIButton * btn = [[UIButton alloc]init];
    
    [self.view addSubview:btn];
    
    btn.frame = CGRectMake(50,150 , self.view.frame.size.width-100, 100);
    
    
//    btn.center = self.view.center;

    
    [btn setTitle:@"获取验证码（正方形）" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
     
    [btn addTarget:self action:@selector(getVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * btn2 = [[UIButton alloc]init];
    
  
    
    btn2.frame = CGRectMake(50,300 , self.view.frame.size.width-100, 100);
    
      [self.view addSubview:btn2];
    
//    btn2.center = self.view.center;
    
    
    [btn2 setTitle:@"获取验证码（圆形）" forState:UIControlStateNormal];
    
    [btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    
    [btn2 addTarget:self action:@selector(getVerifyCode2) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)getVerifyCode{


    GetVeifyCodeViewController * verifyCodeViewController  = [[GetVeifyCodeViewController alloc]init];
    
    verifyCodeViewController.isCircle = NO;
    
    [self.navigationController pushViewController:verifyCodeViewController animated:YES];

}

-(void)getVerifyCode2{
    
    
    GetVeifyCodeViewController * verifyCodeViewController  = [[GetVeifyCodeViewController alloc]init];
    
        verifyCodeViewController.isCircle = YES;
    
    [self.navigationController pushViewController:verifyCodeViewController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
