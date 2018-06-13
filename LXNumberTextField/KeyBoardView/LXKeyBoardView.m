//
//  LXKeyBoardView.m
//  yintu
//
//  Created by lx on 2018/6/7.
//  Copyright © 2018年 yintu. All rights reserved.
//

#import "LXKeyBoardView.h"



@interface LXKeyBoardView()
@property (nonatomic,strong) UIButton   *delectBtn;
@property (nonatomic,strong) UIButton   *pointBtn;
@property (nonatomic,strong) UIButton   *zeroBtn;
@property (nonatomic,strong) UIButton   *cancelBtn;
@end
@implementation LXKeyBoardView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"keyboard_background"]];
        [self initWithView:frame];
    }
    return self;
}
- (void)initWithView:(CGRect)frame
{
    NSInteger count = 4;
    CGFloat margin = 1.f;
    CGFloat delBtnW = 189/2;
    CGFloat height = 216.f;
    CGFloat btnW = (frame.size.width - (count -1) * margin - delBtnW) / (count - 1);
    CGFloat btnH = (height - (count - 1) * margin) / count;
    for (int i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setBackgroundImage:[UIImage imageNamed:@"keyboard_background"] forState:UIControlStateHighlighted];
        [btn setFrame:CGRectMake(i % (count -1) * (btnW + margin) ,margin + i / (count -1) * (btnH + margin), btnW, btnH)];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:24.f]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%d",(i+1)] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(keyboardNumberAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    [self.delectBtn setFrame:CGRectMake((btnW + margin) * 3 ,margin , delBtnW, btnH * 2+ margin)];
    [self.confirmBtn setFrame:CGRectMake((btnW + margin) * 3,btnH * 2+ margin * 2, delBtnW, btnH * 2+ margin)];
    [self.pointBtn setFrame:CGRectMake(0,margin + 3 * (btnH + margin), btnW, btnH)];
    [self.zeroBtn setFrame:CGRectMake(btnW + margin,margin + 3 * (btnH + margin), btnW, btnH)];
    [self.cancelBtn setFrame:CGRectMake((btnW + margin) * 2,margin + 3 * (btnH + margin), btnW, btnH)];
}
- (UIButton *)delectBtn
{
    if (_delectBtn == nil) {
       _delectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_delectBtn setImage:[UIImage imageNamed:@"keyboard_delect"] forState:UIControlStateNormal];
        [_delectBtn setImage:[UIImage imageNamed:@"keyboard_delect_selected"] forState:UIControlStateHighlighted];
        [_delectBtn addTarget:self action:@selector(delectkeyboardAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_delectBtn];
    }
    return _delectBtn;
}
- (UIButton *)confirmBtn
{
    if (_confirmBtn == nil) {
       _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn.titleLabel setAlpha:0.54];
        [_confirmBtn setEnabled:NO];
        [_confirmBtn setBackgroundColor:[UIColor redColor]];
        [_confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:18.f]];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn setTitle:@"确定" forState: UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmkeyboardAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_confirmBtn];
    }
    return _confirmBtn;
}
- (UIButton *)pointBtn
{
    if (_pointBtn == nil) {
        _pointBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pointBtn setBackgroundColor:[UIColor whiteColor]];
        [_pointBtn setBackgroundImage:[UIImage imageNamed:@"keyboard_background"] forState:UIControlStateHighlighted];
        [_pointBtn.titleLabel setFont:[UIFont systemFontOfSize:24.f]];
        [_pointBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_pointBtn setTitle:@"." forState: UIControlStateNormal];
        [_pointBtn addTarget:self action:@selector(pointkeyboardAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_pointBtn];
    }
    return _pointBtn;
}
- (UIButton *)zeroBtn
{
    if (_zeroBtn == nil) {
        _zeroBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_zeroBtn setBackgroundColor:[UIColor whiteColor]];
        [_zeroBtn setBackgroundImage:[UIImage imageNamed:@"keyboard_background"] forState:UIControlStateHighlighted];
        [_zeroBtn.titleLabel setFont:[UIFont systemFontOfSize:24.f]];
        [_zeroBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_zeroBtn setTitle:@"0" forState: UIControlStateNormal];
        [_zeroBtn addTarget:self action:@selector(zerokeyboardAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_zeroBtn];
    }
    return _zeroBtn;
}
- (UIButton *)cancelBtn
{
    if (_cancelBtn == nil) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setBackgroundColor:[UIColor whiteColor]];
        [_cancelBtn setImage:[UIImage imageNamed:@"keyboard_cancel"] forState:UIControlStateNormal];
         [_cancelBtn setImage:[UIImage imageNamed:@"keyboard_cancel_selected"] forState:UIControlStateHighlighted];
        [_cancelBtn addTarget:self action:@selector(cancelkeyboardAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelBtn];
    }
    return _cancelBtn;
}
#pragma mark - <Action>
- (void)keyboardNumberAction:(UIButton *)btn
{
    NSString *btnText = btn.titleLabel.text;
    if (nil == self.delegate) {
        NSLog(@"button text : %@",btnText);
        return;
    } else {
        [self.delegate numberKeyBoard:btnText];
    }
}
- (void)confirmkeyboardAction:(UIButton *)btn
{
      NSString *btnText = btn.titleLabel.text;
    if (nil == self.delegate) {
        NSLog(@"button text : %@",btnText);
        return;
    } else {
        [self.delegate confirmKeyBoard:self];
    }
}
- (void)delectkeyboardAction:(UIButton *)btn
{
    NSString *btnText = btn.titleLabel.text;
    if (nil == self.delegate) {
        NSLog(@"button text : %@",btnText);
        return;
    } else {
        [self.delegate delectKeyBoard];
    }
}
- (void)pointkeyboardAction:(UIButton *)btn
{
    NSString *btnText = btn.titleLabel.text;
    if (nil == self.delegate) {
        NSLog(@"button text : %@",btnText);
        return;
    } else {
        [self.delegate numberKeyBoard:btnText];
    }
}
- (void)zerokeyboardAction:(UIButton *)btn
{
    NSString *btnText = btn.titleLabel.text;
    if (nil == self.delegate) {
        NSLog(@"button text : %@",btnText);
        return;
    } else {
        [self.delegate numberKeyBoard:btnText];
    }
}
- (void)cancelkeyboardAction:(UIButton *)btn
{
    NSString *btnText = btn.titleLabel.text;
    if (nil == self.delegate) {
        NSLog(@"button text : %@",btnText);
        return;
    } else {
        [self.delegate cancelKeyBoard];
    }
}
@end
