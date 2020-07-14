package com.framework.controller.admin;

import com.framework.entity.ResCategory;
import com.framework.service.ResCategoryService;
import com.framework.utils.Result;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * @auther: 翁筱寒
 * @date: 2020/4/3 11:40
 * @desc: //分类管理
 *
 */
@Controller
@RequestMapping("administrator/category")
public class AdminCategoryController {
    @Resource
    private ResCategoryService categoryService;

    /**
     * 分类列表展示
     * @param model
     * @return
     */
    @RequestMapping("list.action")
    public String list(Model model){
        List<ResCategory> categoryList = categoryService.list();
        model.addAttribute("categoryList",categoryList);
        return "admin/admin_category_list";
    }

    /**
     * 批量更新
     * @param idArr
     * @param sortArr
     * @param nameArr
     * @return
     */
    @RequestMapping("save.json")
    @ResponseBody
    public Result save(@RequestParam("idArr")String[] idArr,
                       @RequestParam("sortArr")String[] sortArr,
                       @RequestParam("nameArr")String[] nameArr){
        categoryService.save(idArr,nameArr,sortArr);
        return Result.success();
    }

    /**
     * 批量删除
     * @param idArr
     * @return
     * @throws Exception
     */
    @RequestMapping("delete.json")
    @ResponseBody
    public Result delete(
            @RequestParam(value = "idArr") String[] idArr) throws Exception {

        categoryService.delete(idArr);

        return Result.success();
    }
}
