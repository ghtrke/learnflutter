import 'package:flutter/material.dart';
import 'listpage.dart';

void main() {
  runApp(const MyApp());
}

// 步骤
// 设计，测试流程，编写代码，调试
//
// 问题
//    - done: 针对一个问题，进行深挖，例如 ORM, 需要了解其历史和发展，想要解决的问题，等等，而不是停留在表面
//      - 把数据库操作解耦到单独的层次中
//      - 使用面向对象的代码而非 raw sql, 提升可读性和可维护性
//      - 管理数据库结构变更
//      - drift 和 floor 的实现方式，选择技术栈时如何确定是否合适: column types, query, complex query, migration
//    - 测试：针对一个项目（尤其是新项目），如何制定测试策略？
//      - 不要一开始就想达到极致，从最基础的原则开始演进
//      - 研究透彻这个主题，将这个内容融入到以后的开发流程中: 应该根据每个项目的特点来编写测试，所以现在先做一些一般性的学习，根据具体项目选择合适的测试手段
//      - 研究 TDD
//      - 最终目标：每次开发代码前，先确定测试内容，测试策略，然后开始开发
//      - 研究数据库测试的合理测试方式：mock, 结合之前研究的单元测试的原则
//    - done: await/async, stream, streambuilder
//    - done: orm 设计，entity, 代表 database table 的类，是否需要和应用中使用的类区分开来? 从应用角度考虑，如果直接依赖 database table 的类，是否可以轻易替换 ORM? 应用直接使用 database table 的类是否合适?
//    - done: 封装 database 到一个单例中用于访问
//    - 了解 build.yaml 在哪一个阶段使用: 在代码的构建过程中使用
//    - P2: 阅读理解代码的能力，例如，深入了解 drift 的实现方式，尤其是 database connection 的处理
//      - 从顶层类的设计开始，猜测其中的成员设计意图，逐步深挖，还可以借助调试定位代码调用路径
//    - done: 模式
//      - 使用 dao 模式：更注重数据库访问层模型
//      - repository 模式：更注重领域模型
//      - 拆分：
//        + 数据库表格对应的类
//        + 数据库表格映射的领域对象类
//        + 每个数据库表格对应的 DAO/repository 类: 有待于进一步研究
//    - done: 研究 drift 的 appdatabase 如何管理 database connection
//    - 领域驱动设计: aggregate, factory, repository
//    - done: ORM 解决了什么问题，什么场景下适合使用 ORM?
//      + 当程序中需要访问数据库时，我们需要编写大量拼接 SQL 代码来和数据库交互，这种代码方式容易出错，也不好维护。ORM 把 SQL 拼接代码封装为面向对象编程语言，方便使用和维护
//      + 当封装足够合理时，ORM 实现了应用程序和底层数据库的解耦：只要封装的方法一致，使用哪种存储方式无所谓 
//      + 通常数据库的连接资源是有限的，为了控制资源消耗，ORM 会使用连接池的方式
//    - P2: 列出在一个项目中应当考虑的问题，以 sfa 为例，列举曾经犯下的错误，以及这些错误是怎么逐渐成为痛点
// 测试流程
//  - 首页点击按钮添加计划, 进入编辑页面(需要确保定时任务已经生效)
//  - 首页加载当天执行条目, 需要确保条目已生成
//  - 首页点击条目的 check 按钮
//  - 首页点击条目, 弹出对话框，包含编辑和删除两个选项
//    - 点击编辑进入编辑页面, 尝试编辑页面的各种功能, 让用户选择仅修改当前条目还是后续所有条目
//      + 改变名称
//      + 改变日期: 不允许生成之前的条目
//      + 改变时间
//      + 改变重复日期
//    - 点击删除，弹出对话框要求用户选择删除当前条目还是未来计划
//      + 如果选择删除当前条目，plan 分裂为 2 个，一个到昨天，一个从明天开始
//      + 如果选择删除未来所有条目，plan 的 endDate 会被设置
// UX 设计
//    p1 重新回顾整个流程，哪些共性的知识是我应当掌握的?
//
//    p1 编辑页面: 3/2
//      - done UI: 标题，日期，起止时间，重复（每周一）
//        + done 所有控件左对齐
//        + done 日历选择，隐藏掉，等到选择日期时再弹出，否则太难看
//        + done 时间选择，选中后应该在原控件展示选择的值而不是 start time
//        + done weekdays: 选择后也应该显示选中的内容而不是依然显示 weekdays
//      - done 传值，写逻辑
//    数据库表格重构: 3/3
//      - done p1: 建立数据库表格新结构
//    列表页面:  3/4
//      - done p1: 删除任务
//      - p1: 定时生成每日任务
//      - p1: 点击编辑任务，不做任何操作返回，编辑窗口应当自己消失
//      - done p1: 默认加载当天日程
//      - done p1: 每天日程前添加日期标识
//      - p2: 默认加载当周日程, 上滑下滑时加载更多日程
//    提醒: 3/5
//      - p1: 提前 10 分钟发送提醒
//      - p2: 模仿多邻国，不断提醒轰炸
// 设计
//    p1 代码拆分，让代码结构更清晰
//    p1 封装，私有变量/方法，公用方法/变量
//       - 私有变量, 单下划线
//       - final 关键字
//       - const 关键字
//       - factory 关键字
//    p1 数据约束: 原则是无论是哪个入口都不允许创建非法数据
//       - 首先需要确认数据约束原则
//       - 然后确定需要约束的入口
//       - 数据库约束
//       - 前端约束
//       - 如果后端提供 API, 也要添加约束
//    p2 UT
//    p1 数据库交互，orm
//    p3 开发环境搭建
//
// 问题
//     done p1 所有的 todo
//     done p1 android 调试
//     done p1 ios 调试
//     done p1 浏览器调试
//     p2 真机调试
//     DO 变量后面跟一个感叹号是什么意思？
//     done p2 i18n, 包括时间
//     p2 safearea 使用
//     p2 vim 多行编辑
//     p2 哪些资源需要调用 dispose 方法？
//     p2 BuildContext, 哪里可以拿到？
//     p2 const 很多地方都有 warning，构造 widget 时添加 const 关键字，需要了解机制
// bug:
//     p1 item 页面新建数据后，返回主页面，新建数据没有加载; 但在 reload 代码后，新数据可以显示出来
//        解决方案一：使用 Navigator.pushReplacement 来重新加载主页面
//     todo  解决方案二：将写入数据的逻辑挪动到主页面，新建页面调用主页面的写入逻辑
//     done 重写 toMap 方法，提供更友好的接口
// 首页：
//     done p1 点击 checkbox: 设置完成状态
//     done p1 点击文字区域：弹出编辑和删除按钮，点击编辑进入编辑页面(带入原值)
//     p3 按照日期 group 待办
//     p3 使用 futurebuilder 来优化 UI 加载
// 编辑页面：
//     done p1 添加详细描述控件
//     done p1 添加日历控件
//     done p1 添加必填校验
//     done p1 添加日期校验: 放弃
//     done p2 提交按钮换一个图标
//     done p1 返回首页后应当带入刚刚添加的条目
//     p3 日历控件可能需要优化
//     p3 使用 futurebuilder 优化 UI 加载
// 数据：
//     p1 数据持久化: 如果数据库已经存在就不要再创建了
//     done p3 优化数据库读写代码
// 优化：
//     p1 Item 的使用混乱
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
