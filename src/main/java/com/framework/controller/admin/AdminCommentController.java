package com.framework.controller.admin;

import com.framework.entity.Comment;
import com.framework.service.CommentService;
import com.framework.service.UserService;
import com.framework.utils.DateUtil;
import com.framework.utils.Result;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/29 16:11
 * @desc: //TODO
 */
@Controller
@RequestMapping("administrator/comment")
public class AdminCommentController {
    @Autowired
    protected CommentService commentService;
    @Autowired
    UserService userService;

    /**
     * 评论列表页
     * @return
     */
    @RequestMapping("list.action")
    public String list(@RequestParam(value = "pageNum",defaultValue = "1")int pageNum,
                       @RequestParam(value = "pageSize",defaultValue = "10")int pageSize,
                       Model model){
        Map<String,Object> map=new HashMap<String, Object>();
        PageHelper.startPage(pageNum,pageSize);
        List<Comment> commentList = commentService.list(map);
        for (Comment comment : commentList) {
            comment.setCommentTimeStr(DateUtil.date2String(comment.getCommentTime()));
        }
        PageInfo<Comment> pageInfo=new PageInfo<Comment>(commentList);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("pageSize",pageSize);
        return "admin/admin_comment_list";
    }

    /**
     * 删除评论
     * @param ids
     * @return
     */
    @RequestMapping("delete.json")
    @ResponseBody
    public Result delete(@RequestParam("ids") String[] ids){
        commentService.delete(ids);
        return Result.success();
    }
}
