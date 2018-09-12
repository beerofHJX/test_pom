package com.qf.oa.controller;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.UUID;

@Controller
@RequestMapping("/img")
public class ImgController {

    @RequestMapping("/upload")
    @ResponseBody
    public String ImgUpload(MultipartFile file){
        InputStream in = null;
        OutputStream os = null;
        String path = "H:/pic"+ "/"+ UUID.randomUUID().toString()+file.getOriginalFilename();
        try {
            in = file.getInputStream();
            os=new FileOutputStream(path);
            IOUtils.copy(in,os);
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            try {
                os.close();
                in.close();
                return "{\"fileuploader\":\"" + path + "\"}";
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    @RequestMapping("/getImg")
    public void getImg(String path, HttpServletResponse response){
            InputStream is = null;
            OutputStream os = null;
        try {
            is = new FileInputStream(path);
            os = response.getOutputStream();
            IOUtils.copy(is,os);
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            if(is != null){
                try {
                    is.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

            if(os != null){
                try {
                    os.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
