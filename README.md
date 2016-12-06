# SuiYiWan
封装了很多工具类，和抽了一些分类，MVVM设计模式的运用
##整体框架
[![Snip20161206_5.png](http://image.huangbowei.com/images/2016/12/06/Snip20161206_5.png)](http://image.huangbowei.com/image/MLwk)

##效果图
[![SuiYiWan.gif](http://image.huangbowei.com/images/2016/12/06/SuiYiWan.gif)](http://image.huangbowei.com/image/MS2f)

##主要技术
>* 1、AVFoundation框架处理视频、音频
* 2、抽了方法，5行代码实现滑动返回功能
* 3、抽了工具类：清除缓存（JGFileManager），保存图片至自定义相册（JGPhotoManager）
* 4、给系统的类做了类扩展：日期显示（NSDate+Date），改变输入框占位文字的颜色（UITextField+placeholderColor），裁剪圆形图片（UIImage+Randar），轻松添加导航栏左右按钮（UIBarButtonItem+Item），轻松改变任意控件frame（UIView+Frame）
* 5、抽了基础控制器，轻松实现搭建多个不等高cell的tableview控制器
* 6、用MJRefresh框架实现下拉刷新、上拉刷新
* 7、运用MVVM设计模式 布局精华控制器的代码

  
  
##项目中运用到的具体知识点，请看源码，有详细注释
