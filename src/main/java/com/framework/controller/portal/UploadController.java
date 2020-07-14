package com.framework.controller.portal;

import com.framework.utils.Result;
import com.google.gson.Gson;
import com.qiniu.common.QiniuException;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.UploadManager;
import com.qiniu.storage.model.DefaultPutRet;
import com.qiniu.util.Auth;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/18 22:13
 * @desc: //上传文件
 */
@Controller
public class UploadController {
   /**
           * 上传文件到七牛云
 * @throws IOException
 */
    @RequestMapping("upload.json")
    @ResponseBody
    public Result upload(MultipartFile file) throws IOException {

        /**
         * 构造一个带指定Zone对象的配置类
         * 华东 : Zone.zone0()
         * 华北 : Zone.zone1()
         * 华南 : Zone.zone2()
         * 北美 : Zone.zoneNa0()
         */
        Configuration cfg = new Configuration(Zone.zone2());
        // ...其他参数参考类注释
        UploadManager uploadManager = new UploadManager(cfg);
        // ...生成上传凭证，然后准备上传
        String accessKey = "j9BDuCLIbWUg8JkOrRPcHiHdFa55T3z0K-Q3pAgN";
        String secretKey = "WOBs6POr5Mpe0gqZzHtlrKae88tEsTy5_zZAL-sP";
        String bucket = "yuanyuanandduxiaoyue";
        // 默认不指定key的情况下，以文件内容的hash值作为文件名
        String key = null;

        String imgUrl = "";
        try {
            // 数据流上传
            InputStream byteInputStream = file.getInputStream();
            Auth auth = Auth.create(accessKey, secretKey);
            String upToken = auth.uploadToken(bucket);
            try {
                Response response = uploadManager.put(byteInputStream, key, upToken, null, null);
                // 解析上传成功的结果
                DefaultPutRet putRet = new Gson().fromJson(response.bodyString(), DefaultPutRet.class);
                System.out.println(putRet.key);
                System.out.println(putRet.hash);
                imgUrl = putRet.hash;
            } catch (QiniuException ex) {
                Response r = ex.response;
                System.err.println(r.toString());
                try {
                    System.err.println(r.bodyString());
                } catch (QiniuException ex2) {
                    // ignore
                }
            }
        } catch (UnsupportedEncodingException ex) {
            // ignore
        }
//        imgURL默认只是图片名  如abc.jpg,所以加上存储空间的地址
        return Result.success().add("imgUrl", "http://duxiaoyue.top/"+imgUrl);
    }

}
