# CommonProject
项目框架

## 添加PCH文件
新建文件，选择`PCH File`，要在`#ifdef __OBJC__``#endif`之间添加需要全局引用的OC头文件，才能避免被工程中的C文件引用到产生错误。
将pch文件预编译功能（`Precompile Prefix Header`）打开，可以提高下次编译速度。
设置pch文件路径（`Prefix Header`）路径`$(SRCROOT)/Supporting Files/PrefixHeader.pch`。

## 创建开发TARGET
右击工程TARGETS中CommonProject点击`Duplicate`复制target，将新target命名为CommonProjectDev，用作开发。
由于创建新target的目的只是用于区分出开发环境，故不新建Info.plist文件，两个target共用。
在CommonProjectDev的`Build Settings`中，将`Info.plist File`改成和CommonProject的一样，`Preprocessor Macros`中添加`COMMONPROJECTDEV`宏，用于区分target。

## 用CocoaPods管理第三方库
两个target共用同样的pods，Podfile语法请参考：https://guides.cocoapods.org/using/the-podfile.html

## 目录结构
>Define：一些宏定义文件。  
>LocalLib：一些本地库，自己写的一些控件、工具、category等，包括自己对第三放库的二次封装。  
>ThirdLib：一些第三方库，第三放库尽量用CocoaPods管理，不能用CocoaPods管理的放在这，像一些第三方分享库。  
>AppDelegate：应用代理，应用级事件可能会比较多，最好通过category分文件管理。  
>Modules：业务模块，里面有Root、Manager两个基本子目录。
>>Root：存放项目基类，包含一些定制化的内容。  
>>Manager：是全局的基础管理服务，通常用类方法或单例实现。

