//
//  SZRHUD.m
//  SZRHUD
//
//  Created by XiaDian on 16/6/21.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "SZRHUD.h"
@interface SZRHUD ()
//进度条Label
@property(nonatomic,strong)UILabel*progressLable;
//进度条顶端小球Lable
@property(nonatomic,strong)UILabel*ballLable;
//进度条定时器
@property(nonatomic,strong)NSTimer*timer;
//进度
@property(nonatomic,assign)CGFloat Progress;
//份数
@property(nonatomic,assign)CGFloat fen;

@end

@implementation SZRHUD

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.endProgress=1.0;
        self.backgroundColor=[UIColor clearColor];
        //创建进度展示label
        self.progressLable=[[UILabel alloc]init];
        self.progressLable.bounds=CGRectMake(0,0,100,40);
        self.progressLable.textAlignment=NSTextAlignmentCenter;
        self.progressLable.textColor=SZRHUDCOLOR;
        [self addSubview:self.progressLable];
        [self bringSubviewToFront:self.progressLable];
        //创建小球lable
        self.ballLable=[[UILabel alloc]init];
        self.ballLable.bounds=CGRectMake(0, 0, SZRBALLSIZE, SZRBALLSIZE);
        self.ballLable.layer.cornerRadius=SZRBALLSIZE/2.0;
        self.ballLable.layer.masksToBounds=YES;
        self.ballLable.textAlignment=NSTextAlignmentCenter;
        self.ballLable.backgroundColor=SZRHUDCOLOR;
        [self addSubview:self.ballLable];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    //进度展示动画
    [self getProgressLableView];
    //顶端小球动画
    [self getBallLabelView];
    //贝塞尔曲线画出进度线
    [self getProgressView];
     double  ss=SZRANIMATIONTIME/(self.endProgress*100/0.5);
     self.timer=[NSTimer scheduledTimerWithTimeInterval:ss target:self selector:@selector(progress) userInfo:nil repeats:YES];
}

/**
 *  获取进度条View
 */
-(void)getProgressView{
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0) radius:self.bounds.size.width/2.0 startAngle:M_PI/2 endAngle:M_PI/2+2*M_PI*self.endProgress clockwise:YES];
    layer.path = path.CGPath;
    layer.lineWidth=SZRLINEWIDTH;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor =SZRHUDCOLOR.CGColor;
    [self.layer addSublayer:layer];
    [self addAnimation:layer duration:SZRANIMATIONTIME];
}
/**
 *  获取进度展示label
 */
-(void)getProgressLableView{
    CAKeyframeAnimation  *keyAnimationOne = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathAddArc(path, NULL,self.bounds.size.width/2.0,self.bounds.size.height/2.0,self.bounds.size.width/2.0+40,M_PI/2,M_PI/2+2*M_PI*self.endProgress,0);
    keyAnimationOne.path =path;
    CGPathRelease(path);
    keyAnimationOne.duration=SZRANIMATIONTIME;
    keyAnimationOne.fillMode = kCAFillModeForwards;
    keyAnimationOne.calculationMode = kCAAnimationPaced;
    keyAnimationOne.removedOnCompletion = NO;
    keyAnimationOne.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [keyAnimationOne setAutoreverses:NO];
    [self.progressLable.layer addAnimation:keyAnimationOne forKey:nil];
}
/**
 *  获取小球动画
 */
-(void)getBallLabelView{
    CAKeyframeAnimation  *keyAnimationBall = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathAddArc(path, NULL,self.bounds.size.width/2.0, self.bounds.size.height/2.0,self.bounds.size.width/2.0,M_PI/2,M_PI/2+2*M_PI*self.endProgress,0);
    keyAnimationBall.path =path;
    CGPathRelease(path);//释放路径对象
    keyAnimationBall.duration=SZRANIMATIONTIME;
    keyAnimationBall.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    keyAnimationBall.fillMode = kCAFillModeForwards;
    keyAnimationBall.calculationMode = kCAAnimationPaced;
    keyAnimationBall.removedOnCompletion = NO;
    [keyAnimationBall setAutoreverses:NO];
    [self.ballLable.layer addAnimation:keyAnimationBall forKey:nil];
}
/**
 *  添加基本动画
 *
 *  @param layer
 *  @param duration
 */
- (void)addAnimation:(CAShapeLayer *)layer duration:(CFTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    animation.fillMode=kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration=duration;
    [layer addAnimation:animation forKey:nil];
}
//进度条
-(void)progress{
    self.Progress+=0.5;
    if (self.Progress>=self.endProgress*100) {
        [self.timer invalidate];
        self.timer=nil;
        self.Progress=self.endProgress*100;
    }
    self.progressLable.text=[NSString stringWithFormat:@"%.0f%%",self.Progress];

}


@end
