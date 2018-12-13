# v2ray-mac

v2ray官方文档给出了几个mac上的第三方客户端，使用过一段时间，也没有太大问题。不过鉴于别人维护的版本不一定及时更新，于是就自己动手基于v2ray-core打造适合自己的工具，可以随着官方版本更新，使用起来更灵活。注意：不是客户端哦，仅仅是工具，或者说一些脚本。个人使用，有兴趣的同学也可以拿来玩玩。

## 几个需求

下面是个人使用时感觉比较实用的几点。

### 开机自启

mac上不能像linux那样很方便的以service的形式实现自启动，这里采用了比较简单的方式，通过设置用户登录项来调用启动v2ray的脚本，同时需要修改start.sh的打开方式为终端。目前还有一点不是很完善，就是脚本启动后会留下一个终端的窗口。

```
#!/bin/sh

BASE=$(cd "$(dirname "$0")"; pwd)
cd $BASE

# start a http server
python -m SimpleHTTPServer 88 > /dev/null 2>&1 &

# set pac
/usr/sbin/networksetup -setautoproxyurl "Wi-Fi" "http://127.0.0.1:88/auto.pac"
/usr/sbin/networksetup -setautoproxystate "Wi-Fi" on

# start v2ray
./v2ray > /dev/null 2>&1 &
```

v2ray会将shell挂起，此处改为输出到null及添加&，保证当前脚本执行完退出。

### 全局代理

由于最新版的mac自动代理不支持file文件的形式，所以pac文件需要以web形式提供，这里使用python来启动一个简单的http服务提供pac文件供系统使用。

如果不是wifi上网，可以自行修改。

### 过滤广告

v2ray强大的地方就是代理及过滤一步到位，此处使用自建的site.dat文件来达到此效果。

## 停止v2ray

为了方便更新配置啊等等，增加了一个stop脚本，可以无痛关闭v2ray代理。
