package com.framework.controller.portal;

import com.framework.entity.Message;
import com.framework.entity.User;
import com.framework.service.MessageService;
import com.framework.utils.Result;
import com.framework.utils.UserOnline;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @auther: 翁筱寒
 * @date: 2020/4/8 12:05
 * @desc: //我的消息
 */
@Controller
@RequestMapping("portal/my/message")
public class MessageController {
    @Autowired
    private MessageService messageService;
    /**
     * 用户是否在线
     * @param
     * @return
     */
    public boolean userOnLine(HttpSession session){
        return UserOnline.portalUserIsOnline(session);

    }


    /**
     * 根据用户id查询消息列表
     * @return
     */

    @RequestMapping("list.action")
    public String message(HttpSession session, Model model,
                          @RequestParam(value = "pageNum",defaultValue = "1")int pageNum,
                          @RequestParam(value = "pageSize",defaultValue = "5")int pageSize){
        //不在线就去登录页
        if (!userOnLine(session)){
            return "admin/login";
        }
        //只需要在查询前调用
        PageHelper.startPage(pageNum,pageSize);
        User user = (User) session.getAttribute("user");
        List<Message> messageList = messageService.findListByUserId(String.valueOf(user.getUserId()));
        PageInfo<Message> pageInfo=new PageInfo<Message>(messageList);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("pageSize",pageSize);
        model.addAttribute("pageNum",pageNum);
        for (Message message : messageList) {
            messageService.setToAlreadyRead(message.getMessageId());
        }
        return "portal/user/message_list";
}
@RequestMapping("deleteMsg.json")
    @ResponseBody
    public Result delete(@RequestParam("idArr")String[] idArr,HttpSession session){
        if (!UserOnline.portalUserIsOnline(session)){
            return Result.error("请登陆后再尝试删除");
        }
        messageService.delete(idArr);;
        return Result.success();
    }
}
