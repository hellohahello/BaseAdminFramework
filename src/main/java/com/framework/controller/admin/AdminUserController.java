package com.framework.controller.admin;

import com.framework.entity.User;
import com.framework.service.UserService;
import com.framework.utils.DateUtil;
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
 * @date: 2020/3/30 23:32
 * @desc: 后台用户管理
 */
@RequestMapping("administrator/user")
@Controller
public class AdminUserController {
    @Autowired
    protected UserOnline online;
    @Autowired
    private UserService userService;

    @RequestMapping("list.action")
    public String list(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
                       @RequestParam(value = "pageSize", defaultValue = "3") int pageSize,
                       Model model) {
        PageHelper.startPage(pageNum, pageSize);
        List<User> userList = userService.list();
        for (User user : userList) {
            user.setLastLoginTimeStr(DateUtil.date2String(user.getLastLoginTime()));
        }
        PageInfo<User> pageInfo = new PageInfo<User>(userList);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("pageSize", pageSize);
        return "admin/admin_user_list";
    }

    /**
     * 根据setToVIP的值判断是取消vip状态还是设置为vip用户
     * @param userId
     * @param setToVip
     * @return
     */
    @RequestMapping("update_vip.json")
    @ResponseBody
    private Result updateVipState(@RequestParam("userId")String userId,
                                  @RequestParam("setToVip")String setToVip,
                                  HttpSession session){
        if (!online.userIsOnline(session)){
            return Result.error("请登录后再来操作哦");
        }
        userService.updateVipState(userId,setToVip);
        return Result.success();
    }

    /**
     * 设置用户是否被封禁
     * 根据setToOff的值判断是封禁还是取消封禁
     * @param userId
     * @param setToOff
     * @return
     */
    @RequestMapping("update_off.json")
    @ResponseBody
    public Result updateOff(@RequestParam("userId")String userId,
                            @RequestParam("setToOff")String setToOff,
                                        HttpSession session){
        if (!online.userIsOnline(session)){
            return Result.error("请登录后再来操作哦");
        }
        userService.updateOffState(userId,setToOff);
        return Result.success();
    }

    /**
     * 角色设置页
     * @param userId
     * @return
     */
    @RequestMapping("role_set.action")
    public String roleSet(@RequestParam(value = "userId",required = false)String userId,
                          Model model){
        model.addAttribute("userId",userId);
        User user = userService.findById(Integer.valueOf(userId));
        model.addAttribute("user",user);
        return "/admin/role_set";
    }

    /**
     * 把id为userID的用户设置角色为roleName
     * @param roleName
     * @param userId
     * @return
     */
    @RequestMapping("role_set.json")
    @ResponseBody
    public Result roleSet(@RequestParam("roleName")String roleName,
                          @RequestParam("userId")Integer userId,
                          HttpSession session){
        if (!online.userIsOnline(session)){
            return Result.error("请登录后再来操作哦");
        }
        User user = userService.findById(userId);
        if (user==null){
            return Result.error("该用户不存在");
        }
        //更改用户角色名
        userService.updateRoleName(roleName,String.valueOf(userId));
        return Result.success();
    }
}
