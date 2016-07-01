//
//  SZRHUD.h
//  SZRHUD
//
//  Created by XiaDian on 16/6/21.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import <UIKit/UIKit.h>
//屏幕大小
#define SZRScreenBounds [UIScreen mainScreen].bounds
//屏幕宽度
#define SZRScreenWidth [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define SZRScreenHeight [UIScreen mainScreen].bounds.size.height

#define SZRHUDCOLOR [UIColor greenColor]
//小球的大小
#define SZRBALLSIZE 30
//进度条的宽度
#define SZRLINEWIDTH 10
//动画时间
#define SZRANIMATIONTIME 2

@interface SZRHUD : UIView
@property(nonatomic,assign)CGFloat endProgress;

@end
