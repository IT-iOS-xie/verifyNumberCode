//
//  verifyCodeView.m
//  VerifyNumberCode
//
//  Created by xie on 2017/8/14.
//  Copyright © 2017年 xie. All rights reserved.
//


#import "verifyCodeView.h"


@interface verifyCodeView()<UITextFieldDelegate>

/// 存放 label 的数组
@property (nonatomic, strong) NSMutableArray *labelArr;
/// label 的数量
@property (nonatomic, assign) NSInteger labelCount;
/// label 之间的距离
@property (nonatomic, assign) CGFloat labelDistance;
/// 输入文本框
@property (nonatomic, strong) UITextField *codeTextField;

@property (nonatomic,assign)BOOL isCircle;

@end

@implementation verifyCodeView

- (instancetype)initWithFrame:(CGRect)frame andLabelCount:(NSInteger)labelCount andLabelDistance:(CGFloat)labelDistance  isCircle:(BOOL)isCirce{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.labelCount = labelCount;
        self.labelDistance = labelDistance;
        self.changedColor = [UIColor redColor];
        self.defaultColor = [UIColor blackColor];
        if (isCirce) {
            self.isCircle = YES;
        }
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    CGFloat labelX;
    CGFloat labelY = 0;
    CGFloat labelWidth = self.codeTextField.frame.size.width / self.labelCount;
    CGFloat sideLength = labelWidth < self.frame.size.height ? labelWidth : self.frame.size.height;
    for (int i = 0; i < self.labelCount; i++) {
        if (i == 0) {
            labelX = 0;
        } else {
            labelX = i * (sideLength + self.labelDistance);
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, sideLength, sideLength)];
        [self addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.borderColor = [UIColor blackColor].CGColor;
        label.layer.borderWidth = 1;
        if (self.isCircle) {
            label.layer.cornerRadius = sideLength / 2;
        }
        
        [self.labelArr addObject:label];
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    NSInteger i = textField.text.length;
    if (i == 0) {
        ((UILabel *)[self.labelArr objectAtIndex:0]).text = @"";
        ((UILabel *)[self.labelArr objectAtIndex:0]).layer.borderColor = _defaultColor.CGColor;
    } else {
        ((UILabel *)[self.labelArr objectAtIndex:i - 1]).text = [NSString stringWithFormat:@"%C", [textField.text characterAtIndex:i - 1]];
        ((UILabel *)[self.labelArr objectAtIndex:i - 1]).layer.borderColor = _changedColor.CGColor;
        ((UILabel *)[self.labelArr objectAtIndex:i - 1]).textColor = _changedColor;
        if (self.labelCount > i) {
            ((UILabel *)[self.labelArr objectAtIndex:i]).text = @"";
            ((UILabel *)[self.labelArr objectAtIndex:i]).layer.borderColor = _defaultColor.CGColor;
        }
    }
    if (self.codeBlock) {
        self.codeBlock(textField.text);
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    } else if (string.length == 0) {
        return YES;
    } else if (textField.text.length >= self.labelCount) {
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - 懒加载
- (UITextField *)codeTextField {
    if (!_codeTextField) {
        _codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _codeTextField.backgroundColor = [UIColor clearColor];
        _codeTextField.textColor = [UIColor clearColor];
        _codeTextField.tintColor = [UIColor clearColor];
        _codeTextField.delegate = self;
        _codeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextField.layer.borderColor = [[UIColor grayColor] CGColor];
        [_codeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_codeTextField];
    }
    return _codeTextField;
}

#pragma mark - 懒加载
- (NSMutableArray *)labelArr {
    if (!_labelArr) {
        _labelArr = [NSMutableArray array];
    }
    return _labelArr;
}

@end
