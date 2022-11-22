# debug_tools_wifi

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



### 项目结构
    app              启动
    cache            读写缓存
    common           通用工具类
    components       通用解析
    model            通用模型
    pages            主业务页面
    theme            主题

### pages
    login   登录
    mine    我的
    monitor 实时监测数据
        ｜
        ｜-------------- controller 整个项目的所有数据处理获取都是在此类中，包含各种读写操作socket数据的read，数据的处理，其中主要是以寄存器地址作为标志区分
        ｜
        ｜-------------- page 主要是实时监测数据的页面展示
        ｜
        ｜-------------- model 实时监测数据模型
    parameters  运行参数设置
        ｜
        ｜-------------- widget 通用widget类
        ｜-------------- page 包含（基本参数、检测点、流量控制、摄像头、平台链接、设备信息）
                            ｜
                            ｜--------------- camera                 摄像头参数
                            ｜--------------- flow_control           流量控制
                            ｜--------------- master_station         设备信息
                            ｜--------------- parameter_base         基本参数
                            ｜--------------- monitor_point          检测点参数
                                                    ｜
                                                    ｜-------------  aperture_page                   开度测量
                                                    ｜-------------  flowmeter_page                  流量
                                                    ｜-------------  generator_power_page            功率
                                                    ｜-------------  monitor_point_page              检测点
                                                    ｜-------------  monitor_point_parmset_page      监测点参数
                                                    ｜-------------  water_level_page                水位
                            ｜--------------- platform_connect       平台连接
                                                    ｜
                                                    ｜-------------  mqtt_page                       mqtt
                                                    ｜-------------  obs_page                        obs
                                                    ｜-------------  platform_page                   平台设置
                                                    ｜-------------  platform_parm_page              平台参数设置
    report  记录
    root    根类
    setting 设置
    welcome 欢迎
    workbench 工作台

### 注意点
    1. 在写入成功之后会去读取一次缓存中最新一条的读操作,在一些特定的情况会做特定的处理
    2. 除个别如mqtt，obs等修改完就做读取操作，其余的都为整读整取，必须点击下发操作才可以
    3. 在检测点参数页面，每个页面都会有水位测量，启用，未启用需要单独读取水位测量数据
    4. 每个监测点页面都会有流量值，流量值为实时读取数据，在监测点页面无其他操作的情况下定时1s读取
    5. 参数设置有可能为负数，负数的设置就是2的32次方减去你所填入的值（有倍数需要先乘倍数）
    6. 实时监控页面监测点列表如果水位测量为未启用则不显示在列表上