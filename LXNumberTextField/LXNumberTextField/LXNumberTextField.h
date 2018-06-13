//
//  LXNumberTextField.h
//  yintu
//
//  Created by lx on 2018/6/11.
//  Copyright © 2018年 yintu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXNumberTextField;
@protocol LXNumberTextFieldDelegate
- (void)confirmTextField:(LXNumberTextField *)textField;
@end
@interface LXNumberTextField : UITextField
@property (nonatomic,weak) id<LXNumberTextFieldDelegate>   numberTextFieldDelegate;
@end
@interface UITextField (ExtentRange)
- (NSRange)selectedRange;
- (void)setSelectedRange:(NSRange)range;
@end
