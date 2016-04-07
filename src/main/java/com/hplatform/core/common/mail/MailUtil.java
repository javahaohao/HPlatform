package com.hplatform.core.common.mail;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.BodyPart;
import javax.mail.Flags;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Part;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.mail.search.AndTerm;
import javax.mail.search.FlagTerm;
import javax.mail.search.MessageIDTerm;
import javax.mail.search.SearchTerm;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.util.CollectionUtils;

import cn.org.rapid_framework.util.ObjectUtils;

import com.hplatform.core.common.util.ConstantsUtil;
import com.hplatform.core.common.util.FileUtil;
import com.hplatform.core.common.util.IDUtil;
import com.hplatform.core.common.util.SpringUtils;
import com.hplatform.core.common.util.UserUtil;
import com.hplatform.core.entity.Attachment;
import com.hplatform.core.entity.Mail;
import com.hplatform.core.entity.MailUser;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.AttachmentService;
import com.hplatform.core.service.MailUserService;
import com.sun.mail.imap.IMAPFolder;
import com.sun.mail.imap.IMAPStore;

public class MailUtil {
	private final transient static Log log = LogFactory.getLog(MailUtil.class);
    private StringBuffer bodytext = null;//存放邮件内容   
    private String mailId = "";
    private IMAPStore store = null;
    private IMAPFolder folder = null;
	/**
	*用spring mail 发送邮件,依赖jar：spring.jar，activation.jar，mail.jar 
	*/
    public MailUtil() {
	}
    /**
     * 发送邮件验证码信息
     * @param content
     * @param to
     */
    public static void sendRegisterEMailCheckCode(String content,String to){
    	MailUser mailUser = new MailUser();
    	mailUser.setUser(UserUtil.getAdmin());
    	MailUserService mailUserService = SpringUtils.getBean(MailUserService.class);
    	Mail mail = new Mail();
    	try {
			List<MailUser> mailUserList = mailUserService.findAll(mailUser);
			if(!CollectionUtils.isEmpty(mailUserList)){
				mail.setMailUser(mailUserList.get(0));
			}
		} catch (CRUDException e) {
			log.error("获取平台服务器邮件信息出错！", e);
		}
    	
    	try {
    		mail.setTo(to);
        	mail.setContent(content);
        	mail.setSubject("信息核实");
			sendEMail(mail);
		} catch (Exception e) {
			log.error("发送邮件验证码出错！", e);
		}
    	
    }
	public static void sendEMail(Mail mail) throws MessagingException, CRUDException {
		JavaMailSenderImpl senderImpl = new JavaMailSenderImpl();

		// 设定mail server
		senderImpl.setHost(mail.getMailUser().getMailDict().getSmtp());
		senderImpl.setUsername(mail.getMailUser().getMailAccount());
		senderImpl.setPassword(mail.getMailUser().getMailPassword());
		// 建立HTML邮件消息
		MimeMessage mailMessage = senderImpl.createMimeMessage();
		// true表示开始附件模式
		MimeMessageHelper messageHelper = new MimeMessageHelper(mailMessage, true, "utf-8");

		// 设置收件人，寄件人
		messageHelper.setTo(mail.getTo().split(";"));
		if(StringUtils.isNotBlank(mail.getBc()))
			messageHelper.setBcc(mail.getBc().split(";"));
		if(StringUtils.isNotBlank(mail.getCc()))
			messageHelper.setCc(mail.getCc().split(";"));
		messageHelper.setFrom(mail.getMailUser().getMailAccount());
		messageHelper.setSubject(mail.getSubject());
		// true 表示启动HTML格式的邮件
		messageHelper.setText(mail.getContent(), true);
		if(StringUtils.isNotBlank(mail.getAttachmentIds())){
			List<String> attachmentIdList = Arrays.asList(mail.getAttachmentIds().split(","));
			for(String attachmentId : attachmentIdList){
				Attachment attachment = SpringUtils.getBean(AttachmentService.class).findAttachmentById(attachmentId);
				FileSystemResource attachmentStream = new FileSystemResource(attachment.getFile());
				try {
					//附件名有中文可能出现乱码
					messageHelper.addAttachment(MimeUtility.encodeWord(attachment.getName()), attachmentStream);
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
					throw new MessagingException();
				}
			}
		}
		// 发送邮件
		senderImpl.send(mailMessage);
		System.out.println("邮件发送成功.....");
	}
    /**  
     * 获得发件人的地址和姓名  
     */  
    public String getFrom(MimeMessage mail) throws Exception {   
    	String from = "";
        try {
          String fromStr = mail.getHeader("From", null);
          if ((ObjectUtils.isNotEmpty(fromStr)) && (fromStr.length() > 0)) {
            InternetAddress[] ia = (InternetAddress[])null;
            try {
              ia = InternetAddress.parse(fromStr);
              from = getPerNameMail(ia);
            } catch (Exception e) {
              from = getDecode(fromStr);
            }
          }
        } catch (Exception e) {
          log.error("解析邮件发件人地址错误,错误码（" + e.hashCode() + "）错误（" + e.getMessage() + "）", e);
        }

        return from;
    }   
    private static String getPerNameMail(InternetAddress[] ia)
    {
      String from = "";
      String email = "";
      if (ObjectUtils.isNotEmpty(ia)) {
        for (int j = 0; j < ia.length; j++) {
          String personal = ObjectUtils.isNotEmpty(ia[j])? ia[j].toString() : "";
          email = ObjectUtils.isNotEmpty(ia[j])? ia[j].getAddress() : "";
          personal = getDecode(personal);
          try {
            if (!personal.equals("")) {
              for (int i = 0; i < personal.length(); i++)
              {
                if (personal.charAt(i) == '"')
                {
                  personal = personal.substring(0, i) + personal.substring(i + 1);
                }
                if (personal.charAt(i) != ' ')
                  continue;
                personal = personal.substring(0, i) + personal.substring(i + 1);
              }
            }

            if (personal.equals(email)) {
              personal = "";
              from = from + email;
            } else {
              from = from + personal;
            }if (j < ia.length - 1)
              from = from + ",";
          } catch (Exception e) {
            log.error("邮箱地址解析错误" + e);
          }
        }
      }
      return from;
    }
    private static String getDecode(String _name)
    {
      String rightName = _name;
      String temp = "";
      String codeType = "";
      try {
        if (ObjectUtils.isNotEmpty(_name)) {
          temp = _name.toUpperCase();
          codeType = getMailEncode(temp);

          if (codeType.equals("NOENCODE")) {
            rightName = new String(_name.getBytes("ISO8859_1"), "GBK");;
          }
          else
          {
            if (codeType.equals("DEFALT")) {
              _name = System14.replace(_name, "=??", "=?GBK?");
            }

            rightName = MimeUtility.decodeText(_name);
          }
        }
      } catch (UnsupportedEncodingException e) {
        log.error("UnsupportedEncodingException" + e, e);
      }
      catch (Exception e)
      {
        log.error("Exception" + e, e);
      }

      int iPos = -1;
      iPos = rightName.indexOf("=?");
      temp = rightName;
      if ((!codeType.equalsIgnoreCase("GBK")) && (!codeType.equalsIgnoreCase("UTF-8")) && (!codeType.equalsIgnoreCase("GB2312")) && (!codeType.equalsIgnoreCase("GB18030"))) {
        if (iPos > 0) {
          rightName = rightName.substring(0, iPos);
        }
        rightName = toGbk(rightName, codeType);
      }
      if (iPos > 0) {
        rightName = rightName + getDecode(temp.substring(iPos));
      }
      return rightName;
    }
    private static String getMailEncode(String src) {
        String enType = "NOENCODE";

        int ib = src.indexOf("=?");
        if (ib > -1) {
          int ie = src.indexOf("?", ib + 2);
          if (ie > -1) {
            enType = src.substring(ib + 2, ie);
          }
          if (ib + 2 == ie) {
            enType = "DEFALT";
          }
        }
        return enType;
      }
    protected static String toGbk(String src, String codeType) {
        try {
          if (StringUtils.isBlank(src)) {
            return null;
          }
          return new String(src.getBytes(codeType), "GBK"); } catch (Exception e) {
        }
        return src;
      }
    /**  
     * 获得邮件的收件人，抄送，和密送的地址和姓名，根据所传递的参数的不同 "to"----收件人 "cc"---抄送人地址 "bcc"---密送人地址  
     */  
    public String getMailAddress(MimeMessage mimeMessage,String type) throws Exception {   
        String mailaddr = "";   
        String addtype = type.toUpperCase();   
        InternetAddress[] address = null;   
        if (addtype.equals("TO") || addtype.equals("CC")|| addtype.equals("BCC")) {   
            if (addtype.equals("TO")) {   
                address = (InternetAddress[]) mimeMessage.getRecipients(Message.RecipientType.TO);   
            } else if (addtype.equals("CC")) {   
                address = (InternetAddress[]) mimeMessage.getRecipients(Message.RecipientType.CC);   
            } else {   
                address = (InternetAddress[]) mimeMessage.getRecipients(Message.RecipientType.BCC);   
            }   
            if (ObjectUtils.isNotEmpty(address)) {   
                for (int i = 0; i < address.length; i++) {   
                    String email = address[i].getAddress();   
                    if (StringUtils.isBlank(email))   
                        email = "";   
                    else {   
                        email = MimeUtility.decodeText(email);   
                    }   
                    String personal = address[i].getPersonal();   
                    if (StringUtils.isBlank(personal))   
                        personal = "";   
                    else {   
                        personal = MimeUtility.decodeText(personal);   
                    }   
                    String compositeto = personal + "(" + email + ")";   
                    mailaddr += "," + compositeto;   
                }   
                mailaddr = mailaddr.substring(1);   
            }   
        } else {   
            throw new Exception("Error emailaddr type!");   
        }   
        return mailaddr;   
    }   
  
    /**  
     * 获得邮件主题  
     */  
    public String getSubject(MimeMessage mimeMessage) throws MessagingException {   
        String subject = "";   
        try {   
            subject = MimeUtility.decodeText(mimeMessage.getSubject());   
            if (StringUtils.isBlank(subject))   
                subject = "";   
        } catch (Exception exce) {}   
        return subject;   
    }   
  
    /**  
     * 获得邮件发送日期  
     */  
    public Date getSentDate(MimeMessage mimeMessage) throws Exception {   
    	return mimeMessage.getSentDate();   
    }   
  
    /**  
     * 获得邮件正文内容  
     */  
    public String getBodyText() {   
        return bodytext.toString();   
    }   
  
    /**  
     * 解析邮件，把得到的邮件内容保存到一个StringBuffer对象中，解析邮件 主要是根据MimeType类型的不同执行不同的操作，一步一步的解析  
     */  
    public void getMailContent(Part part,Boolean flag) throws Exception {  
		String contentType=part.getContentType();
		int nameindex = contentType.indexOf("name");
		boolean conname = false;
		if (nameindex != -1)
		conname = true;
		if (part.isMimeType("text/plain") && !conname) {
			if(ObjectUtils.isEmpty(flag) || !flag)
				bodytext.append((String) part.getContent());
		} else if (part.isMimeType("text/html") && !conname) {
			bodytext.append(String.valueOf(part.getContent()));
		} 
		else if (part.isMimeType("multipart/*")) {
			Multipart multipart = (Multipart) part.getContent();
			int counts = multipart.getCount();
			for (int i = 0; i < counts; i++) {
				getMailContent(multipart.getBodyPart(i),counts>1);
			}
		}else if (part.isMimeType("message/rfc822")) {
			getMailContent((Part) part.getContent(),null);
		}else {
		}
	}
  
    /**   
     * 判断此邮件是否需要回执，如果需要回执返回"true",否则返回"false"  
     */   
    public boolean getReplySign(MimeMessage mimeMessage) throws MessagingException {   
        boolean replysign = false;   
        String needreply[] = mimeMessage   
                .getHeader("Disposition-Notification-To");   
        if (ObjectUtils.isNotEmpty(needreply)) {   
            replysign = true;   
        }   
        return replysign;   
    }   
  
    /**  
     * 获得此邮件的Message-ID  
     */  
    public String getMessageId(MimeMessage mimeMessage) throws MessagingException {   
        return mimeMessage.getMessageID();   
    }   
  
    /**  
     * 【判断此邮件是否已读，如果未读返回返回false,反之返回true】  
     */  
    public boolean isNew(MimeMessage mimeMessage) throws MessagingException {   
        Flags flags = ((Message) mimeMessage).getFlags();   
        if (flags.contains(Flags.Flag.SEEN)){
        	return true;
        }else{
        	return false;
        }
    }   
  
    /**  
     * 判断此邮件是否包含附件  
     */  
    public boolean isContainAttach(Part part) throws Exception {   
        boolean attachflag = false;   
        if (part.isMimeType("multipart/*")) {   
            Multipart mp = (Multipart) part.getContent();   
            for (int i = 0; i < mp.getCount(); i++) {   
                BodyPart mpart = mp.getBodyPart(i);   
                String disposition = mpart.getDisposition();   
                if ((ObjectUtils.isNotEmpty(disposition))   
                        && ((disposition.equals(Part.ATTACHMENT)) || (disposition   
                                .equals(Part.INLINE))))   
                    attachflag = true;   
                else if (mpart.isMimeType("multipart/*")) {   
                    attachflag = isContainAttach((Part) mpart);   
                } else {   
                    String contype = mpart.getContentType();   
                    if (contype.toLowerCase().indexOf("application") != -1)   
                        attachflag = true;   
                    if (contype.toLowerCase().indexOf("name") != -1)   
                        attachflag = true;   
                }   
            }   
        } else if (part.isMimeType("message/rfc822")) {   
            attachflag = isContainAttach((Part) part.getContent());   
        }   
        return attachflag;   
    }   
  
    /**   
     * 【保存附件】   
     */   
    public void saveAttachMent(Part part) throws Exception {   
        String fileName = "";   
        if (part.isMimeType("multipart/*")) {   
            Multipart mp = (Multipart) part.getContent();   
            for (int i = 0; i < mp.getCount(); i++) {   
                BodyPart mpart = mp.getBodyPart(i);   
                String disposition = mpart.getDisposition();   
                if ((ObjectUtils.isNotEmpty(disposition))   
                        && ((disposition.equals(Part.ATTACHMENT)) || (disposition   
                                .equals(Part.INLINE)))) {   
                    fileName = mpart.getFileName();   
                    if(StringUtils.isNotBlank(fileName)){
                    	if (fileName.toLowerCase().indexOf("gb2312") != -1) {   
                            fileName = MimeUtility.decodeText(fileName);   
                        }   
                        FileUtil.saveFile(fileName, mailId,mpart.getInputStream());   
                    }
                } else if (mpart.isMimeType("multipart/*")) {   
                    saveAttachMent(mpart);   
                } else {   
                    fileName = mpart.getFileName();   
                    if ((ObjectUtils.isNotEmpty(fileName))   
                            && (fileName.toLowerCase().indexOf("GB2312") != -1)) {   
                        fileName = MimeUtility.decodeText(fileName);   
                        FileUtil.saveFile(fileName,mailId,mpart.getInputStream());   
                    }   
                }   
            }   
        } else if (part.isMimeType("message/rfc822")) {   
            saveAttachMent((Part) part.getContent());   
        }   
    }   
    public void closeFolder()throws Exception{
    	if(ObjectUtils.isNotEmpty(folder))
        	folder.close(true);
        if(ObjectUtils.isNotEmpty(store))
        	store.close();
    }
	public void deleteServerMail(MailUser mailUser,String messageId)throws Exception{
    	folder = getMessageFolder(mailUser);
    	folder.open(Folder.READ_WRITE); 
    	SearchTerm[] searchTermArray = new SearchTerm[]{new MessageIDTerm(messageId)};
    	SearchTerm st = new AndTerm(searchTermArray);
    	Message [] messagesArray = folder.search(st);  
    	for(Message message : messagesArray){
    		message.setFlag(Flags.Flag.DELETED, true);  
    	}
    	closeFolder();
    }
    public IMAPFolder getMessageFolder(MailUser mailUser)throws Exception{
//    	Properties props = System.getProperties();  
//      props.put("mail.smtp.host", mailUser.getMailDict().getSmtp());  
//      props.put("mail.smtp.auth", "true");  
//      props.setProperty("mail.pop3.disabletop", "true");
//      Session session = Session.getDefaultInstance(props, null);  
//      session.setDebug(false);
//      URLName urln = new URLName("pop3",mailUser.getMailDict().getPop3(), Integer.valueOf(mailUser.getMailDict().getPop3Port()), null,  
//      		mailUser.getMailAccount(), mailUser.getMailPassword());  
//      Store store = session.getStore(urln);  
//      store.connect();  
//      Folder folder = store.getFolder("INBOX");  

      Properties prop = System.getProperties();  
      prop.setProperty("mail.store.protocol", "imap");  //指定邮件接收协议 
      prop.setProperty("mail.imap.host", mailUser.getMailDict().getImap());  
      prop.setProperty("mail.imap.port", String.valueOf(mailUser.getMailDict().getImapPort())); 
//      prop.setProperty("mail.imap.socketFactory.class","javax.net.ssl.SSLSocketFactory");
//      prop.setProperty("mail.imap.socketFactory.fallback","false");
//      prop.setProperty("mail.imap.ssl.enable", "true");
//      prop.setProperty("mail.imap.auth.login.disable", "true");  
      
//      prop.setProperty("mail.store.protocol", "pop3");// 协议 
//      prop.setProperty("mail.pop3.port", String.valueOf(mailUser.getMailDict().getPop3Port()));// 端口 
//      prop.setProperty("mail.pop3.host", mailUser.getMailDict().getPop3());// pop3服务器
      
      Session session = Session.getInstance(prop);  
      session.setDebug(true);
      store = (IMAPStore) session.getStore("imap"); // 使用imap会话机制，连接服务器  
      store.connect(mailUser.getMailAccount(), mailUser.getMailPassword());  
      return (IMAPFolder) store.getFolder("INBOX"); // 收件箱  
    }
    /**获取未读邮件
     */
    public Message[] getSeenMessage(MailUser mailUser)throws Exception{
    	folder = getMessageFolder(mailUser);
    	folder.open(Folder.READ_WRITE);  
        // 获取总邮件数  
        System.out.println("-----------------共有邮件：" + folder.getMessageCount()  
                + " 封--------------");  
        // 得到收件箱文件夹信息，获取邮件列表  
        System.out.println("未读邮件数：" + folder.getUnreadMessageCount());  
        Flags searchFlag=new Flags(Flags.Flag.SEEN); 
        FlagTerm term=new FlagTerm(searchFlag,false); 
        return folder.search(term);
    }
    /**
     * 获取所有接收到的邮件
     * @param mailUser
     * @return
     * @throws Exception
     */
    public Message[] getAllMessage(MailUser mailUser)throws Exception{
    	folder = getMessageFolder(mailUser);
    	folder.open(Folder.READ_WRITE);  
        // 获取总邮件数  
        System.out.println("-----------------共有邮件：" + folder.getMessageCount()  
                + " 封--------------");  
        // 得到收件箱文件夹信息，获取邮件列表  
        System.out.println("未读邮件数：" + folder.getUnreadMessageCount());  
        Message[] messageArray = folder.getMessages();
        String messageId = null;
        List<Message> messageList = new ArrayList<Message>();
        //TODO 此处需要实现获取用户需要接受的邮件信息
//        List<String> messageIdList = SpringUtils.getBean(MailService.class).findReceivedMessageIds(mailUser);
        List<String> messageIdList = null;
        for(Message message : messageArray){
        	MimeMessage mimeMessage = (MimeMessage) message;
        	messageId = getMessageId(mimeMessage);
        	if(!messageIdList.contains(messageId))
        		messageList.add(message);
        }
        return messageList.toArray(new Message[messageList.size()]);
    }
	public List<Mail> getUserMails(MailUser mailUser)throws Exception{
    	List<Mail> mailList = new ArrayList<Mail>();
        
        Message messageArray[] = getAllMessage(mailUser);  
        Mail receiveMail = null;
        String messageId = "";
        
        for (int i = 0; i < messageArray.length; i++) {
        	Message message = messageArray[i];
        	MimeMessage mimeMessage = (MimeMessage) message;
        	messageId = getMessageId(mimeMessage);
        	
        	bodytext = new StringBuffer();
        	receiveMail = new Mail();
        	mailId = IDUtil.createUUID();
        	receiveMail.setId(mailId);
        	receiveMail.setSubject(getSubject(mimeMessage));
        	receiveMail.setSentdate(getSentDate(mimeMessage));
        	receiveMail.setReplysign(getReplySign(mimeMessage)?ConstantsUtil.get().TRUE:ConstantsUtil.get().FALSE);
        	receiveMail.setHasRead(isNew(mimeMessage)?ConstantsUtil.get().TRUE:ConstantsUtil.get().FALSE);
        	receiveMail.setContainAttachment(isContainAttach((Part) message)?ConstantsUtil.get().TRUE:ConstantsUtil.get().FALSE);
        	receiveMail.setForm(getFrom((MimeMessage) message));
        	receiveMail.setTo(getMailAddress(mimeMessage,"to"));
        	receiveMail.setCc(getMailAddress(mimeMessage,"cc"));
        	receiveMail.setBc(getMailAddress(mimeMessage,"bcc"));
        	receiveMail.setMessageid(messageId);
        	getMailContent((Part) message,null);
        	receiveMail.setContent(getBodyText());
            saveAttachMent((Part) message);   
        	mailList.add(receiveMail);
        	if(!ConstantsUtil.get().TRUE.equals(mailUser.getBackupFlag()))
        		message.setFlag(Flags.Flag.DELETED, true);
        }
        closeFolder();
    	return mailList;
    }
}
