package com.qf.oa.controller;

import com.qf.oa.entity.Email;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamSource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.io.InputStream;

@Controller
@RequestMapping("/mail")
public class MailController {

    @Autowired
    private JavaMailSender javaMailSender;

    @RequestMapping("/tomail")
    public String toMailEdit() {
        return "mailedit";
    }

    /**
     * 发送邮件
     * @return
     */
    @RequestMapping("/sendmail")
    public String sendMail(Email email) throws Exception {

        //创建邮件
        MimeMessage mimeMessage = javaMailSender.createMimeMessage();

        //创建一个邮件对象的辅助对象 - Spring
        MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, true);//第二个参数表示是否支持附件
        mimeMessageHelper.setFrom("verygoodwlk@sina.cn");
        mimeMessageHelper.setTo(email.getTo());
        mimeMessageHelper.setSubject(email.getTitle());
        mimeMessageHelper.setText(email.getContent(), true);
        //添加附件
        mimeMessageHelper.addAttachment(email.getFile().getOriginalFilename(), new InputStreamSource() {
            @Override
            public InputStream getInputStream() throws IOException {
                return email.getFile().getInputStream();
            }
        });

        mimeMessage = mimeMessageHelper.getMimeMessage();
        javaMailSender.send(mimeMessage);

        return "redirect:/mail/tomail";
    }

}
