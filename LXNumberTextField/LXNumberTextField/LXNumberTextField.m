//
//  LXNumberTextField.m
//  yintu
//
//  Created by lx on 2018/6/11.
//  Copyright © 2018年 yintu. All rights reserved.
//

#import "LXNumberTextField.h"
#import "LXKeyBoardView.h"
/**
 判断机型是否为 iPhoneX
 */
#define kIsiPhoneX              ([UIScreen instanceMethodForSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436),[[UIScreen mainScreen] currentMode].size):NO)

#define kTabBarSpaceBottom     (kIsiPhoneX ? 34 : 0)

@interface LXNumberTextField ()<LXKeyBoardViewDelegate>
@property (nonatomic,strong) LXKeyBoardView   *keyBoardView;
@end
@implementation LXNumberTextField
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.inputView = self.keyBoardView;
    self.keyBoardView.delegate = self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
#pragma mark - Lazy init
- (LXKeyBoardView *)keyBoardView
{
    if (_keyBoardView == nil) {
        _keyBoardView = [[LXKeyBoardView alloc] initWithFrame:CGRectMake(0, kTabBarSpaceBottom, [UIScreen mainScreen].bounds.size.width, 216 + kTabBarSpaceBottom)];
        
    }
    return _keyBoardView;
}
#pragma mark - Helper
- (void)setConfirmBtnEnable:(BOOL)enable
{
    [self.keyBoardView.confirmBtn setEnabled:enable];
    [self.keyBoardView.confirmBtn.titleLabel setAlpha:enable ? 1.0 : 0.54];
}
#pragma mark - LXKeyBoardViewDelegate
- (void)numberKeyBoard:(NSString *)number
{
    BOOL canEditor = YES;
    if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        canEditor = [self.delegate textField:self shouldChangeCharactersInRange:self.selectedRange replacementString:number];
    }
    /**
     * 1.空格
     * 2.输入 "." 时
     *   a.焦点在首位 = 0.
     *   b.self.text 包含 "."
     *      1> self.text - 焦点的位置 > 2 格式化
     *      2> 通过
     * 3.self.text 包含 "."
     *   a. "." 后面有两位 并且 (焦点位置 > self.text.length -3 或者 焦点在末尾) 不通过
     *
     */
    if (canEditor && ![@" " isEqualToString:number]) {
        if ([@"." isEqualToString:number]) {
            if (0 == self.selectedRange.location) {
                self.text = @"0.";
            } else if(![self.text containsString:@"."]){
                if ((self.text.length - self.selectedRange.location) > 2) {
                    [self replaceRange:self.selectedTextRange withText:number];
                    self.text = [NSString stringWithFormat:@"%.2f",self.text.doubleValue];
                } else {
                    [self replaceRange:self.selectedTextRange withText:number];
                }
            }
        } else {
            if ([self.text containsString:@"."]) {
                NSArray *arr = [self.text componentsSeparatedByString:@"."];
                if (1 == arr.count) {
                    if (((NSString *)arr.firstObject).length >= 2 && (self.selectedRange.location > (self.text.length -3) || (self.selectedRange.location == self.text.length))) {
                    } else {
                        [self replaceRange:self.selectedTextRange withText:number];
                    }
                } else if (1 < arr.count) {
                    if (((NSString *)arr.lastObject).length >= 2 &&  (self.selectedRange.location > (self.text.length -3) || (self.selectedRange.location == self.text.length))) {
                        
                    } else {
                        [self replaceRange:self.selectedTextRange withText:number];
                    }
                }
            } else {
                [self replaceRange:self.selectedTextRange withText:number];
            }
        }
        [self setConfirmBtnEnable:YES];
    }
}
- (void)cancelKeyBoard
{
    BOOL canEditor = YES;
    if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        canEditor = [self.delegate textField:self shouldChangeCharactersInRange:self.selectedRange replacementString:@""];
    }
    if (canEditor) {
        [self resignFirstResponder];
    }
}
- (void)confirmKeyBoard:(LXKeyBoardView *)keyboardView
{
    BOOL canEditor = YES;
    if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        canEditor = [self.delegate textField:self shouldChangeCharactersInRange:self.selectedRange replacementString:@""];
    }
    if (canEditor) {
      //  if ([self.numberTextFieldDelegate respondsToSelector:@selector(confirmTextField:)]) {
            [self.numberTextFieldDelegate confirmTextField:self];

     //   }
    }
}
- (void)delectKeyBoard
{
    BOOL canEditor = YES;
    if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        canEditor = [self.delegate textField:self shouldChangeCharactersInRange:self.selectedRange replacementString:@""];
    }
    if (canEditor) {
        [self deleteBackward];
        [self setConfirmBtnEnable:self.text.length > 0];
    }
}

@end

@implementation UITextField (ExtentRange)

- (NSRange) selectedRange
{
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

- (void) setSelectedRange:(NSRange) range  // 备注：UITextField必须为第一响应者才有效
{
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    
    [self setSelectedTextRange:selectionRange];
}

@end  
