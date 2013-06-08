JingRound
=========

仿jing.fm的音乐播放视图，支持旋转和自定义参数。

###使用说明：
可以在Storybord、Xib直接拖个View然后更改其类为`JingRoundView`，设置基本属性即可：

```
//设置代理，获取回调事件
self.roundView.delegate = self;
//设置中间的图像
self.roundView.roundImage = [UIImage imageNamed:@"girl"]; 
//设置转圈的速度
self.roundView.rotationDuration = 8.0;
//起始状态，转or不转
self.roundView.isPlay = NO;
```
当点击中间圆盘的时候会触发暂停、播放事件，当然有一个协议：`JingRoundViewDelegate`：
```
-(void)playStatuUpdate:(BOOL)playState
{
    NSLog(@"%@...", playState ? @"播放": @"暂停了");
}
```
使用的时候需要引入一下这两个库：
```
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
```

###有问题反馈：

*作者博客发布页面：[http://www.isaced.com/post-210.html](http://www.isaced.com/post-210.html) 
*