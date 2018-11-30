//
//  GFSideWaterView.m
//  iOS-ShareCup
//
//  Created by kys-20 on 09/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFSideWaterView.h"



/*
 正弦函数
 y =Asin（ωx+φ）+C
 A 表示振幅，也就是使用这个变量来调整波浪的高度
 ω表示周期，也就是使用这个变量来调整在屏幕内显示的波浪的数量
 φ表示波浪横向的偏移，也就是使用这个变量来调整波浪的流动
 C表示波浪纵向的位置，也就是使用这个变量来调整波浪在屏幕中竖直的位置。
 */
@interface GFSideWaterView ()

@property (nonatomic,strong) CADisplayLink *waveDisplayLink;
@property (nonatomic,strong) CAShapeLayer *firstWaveLayer;
@property (nonatomic,strong) CAShapeLayer *secondWaveLayer;


@property (nonatomic) CGFloat waveA; // 水文A振幅 （上面的）
@property (nonatomic) CGFloat waveW; // 水文周期 W
@property (nonatomic) CGFloat offsetX; // 位移X fai
@property (nonatomic) CGFloat currentK; // 当前波浪高度Y C
@property (nonatomic) CGFloat waveSpeed; //当前水文速度
@property (nonatomic) CGFloat waterWaveWidth; //水文宽度
@property (nonatomic,strong) UIColor *firstWaveColor; //波浪颜色
@property (nonatomic,strong) UIColor *secondWaveColor; //第二个颜色

@end

@implementation GFSideWaterView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds  = YES;
        [self setUpBtn];
    }
    return self;
}

- (void)setWave {
    //设置波浪的宽度
    self.waterWaveWidth = self.bounds.size.width;
    //设置波浪的颜色
    self.firstWaveColor = [UIColor colorWithWhite:0.6 alpha:0.2];
    //设置波浪的速度
    self.waveSpeed = 0.2/M_PI;
    //初始化layer
    if (_firstWaveLayer == nil) {
        //初始化
        _firstWaveLayer = [CAShapeLayer layer];
        //设置闭环的颜色
        _firstWaveLayer.fillColor = _firstWaveColor.CGColor;
        //设置边缘线的颜色
        //        _firstWaveLayer.strokeColor = [UIColor blueColor].CGColor;
        //        //设置边缘线的宽度
        //        _firstWaveLayer.lineWidth = 4.0;
        //        _firstWaveLayer.strokeStart = 0.0;
        //        _firstWaveLayer.strokeEnd = 0.8;
        [self.layer addSublayer:_firstWaveLayer];
    }
    if (self.secondWaveLayer == nil) {
        //初始化
        self.secondWaveLayer = [CAShapeLayer layer];
        //设置闭环的颜色
        self.secondWaveLayer.fillColor = _firstWaveColor.CGColor;
        //设置边缘线的颜色
        //        _firstWaveLayer.strokeColor = [UIColor blueColor].CGColor;
        //        //设置边缘线的宽度
        //        _firstWaveLayer.lineWidth = 4.0;
        //        _firstWaveLayer.strokeStart = 0.0;
        //        _firstWaveLayer.strokeEnd = 0.8;
        [self.layer addSublayer:self.secondWaveLayer];
    }
    //设置波浪流动速度
//    self.waveSpeed = 0.1;
    //设置振幅
    self.waveA = 5;
    //设置周期
    self.waveW = 1/20.0;
    //设置波浪纵向位置
    self.currentK = self.frame.size.height/2;//屏幕居中
    //启动定时器
    self.waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
    [self.waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];

}

-(void)getCurrentWave:(CADisplayLink *)displayLink
{
    //实时的位移
    self.offsetX += self.waveSpeed;
    [self setCurrentFirstWaveLayerPath];
    [self setCurrentSecondWaveLayerPath];
}

-(void)setCurrentFirstWaveLayerPath
{
    //创建一个路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = self.currentK;
    //将点移动到 x=0,y=currentK的位置
    CGPathMoveToPoint(path, nil, 0, y);
    for (NSInteger x = 0.0f; x<=self.waterWaveWidth; x++) {
        //正玄波浪公式
        y = self.waveA * sin(self.waveW * x+ self.offsetX)+self.currentK;
        //将点连成线
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, self.waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    _firstWaveLayer.path = path;
    CGPathRelease(path);
}

-(void)setCurrentSecondWaveLayerPath
{
    //创建一个路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = self.currentK;
    //将点移动到 x=0,y=currentK的位置
    CGPathMoveToPoint(path, nil, 0, y);
    for (NSInteger x = 0.0f; x<=self.waterWaveWidth; x++) {
        //正玄波浪公式
        y = (self.waveA+2) * sin(self.waveW * x+1.5*self.offsetX + 10)+self.currentK;
        //将点连成线
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, self.waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    self.secondWaveLayer.path = path;
    CGPathRelease(path);
}



//夜间模式和二维码的button
- (void)setUpBtn
{
//    UIButton *nightBtn = [UIButton new];
//    [nightBtn setBackgroundImage:[UIImage imageNamed:@"night_selected"] forState:UIControlStateNormal];
//    [nightBtn setBackgroundImage:[UIImage imageNamed:@"night_selected"] forState:UIControlStateSelected];
//    [nightBtn addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
//    nightBtn.tag = 0;
//    [self addSubview:nightBtn];
//    [nightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self).offset(-20);
//        make.left.equalTo(self).offset(10);
//        make.width.height.equalTo(@30);
//    }];
//
//    UIButton *QRBtn = [UIButton new];
//    [QRBtn setImage:[UIImage imageNamed:@"QRCode"] forState:UIControlStateNormal];
//    QRBtn.tag = 1;
//    [QRBtn addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:QRBtn];
//    [QRBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self).offset(-20);
//        make.right.equalTo(self).offset(-10);
//        make.height.width.equalTo(@30);
//    }];
//
}
//点击事件
- (void)ClickBtn:(UIButton *)btn
{
    self.callBack(btn.tag);
}

//- (void)dealloc
//{
//    [_waveDisplayLink invalidate];
//}

@end
