package com.framework.controller.admin;

import com.framework.entity.Notice;
import com.framework.service.NoticeService;
import com.framework.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @auther: 翁筱寒
 * @date: 2020/5/25 12:03
 * @desc: //TODO
 */
@Controller
@RequestMapping("administrator")
public class AdminNoticeController {
    @Autowired
    private NoticeService noticeService;
@RequestMapping("notice.action")
    public String notice(Model model){
    Notice notice = noticeService.findLastNotice();
    model.addAttribute("notice",notice);
    return "admin/admin_notice_list";
    }
    @RequestMapping("savenotice.json")
    @ResponseBody
    private Result update(@RequestParam("id")String id,@RequestParam("content")String content){
        noticeService.updateNotice(id,content);

        return Result.success("更新公告成功~");
    }
}
