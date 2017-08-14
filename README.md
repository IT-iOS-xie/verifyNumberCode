# verifyNumberCode
在调用做了封装，只需要调用如下代码即可实现效果：

self.verifyView = [[verifyCodeView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-4*VerifyCodeHeight-VerifyCodeSpacing * 3)/2,150,  4*VerifyCodeHeight+VerifyCodeSpacing * 3, VerifyCodeHeight) andLabelCount:4 andLabelDistance:VerifyCodeSpacing isCircle:_isCircle];

[self.view addSubview:self.verifyView];
参数说明：verifyCodeView

- (instancetype)initWithFrame:(CGRect)frame andLabelCount:(NSInteger)labelCount andLabelDistance:(CGFloat)labelDistance isCircle:(BOOL)isCirce;
labelCount即验证码/密码个数，labelDistance验证码间距，isCircle 是否为圆显示，如果为false则显示为正方形空格。

这里倒计时使用的GCD，如果需要只需要调用getNumBtnAction.方法即可实现倒计时效果。

方法如下：

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

}else

{

//这句话必须写否则会出问题

dispatch_source_cancel(timer);

[_reacquireBtn setTitle:@"获取验证码" forState:UIControlStateNormal];

[_reacquireBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

}

});

});

//启动源

dispatch_resume(timer);

}

效果是实现思路：在控制器上添加textField，然后监听textField，讲输入内容分别到label上即可。

这样做很大程度上减少了控制器的层级结构，优化app性能，具体代码见demo。
