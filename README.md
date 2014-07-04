JingRound
=========

赶时髦用Swift也写了一遍：[JingRound-Swift](https://github.com/isaced/JingRound-Swift)

rewritten from Objective-C to Swift...

仿jing.fm的音乐播放视图，支持旋转和自定义参数。


Imitation jing.fm music playing view, support rotation and custom parameters.

![image](https://raw.github.com/isaced/JingRound/master/Screenshot.png)

###使用说明(Usage)：

可以在Storybord、Xib直接拖个View然后更改其类为`JingRoundView`，设置基本属性即可:

You can Drag and Drop a UIView in Storybord or Xib,and then change its class `JingRoundView`, set the basic parameter:

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

暂停与播放(pause and play):

```
[self.roundView play];
[self.roundView pause];
```

当点击中间圆盘的时候会触发暂停、播放事件，当然有一个协议：`JingRoundViewDelegate`：

When you touch in the middle of the disc when it will trigger the pause, play events, of course, there is a delegate `JingRoundViewDelegate`:

```
-(void)playStatuUpdate:(BOOL)playState
{
    NSLog(@"%@...", playState ? @"播放": @"暂停了");
}
```
使用的时候需要引入一下这两个库：

Of course, you need to import two framework:

```
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
```

###欢迎反馈(Welcomes feedback)：

作者博客发布页面(Author)：[http://www.isaced.com/post-210.html](http://www.isaced.com/post-210.html) 
