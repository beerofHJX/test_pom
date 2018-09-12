package com.qf.oa.utils;

import com.qf.oa.entity.Employee;
import io.rong.RongCloud;
import io.rong.messages.TxtMessage;
import io.rong.methods.message._private.Private;
import io.rong.methods.user.User;
import io.rong.models.message.PrivateMessage;
import io.rong.models.response.TokenResult;
import io.rong.models.user.UserModel;

public class Utils {
    private static final String appKey= "8w7jv4qb82tby";
    private static final String appSecret= "aKTJ7PywsyF";
    private static RongCloud rongCloud;
    static {
        rongCloud = RongCloud.getInstance(appKey, appSecret);
    }

    public static String getToken(Employee employee){

        User User = rongCloud.user;

        /**
         * API 文档: http://www.rongcloud.cn/docs/server_sdk_api/user/user.html#register
         * 注册用户，生成用户在融云的唯一身份标识 Token
         */
        UserModel user = new UserModel()
                .setId(employee.getId()+"")
                .setName(employee.getName())
                .setPortrait("http://www.rongcloud.cn/images/logo.png");
        TokenResult result = null;
        try {
            result = User.register(user);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return  result.getToken();
    }
    public static boolean sendMsg(String fromId,String content,String...toId){
        //或私聊对象
        Private msgPrivate = rongCloud.message.msgPrivate;

        TxtMessage txtMessage = new TxtMessage(content, null);

        //私聊的消息对象
        PrivateMessage privateMessage = new PrivateMessage();
        privateMessage.setTargetId(toId);//接受者的id
        privateMessage.setSenderId(fromId);//发送者的id
        privateMessage.setContent(txtMessage);
        privateMessage.setObjectName(txtMessage.getType());

        try {
            msgPrivate.send(privateMessage);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }
}
