//
//  LXKeyBoardView.h
//  yintu
//
//  Created by lx on 2018/6/7.
//  Copyright © 2018年 yintu. All rights reserved.
//

#import <UIKit/UIKit.h>



@class LXKeyBoardView;
@protocol LXKeyBoardViewDelegate
- (void)numberKeyBoard:(NSString *)number;
- (void)cancelKeyBoard;
- (void)confirmKeyBoard:(LXKeyBoardView *)keyboardView;
- (void)delectKeyBoard;
@end
@interface LXKeyBoardView : UIView
@property (nonatomic,assign) id<LXKeyBoardViewDelegate>   delegate;
@property (nonatomic,strong) UIButton *confirmBtn;
@end
