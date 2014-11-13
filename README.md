JingRound
=========

Objective-C Version - [here](https://github.com/isaced/JingRound)


仿jing.fm的音乐播放视图，支持旋转和自定义参数。


Imitation jing.fm music playing view, support rotation and custom parameters.

![image](https://raw.github.com/isaced/JingRound/master/Screenshot.png)

###使用说明(Usage)：

可以在Storybord、Xib直接拖个View然后更改其类为`JingRoundView`，设置基本属性即可:

You can Drag and Drop a UIView in Storybord or Xib,and then change its class `JingRoundView`, set the basic parameter:

```
//设置代理，获取回调事件
self.roundView.delegate = self
//设置中间的图像
self.roundView.roundImage = UIImage(named: "girl")
//起始状态，转or不转
self.roundView.isPlay = false
```

暂停与播放(pause and play):

```
self.roundView.play()
self.roundView.pause()
```

当点击中间圆盘的时候会触发暂停、播放事件，当然有一个协议：`JingRoundViewDelegate`：

When you touch in the middle of the disc when it will trigger the pause, play events, of course, there is a delegate `JingRoundViewDelegate`:

```
func playStatuUpdate(playState: Bool) {
    NSLog("%@...", playState ? "Playing": "Pause")
}
```

###欢迎反馈(Welcomes feedback)：

作者博客地址(Author)：[http://www.isaced.com/post-210.html](http://www.isaced.com/post-210.html) 
