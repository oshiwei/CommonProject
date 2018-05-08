# CommonProject
项目框架

## 添加PCH文件
新建文件，选择PCH File，要在#ifdef __OBJC__/#endif之间添加需要全局引用的OC头文件，才能避免被工程中的C文件引用到产生错误。
将pch文件预编译功能（Precompile Prefix Header）打开，可以提高下次编译速度。
设置pch文件路径（Prefix Header）路径$(SRCROOT)/Supporting Files/PrefixHeader.pch。

## 创建开发TARGET
右击工程TARGETS中CommonProject点击Duplicate复制target，将新target命名为CommonProjectDev，用作开发。
由于创建新target的目的只是用于区分出开发环境，故不新建Info.plist文件，两个target共用。
在CommonProjectDev的Build Settings中，将Info.plist File改成和CommonProject的一样，Preprocessor Macros中添加COMMONPROJECTDEV宏，用于区分target。

## 用CocoaPods管理第三方库
两个target共用同样的pods，Podfile语法请参考：https://guides.cocoapods.org/using/the-podfile.html


