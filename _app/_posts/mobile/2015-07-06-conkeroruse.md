---
layout: post
title: conkeror超级使用指南
category: mobile
tags:
- conkeror
- 基础
- 原理
- debian
- aura
- hd
- net
- 指南
plugin: intense
hidden: true
head: |
  <link rel="chrome-webstore-item" href="https://chrome.google.com/webstore/detail/pjdeblccplohlgedbefopohaedodcgci">
---
![](/assets/img/050706conkerorggl.png)
 <b><em> 针对kobo aura hd debian系统，conkeror相关的帖子已经发过多篇，到目前所有梦想的功能都已经实现，所以重新疏理一下。   </em> </b>

# 实现功能

- 全部网站user-agent默认使用ios safari模式或android模式，根据需求制订网站普通模式  
- 境外网站自动代理模式，反DNS污染  
- 实时更新中国区为主网站广告弹窗adblock模式  
- 单个网站、网页、文章、不同框架等等字体、字号单独设定  
- 网站字体全黑、链接字体全黑＋下划线  
- 网页背景单独制订纯白  
- 一键切换自订制阅读eink模式，改变字号、字体、字色、背景  
- 一键调用instapaper抽取页面生成阅读模式  
- 一键加delicious在线书签  
- 一键开启并加载所有喜爱站点  
- 无限制分配快捷键给每个喜爱站点  
- 凡带有搜索功能的网站、论坛一键调出搜索  
- 谷歌、AOL搜索页面搜索词背景高亮，字体、页面布局专门订制，经搜索链接打开的网站页面加载极简模式  
- 快速查词  

# 具体实现方法

首先安装conkeror，直接使用sudo apt-get install conkeror安装。程序及文件存放路径在/usr/share/conkeror/中，配置文件在/home/USER-NAME/.conkerorrc中。

## 全部网站user-agent默认使用ios safari模式或android模式，根据需求制订网站普通模式

全部网站设定手机模式，在.conkerorrc中作如下配置：  

```ruby
set_user_agent("Mozilla/4.0 (Android; Mobile; rv:24.0) Gecko/24.0 Firefox/24.0");

```

单个网站设定普通模式，需要user-agent-policy.jsx文件。

在debian上安装的conkeror中，所有自带配置js文件在modules文件夹。但该文件夹下少user-agent-policy.jsx文件，在emacs官网下载并存放于该路径后并不生效，应该是其他几个配置文件的问题，懒得一个个测了，就把windows系统安装的conkeror中的modules文件夹直接拷贝替换。

需要以普通网页模式打开的网站，在.conkerorrc文件中做如下配置：

```ruby

require("user-agent-policy");
user_agent_policy.define_policy("default",
    user_agent_firefox(),
    "wx.qq.com",
    build_url_regexp($domain = /(.*\.)?qq/),
    "wx.qq.com");

```

## 境外网站自动代理模式，反DNS污染

打开mozilla develop的addons页面，下载autoproxy 0.4b2.2版本，然后在conkeror地址栏输入about:addons，“安装本地插件”，选择安装。

安装后选择全局代理，具体代理的建设，我使用的是shadowsocks，具体查阅我另一篇翻墙帖子。

然后更新pac被Great Fire Wall屏弊的网站列表。具体见下图

![image](/assets/img/050706conkeror1.png)
![image](/assets/img/050706conkeror2.png)
![](/assets/img/050706conkeror3.png)

## 实时更新中国区为主网站广告弹窗adblock模式

安装adblock和autoproxy一样，版本选择1.3.10，具体见上面截图。

## 单个网站、网页、文章、不同框架等等字体、字号单独设定

以谷歌网站为例，做如下设定。其他网站copy后修改相关内容即可。

设定具体网站的某块内容，使用其他pc浏览器右击“查看元素”即可。在上篇贴子中有详细说明。

```ruby

register_user_stylesheet(
	make_css_data_uri(
	["a{font-size: 32pt !important;width:300%!important; font-family: HeiTi !important;}",
	"div,h3,span,p{color: black !important; font-family: hgongshu !important; font-size: 28pt !important; line-height: 125% !important;}",
	"b{background: #cccccc !important; color: black !important; font-size: 28pt !important;}"],
	$domains = ["google.com","aol.com","google.com.hk"]));

```

## 网站字体全黑、链接字体全黑＋下划线， 网页背景单独制订纯白

```ruby

register_user_stylesheet(
	make_css_data_uri(["*{color: black !important;}",
	"* { image-rendering:optimizeSpeed ; }",
	":link, :link * {color: #000000 !important; text-decoration: underline !important;}",
	":visited, :visited * {color: #999999 !important; border-color: blue !important;}"]));

```

## 一键切换自订制阅读eink模式，改变字号、字体、字色、背景

如果在阅读时网页字体过小、颜色过淡，按p键一键切换到eink模式

```ruby

function eink_page (I) {
var styles=
    '* { background: white !important; color: black !important; font-family: Caecilia !important; font-size: 23pt !important; line-height: 45px !important; }'+
    ':link, :link * { color: #333333 !important; }'+
    ':visited, :visited * { color: #d75047 !important; }';
    var document = I.buffer.document;
    var newSS=document.createElement('link');
    newSS.rel='stylesheet';
    newSS.href='data:text/css,'+escape(styles);
    document.getElementsByTagName("head")[0].appendChild(newSS);
}
interactive("eink-page",
	"Eink the page in an attempt to save your eyes.", eink_page);
define_key(content_buffer_normal_keymap, "p", "eink-page");

```

## 一键调用instapaper抽取页面生成阅读模式

按a键

```ruby

interactive("render_instapaper",
            "Render page with InstaPaper's Text view.",
            function (I) {
                var d = I.window.buffers.current.document;
                if(!d.body)
                    throw('Please wait until the page has loaded.');
                browser_object_follow(
                    I.window.buffers.current,
                    OPEN_CURRENT_BUFFER,
                    'http://www.instapaper.com/text?u='+encodeURIComponent(d.location.href));
                I.window.minibuffer.message("Rendering with InstaPaper ...");
            });
define_key(content_buffer_normal_keymap, "a", "render_instapaper");

```

## 一键加delicious在线书签

想添加目前网站在线书签，直接设定为Alt+b键，搜索自己设定的书签，B。

代码如下

```ruby

interactive("delicious-post",
            "bookmark the page via delicious",
            function (I) {
                check_buffer(I.buffer, content_buffer);
                let posturl = 'https://api.del.icio.us/v1/posts/add?&url=' +
                    encodeURIComponent(
                        load_spec_uri_string(
                            load_spec(I.buffer.top_frame))) +
                    '&description=' +
                    encodeURIComponent(
                        yield I.minibuffer.read(
                            $prompt = "name (required): ",
                            $initial_value = I.buffer.title)) +
                    '&tags=' +
                    encodeURIComponent(
                        yield I.minibuffer.read(
                            $prompt = "tags (space delimited): ")) +
                    '&extended=' +
                    encodeURIComponent(
                        yield I.minibuffer.read(
                        $prompt = "extended description: "));

                try {
                    var content = yield send_http_request(
                        load_spec({uri: posturl}));
                    I.window.minibuffer.message(content.responseText);
                } catch (e) { }
            });
interactive("delicious-post-link",
            "bookmark the link via delicious",
            function (I) {
                bo = yield read_browser_object(I) ;
                mylink = load_spec_uri_string(
                    load_spec(encodeURIComponent(bo)));
                check_buffer(I.buffer, content_buffer);
                let postlinkurl = 'https://api.del.icio.us/v1/posts/add?&url=' +
                    mylink +
                    '&description=' +
                    encodeURIComponent(
                        yield I.minibuffer.read(
                            $prompt = "name (required): ",
                            $initial_value = bo.textContent)) +
                    '&tags=' +
                    encodeURIComponent(
                        yield I.minibuffer.read(
                            $prompt = "tags (space delimited): ")) +
                    '&extended=' +
                    encodeURIComponent(
                        yield I.minibuffer.read(
                            $prompt = "extended description: "));
                try {
                    var content = yield send_http_request(
                        load_spec({uri: postlinkurl}));
                    I.window.minibuffer.message(content.responseText);
                } catch (e) { }
            }, $browser_object = browser_object_links);
define_key(default_global_keymap, "M-b", "delicious-post");
//define_key(default_global_keymap, "W", "delicious-post-link");
define_webjump("b", "http://delicious.com/yefeiyu/search/%s");

```

## 一键开启并加载所有喜爱站点

设定喜爱书签到E上

其中load_url_in_new_buffer行是要设定的部分，一次不要超过太多，限于kobo内存。

```ruby

//Multiple "Bookmarks" with One Key, every english
interactive("open-all-english",
    "opens bookmarks I visit frequently",
    function(I){
         load_url_in_new_buffer("http://www.bbc.co.uk/zhongwen/simp",I.window);
         load_url_in_new_buffer("http://mobile.nytimes.com/business/",I.window);
         load_url_in_new_buffer("http://hbr.org",I.window); 
         load_url_in_new_buffer("http://www.ftchinese.com/channel/english.html",I.window);
         load_url_in_new_buffer("http://m.51voa.com/voa_standard_english",I.window);
    });
define_key(content_buffer_normal_keymap, "E", "open-all-english")

```

## 无限制分配快捷键给每个喜爱站点

下面举例为g键设为aol搜索。使用时按g调出地址栏输入框，再按g加空格后输入要搜索内容。

```ruby

define_webjump("g", "http://m.search.aol.com/search?enabled_terms=&s_it=comsearch&q=%s&count_override=30&s_chn=prt_main5&count_override=50");

```

## 凡带有搜索功能的网站、论坛一键调出搜索

复制网页地址方式为“c-0”，把搜索部分换成“%s”即可。

## 谷歌、AOL搜索页面搜索词背景高亮，字体、页面布局专门订制，经搜索链接打开的网站页面加载极简模式

见上述例子。

## 快速查词

将“,”键设定为调出查词，输入单词后回车自动转到dict.org网站

这儿使用起来没有emacs下的离线查词快速方便  
具体我直接上传我的.conkerorrc文件吧。
<a href="https://github.com/yefeiyu/yefeiyu.github.io/blob/master/assets/img/.conkerorrc">下载.conkerorrc文件</a>


