
import 'package:jpush_flutter/jpush_flutter.dart';

///初始化极光推送
void startJPush() {
  JPush jpush = JPush();
  //配置jpush(不要省略）
  //debug就填debug:true，生产环境production:true
  jpush.setup(
      appKey: '3e8bca20cdb6b9ea1f848a20',
      channel: 'developer-default',
      production: true,
      debug: true);
  //监听jpush(ios必须配置)
  jpush.applyPushAuthority(
      const NotificationSettingsIOS(sound: true, alert: true, badge: true));
  jpush.addEventHandler(
    onReceiveNotification: (Map<String, dynamic> message) async {
      print('message11:$message');
    },
    onOpenNotification: (Map<String, dynamic> message) async {
      //点击通知栏消息，在此时通常可以做一些页面跳转等
      print('message22:$message');
    },
  );
}
