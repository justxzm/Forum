# Forum
IT技术论坛

>系统说明

* 开发环境：eclipse+mysql+tomcat
* 使用技术：jsp+servlet+ajax+jdbc+struts2文件上传+qrcode二维码
* 使用场景：校园计算机专业讨论社区
* 部署环境：ubuntu14+tomcat7+jdk8+mysql5.5

> 文件说明	 

* forum.sql用来还原该项目数据库

> 使用说明

1. 还原数据库
2. 修改/Forum/src/db/ConnDb.java中的数据库连接信息
3. 修改/Forum/src/servlet/SendEmail.java第68行处的emailAccount和emailPassword，即邮箱账号和密码，用于发送邮件，若使用163邮箱，则密码使用的是smtp密码，需登录163邮箱设置

* 有注册功能，用户名为root的用户拥有最高权限，可销号
* 数据库admin表中邮箱字段用于发送邮件找回密码

>关于

* 制作于2016-11，该项目的前生是[Blog](https://github.com/justxzm/Blog)，在其基础上增加了用户注册、创建板块、关注用户(板块)、分享等功能，由个人博客改为了多用户的论坛
* 由于在Blog基础上，所以同样没有分好层进行有效的封装抽象，将业务逻辑耦合在了jsp中，维护困难
* 基本无注释，查看痛苦
* 大神绕过:)
