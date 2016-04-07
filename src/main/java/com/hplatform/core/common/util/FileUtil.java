package com.hplatform.core.common.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.math.BigInteger;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.channels.FileChannel;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import javax.activation.MimetypesFileTypeMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.util.CollectionUtils;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import cn.org.rapid_framework.util.ObjectUtils;

import com.hplatform.core.entity.Attachment;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.AttachmentService;
import com.hplatform.core.service.DictService;

public class FileUtil {
    private static final transient Log log = LogFactory.getLog(FileUtil.class);
    private static WebUploader webuploader;
    public synchronized static WebUploader getWebUploader(){
    	if(ObjectUtils.isEmpty(webuploader))
    		return webuploader = new FileUtil().new WebUploader();
    	else
    		return webuploader;
    }
	/**
	 * 如果指定路径不存在，则创建
	 * @param path
	 */
	public static void fileIsExists(String path){
		File file = new File(path);
		if(!file.exists()){
			file.mkdirs();
		}
	}
	private static List<File> fileList = new ArrayList<File>();
	/**
	 * 读取txt文件，返回读取之后的内容
	 * @param path
	 * @return
	 */
	public static List<String> readTxt(String path){
		List<String> result = new ArrayList<String>();
		BufferedReader bufferedReader =null;
		try {
			bufferedReader = new BufferedReader(new InputStreamReader(new FileInputStream(path),"UTF-8"));
			String lineTxt = null;
			while(ObjectUtils.isNotEmpty((lineTxt = bufferedReader.readLine()))){
				result.add(lineTxt);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally{
			try {
				bufferedReader.close();
			} catch (IOException e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	/**
	 * 将内容输出到文件
	 * @param path
	 * @param value
	 * @throws FileNotFoundException 
	 * @throws UnsupportedEncodingException 
	 */
	public static void printTxtToFile(String path,String value) throws Exception{
		File file = new File(path);
		if(!file.getParentFile().exists()){
			file.getParentFile().mkdirs();
		}
        Writer writer = new OutputStreamWriter(new FileOutputStream(file, false), "UTF-8");
        writer.write(value);
        writer.close();
	}
	/**
     * 获取工程路径
     * @return
     */
    public static String getProjectPath(){
		String projectPath = "";
		try {
			File file = new DefaultResourceLoader().getResource("").getFile();
			if (file != null){
				while(true){
					File f = new File(org.apache.commons.lang3.StringUtils.join(new Object[]{file.getPath() , File.separator , "src" , File.separator , "main"}));
					if (f == null || f.exists()){
						break;
					}
					if (file.getParentFile() != null){
						file = file.getParentFile();
					}else{
						break;
					}
				}
				projectPath = file.toString();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return projectPath;
    }
	
	/**
	 * 删除指定路径下面所有文件
	 * @param path
	 * @throws Exception
	 */
	public static void deleteFileByFolder(String path) throws Exception{
		File file = new File(path);
		deleteFileUtil(file);
		for(int i = fileList.size()-1 ; i >=0 ; i--){
			fileList.get(i).delete();
		}
	}
	/**
	 * 删除指定文件
	 * @param path
	 * @throws Exception
	 */
	public static void deleteFileByPath(String path) throws Exception{
		File file = new File(path);
		file.delete();
	}
	/**
	 * 删除文件辅助方法
	 * @param file
	 * @throws Exception
	 */
	private static void deleteFileUtil(File file)throws Exception{
		File[] childFile = file.listFiles();
		fileList.addAll(Arrays.asList(childFile));
		for(File f : childFile){
			if(f.isDirectory())
				deleteFileUtil(f);
		}
	}
	
	static BufferedInputStream bis = null;
	static BufferedOutputStream bos = null;
	/**
	 * 复制指定路径的路径文件到指定路径
	 * @param sourcePath
	 * @param toPath
	 * @return
	 */
	public static boolean copyFileToPath(String sourcePath,String toPath,String fileName){
		File inputFile  =  new File(sourcePath);
		File outPath = new File(toPath);
		File outFile  =  new File(toPath+fileName);
		if(!outPath.getParentFile().exists())
			outPath.getParentFile().mkdirs();
		byte[] b = new byte[1024];
		int len;
		try {
			bis = new BufferedInputStream(new FileInputStream(inputFile));
			bos = new BufferedOutputStream(new FileOutputStream(outFile));
			while((len = bis.read(b))!=-1){
				bos.write(b,0,len);
			}
			System.out.println("复制完成"+fileName+"！");
		} catch (FileNotFoundException e) {
			System.out.println("文件未找到！请确定文件路径正确！");
			return false;
		} catch (IOException e) {
			System.out.println("复制文件失败！");
			return false;
		}
		finally{
			closeAll();
		}
		return true;
	}
	/**
	 * 关闭输入输出流
	 */
	private static void closeAll(){
		try {
			if(ObjectUtils.isNotEmpty(bis)&&ObjectUtils.isNotEmpty(bos)){
				bis.close();
				bos.close();
			}
		} catch (IOException e) {
			System.out.println("文件流关闭失败！");
		}
	}
	public static final String NETWORK="network";
	public static final String CLASSPATH="classpath";
	/**
	 * 读取properties文件
	 * @param path读取路径
	 * @param readType读取方式：NETWORK是通过http://..方式读取，LOCAL是通过本地读取
	 * @param readKey要获得指定key对应的值
	 * @param defaultValue如果key对应的值不存在获取的默认值
	 * @return
	 */
	public static String readProperties(String path,String readType,String readKey,String defaultValue){
		Properties properties = readPropertiesUtil(path, readType);
		String result = properties.getProperty(readKey, defaultValue);
		return result;
	}
	/**
	 * 获取properties中的key-->value的对应值都取出来
	 * @param path
	 * @param readType
	 * @return
	 */
	public static Map<String, String> getPropertiesKeyValue(String path,String readType){
		Properties properties = readPropertiesUtil(path, readType);
		@SuppressWarnings("rawtypes")
		Enumeration propNames = properties.propertyNames();
		Map<String, String> keyValue = new HashMap<String, String>();
		while (propNames.hasMoreElements()) {
			String key = (String) propNames.nextElement();
			String value = properties.getProperty(key);
			keyValue.put(key, value);
		}
		return keyValue;
	}
	/**
	 * 读取properties辅助类
	 * @param path
	 * @param readType
	 * @return
	 */
	public static Properties readPropertiesUtil(String path,String readType){
		Properties properties = new Properties();
		try {
			if(NETWORK.equals(readType)){
				URL url = new URL(path);
				properties.load(url.openStream());
			}else if(CLASSPATH.equals(readType)){
				InputStream in = Thread.currentThread().getContextClassLoader().getResourceAsStream(path);
				properties.load(in);
			}else{
				properties.load(new FileInputStream(new File(path)));
			}
		} catch (FileNotFoundException e) {
			System.out.println("文件未找到！---------"+e);
		} catch (IOException e) {
			System.out.println("文件读取异常！---------"+e);
		}
		return properties;
	}
	/**
	 * 根据输入输出流进行输出
	 * @param in
	 * @param out
	 */
	public static void directOutput(Attachment attachment, OutputStream out){
		InputStream in = null;
		try {
			File file = attachment.getFile();
			if(!file.exists())
				return;
			in =  new FileInputStream(file);
			int count = 0;
			byte[] temp = new byte[8192];
			while (count >= 0) {
			  count = in.read(temp);
			  if (count > 0)
			    out.write(temp, 0, count);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			IOUtils.closeQuietly(in);
			IOUtils.closeQuietly(out);
		}
	}
	/**  
     * 【保存文件到系统文件路径目录里】  
     */  
    public static void saveFile(String fileName,String superId, InputStream in) throws Exception { 
    	//获取文件的后缀   
        String suffix = fileName.substring(fileName.lastIndexOf("."));
        String id = IDUtil.createUUID();
        String realName = id+suffix;
        
        File storefile = new File(datePathUtil().append(realName).toString());  
        BufferedOutputStream bos = null;  
        BufferedInputStream bis = null;  
        try {  
            bos = new BufferedOutputStream(new FileOutputStream(storefile));  
            bis = new BufferedInputStream(in);  
            int c;  
            while ((c = bis.read()) != -1) {  
                bos.write(c);  
                bos.flush();  
            }
            Attachment attachment = new Attachment();
            attachment.setId(id);
            attachment.setName(fileName);
            attachment.setTitle(fileName);
            attachment.setSuperId(superId);
            attachment.setCreateDate(new Date());
            attachment.setUpdateDate(new Date());
            attachment.setRealName(realName);
            attachment.setExt(suffix);
            attachment.setPath(StringUtils.cleanPath(storefile.getParent())+File.separator);
            attachment.setSize(storefile.length());
            attachment.setType( new MimetypesFileTypeMap().getContentType(storefile));
            saveAttachmentData(attachment);
        } catch (Exception exception) {  
            throw new Exception("文件保存失败!"+exception.getMessage());  
        } finally {  
            bos.close();  
            bis.close();  
        }  
    }
	/**
	 * 计算文件的MD5值
	 * @param file
	 * @return
	 */
	public static String getFileMD5(File file) {
	    if (!file.isFile()) {
	        return null; 
	    } 
	    MessageDigest digest = null; 
	    FileInputStream in = null; 
	    byte buffer[] = new byte[8192]; 
	    int len; 
	    try { 
	        digest =MessageDigest.getInstance("MD5"); 
	        in = new FileInputStream(file); 
	        while ((len = in.read(buffer)) != -1) { 
	            digest.update(buffer, 0, len); 
	        } 
	        BigInteger bigInt = new BigInteger(1, digest.digest()); 
	        return bigInt.toString(16); 
	    } catch (Exception e) { 
	        e.printStackTrace(); 
	        return null; 
	    } finally { 
	        try { 
	            in.close(); 
	        } catch (Exception e) { 
	            e.printStackTrace(); 
	        } 
	    } 
	}
	/**
	 *  计算文件的 SHA-1 值 
	 * @param file
	 * @return
	 */
	public static String getFileSha1(File file) { 
	    if (!file.isFile()) { 
	        return null; 
	    } 
	    MessageDigest digest = null; 
	    FileInputStream in = null; 
	    byte buffer[] = new byte[8192]; 
	    int len; 
	    try { 
	        digest =MessageDigest.getInstance("SHA-1"); 
	        in = new FileInputStream(file); 
	        while ((len = in.read(buffer)) != -1) { 
	            digest.update(buffer, 0, len); 
	        } 
	        BigInteger bigInt = new BigInteger(1, digest.digest()); 
	        return bigInt.toString(16); 
	    } catch (Exception e) { 
	        e.printStackTrace(); 
	        return null; 
	    } finally { 
	        try { 
	            in.close(); 
	        } catch (Exception e) { 
	            e.printStackTrace(); 
	        } 
	    } 
	}
	/**
	 * 按照文件全路径下载文件
	 * @param fullPath
	 * @return
	 * @throws Exception
	 */
	public static boolean download(String fullPath)throws Exception{
		if(org.apache.commons.lang3.StringUtils.isNotBlank(fullPath)){
			File file = new File(fullPath);
			return download(fullPath, file.getName());
		}
		return false;
	}
	/**
	 * 按照文件的完整路径进行文件下载
	 * @param path
	 * @return
	 * @throws Exception
	 */
	public static boolean download(Attachment attachment)throws Exception{
		if(ObjectUtils.isNotEmpty(attachment)){
			return download(attachment.getFileFullPath(), attachment.getName());
		}
		return false;
	}
	/**
	 * 下载文件
	 * @param path
	 * @param multipartFile
	 * @return
	 * @throws Exception
	 */
	public static boolean download(String path,String name) throws Exception{
		boolean success = true;
		String fileName = URLEncoder.encode(name, "UTF-8");  
		File file = new File(path);
		// 下载起始位置
		int start = 0;
		// 下载结束位置
		int end = 0;
		int len = 0;

		HttpServletResponse response = UserUtil.getCurrentPrincipal().getResponse();
		HttpServletRequest request = UserUtil.getCurrentRequest();
		// 获取浏览器类型
		String browser = request.getHeader("user-agent");
		// 设置响应头，206支持断点续传
		int http_status = 206;
		if (browser.contains("MSIE"))
			http_status = 200;// 200 响应头，不支持断点续传

		response.setStatus(http_status);
		
		// 获取Range，下载范围
		String range = request.getHeader("Range");
		// 第一次请求不含有range
		if (range != null) {
			// 剖解range
			range = range.split("=")[1];
			String[] rs = range.split("-");
			if (rs.length > 1) {
				start = Integer.parseInt(rs[0]);
				end = Integer.parseInt(rs[1]);
				len = end - start + 1;
				// 设置响应头
				response.setHeader("Accept-Ranges", "bytes");
				response.setHeader("Content-Range", "bytes= " + start + "-" + end + "/" + file.length());
			} else {
				start = 0;
				end = (int)file.length() - 1;
				len = (int)file.length();
			}
		} else {// 不含有range的 设置初始化位0-100
			start = 0;
			end = (int)file.length() - 1;
			len = (int)file.length();
		}
				
		// 响应头
		response.setContentType("application/octet-stream;");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");  
	    response.setHeader("Content-Length", String.valueOf(file.length())); 
	    response.setContentType("application/octet-stream;charset=UTF-8");
		OutputStream os = response.getOutputStream();
		try {
			// 建立文件输入流
	        InputStream inputStream = new BufferedInputStream(new FileInputStream(path));
			 // 建立文件输出流
	        OutputStream outputStream = new BufferedOutputStream(os);
	        byte[] buffer = new byte[1024];
	        inputStream.skip(start);
	        inputStream.mark(buffer.length);
	        while ((len = inputStream.read(buffer)) > 0) {
	        	outputStream.write(buffer, 0, len);
	        }
	        outputStream.flush();
	        outputStream.close();
	        inputStream.close();
		} catch (Exception e) {
			success = false;
			e.printStackTrace();
		}   
		return success;
	}
	/**
	 * 上传分片文件
	 * @param attachment
	 * @param multipartFile
	 * @return
	 * @throws Exception
	 */
	public static void uploadChunk(Attachment attachment,MultipartFile multipartFile){
        try {
			multipartFile.transferTo(getWebUploader().getReadySpace(attachment, getFileTempFolder()));
		} catch (Exception e) {
			e.printStackTrace();
		}   

//        if(!(result instanceof Attachment)){
//        	PropertyUtils.setProperty(result,"id",attachment.getId());
//        	PropertyUtils.setProperty(result,"attachment",attachment);
//        }else{
//        	result = attachment;
//        }
	}
	/**
     * MD5签名
     * @param content   要签名的内容
     * @return
     */
	public static String md5(String content){
        StringBuffer sb = new StringBuffer();
        try{
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            md5.update(content.getBytes("UTF-8"));
            byte[] tmpFolder = md5.digest();

            for(int i = 0; i < tmpFolder.length; i++){
                sb.append(Integer.toString((tmpFolder[i] & 0xff) + 0x100, 16).substring(1));
            }

            return sb.toString();
        }catch(NoSuchAlgorithmException ex){
            log.error("无法生成文件的MD5签名", ex);
            return null;
        }catch(UnsupportedEncodingException ex){
            log.error("无法生成文件的MD5签名", ex);
            return null;
        }
    }
	/**
	 * 验证文件是否在服务器上已经存在
	 * @param md5
	 * @return
	 */
	public static Attachment md5Check(String md5){
		Attachment attachment = new Attachment();
		attachment.setMd5(md5);
		List<Attachment> attachements = null;
		try {
			attachements = SpringUtils.getBean(AttachmentService.class).findAll(attachment);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(!CollectionUtils.isEmpty(attachements)){
			return attachements.get(0);
		}else{
			return null;
		}
	}
	/**
	 * 分解multipartFile文件属性拼装Attachment
	 * @param multipartFile
	 * @return 返回拼装好的文件
	 */
	public static Attachment resolveAttachment(Attachment attachment,MultipartFile multipartFile){
		attachment.setName(multipartFile.getOriginalFilename());
		attachment.setSize(multipartFile.getSize());
		attachment.setType(multipartFile.getContentType());
		return resolve(attachment);
	}
	/**
	 * 生成attachment对象
	 * @param originalFileName
	 * @param size
	 * @param type
	 * String originalFileName,long size,String type,String md5
	 * @return
	 */
	public static Attachment resolve(Attachment param){
		String id = IDUtil.createUUID();
		//获取文件的后缀   
        String suffix = param.getName().substring(param.getName().lastIndexOf(".")+1);
        Attachment attachment = new Attachment();
        attachment.setId(id);
        attachment.setName(param.getName());
        attachment.setTitle(param.getName());
        attachment.setSuperId(param.getSuperId());
        attachment.setCreateUser(UserUtil.getCurrentUserId());
        attachment.setCreateDate(new Date());
        attachment.setRealName(String.format("%s.%s", new Object[]{id,suffix}));
        attachment.setExt(suffix);
        attachment.setPath(StringUtils.cleanPath(FileUtil.datePathUtil().toString()));
        attachment.setSize(param.getSize());
        attachment.setType(param.getType());
        attachment.setMd5(param.getMd5());
        attachment.setLastModifiedDate(param.getLastModifiedDate());
        return attachment;
	}
	/**
	 * 按照默认值上传文件
	 * @return
	 * @throws CRUDException
	 */
	public static String upload() throws CRUDException{
		return upload("file", datePathUtil().toString());
	}
	/**
	 * 按照inputName上传文件
	 * @param inputName
	 * @return
	 * @throws CRUDException
	 */
	public static String upload(String inputName) throws CRUDException{
		return upload(inputName, datePathUtil().toString());
	}
	/**此方法在此系统未测试成功
	 * @param request
	 * @throws IOException
	 * 上传文件
	 * Author:pangwx
	 */
	public static String upload(String inputName,String fileuploadPath) throws CRUDException {
		String realFileName = "";
		try {
			HttpServletRequest request = UserUtil.getCurrentRequest();
			// 转型为MultipartHttpRequest
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			// 根据前台的name名称得到上传的文件
			MultipartFile file = multipartRequest.getFile(inputName);
			// 获得文件名:
			realFileName = file.getOriginalFilename();
			// 创建文件 
			File dirPath = new File(fileuploadPath);
			if (!dirPath.exists()) {
				dirPath.mkdir();
			}
			File uploadFile = new File(fileuploadPath + realFileName);
			FileCopyUtils.copy(file.getBytes(), uploadFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return realFileName;
	}
	/**
	 * 按照MultipartFile上传文件
	 * @param file
	 * @return
	 * @throws CRUDException
	 */
	public static Attachment upload(Attachment attachment,MultipartFile multipartFile) throws CRUDException {
		attachment = resolveAttachment(attachment,multipartFile);
		try {
			File uploadFile = new File(attachment.getFileFullPath());
			multipartFile.transferTo(uploadFile);
			saveAttachmentData(attachment);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return attachment;
	}
	/**
	 * 按照时间获取上传文件路径
	 * @param pathBuffer
	 */
	public static StringBuffer datePathUtil(){
		//拼成完整的文件保存路径加文件    
		//TODO	此处需要加载系统上出路径参数
        StringBuffer pathBuffer = null;
		try {
			pathBuffer = new StringBuffer(SpringUtils.getBean(DictService.class).findOne(ConstantsUtil.get().DICT_UPLOAD_ID).getValue());
		} catch (BeansException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CRUDException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        pathBuffer.append(File.separator);
		Calendar cal=Calendar.getInstance();
        pathBuffer.append(cal.get(Calendar.YEAR));
        pathBuffer.append(File.separator);
        pathBuffer.append(cal.get(Calendar.MONTH)+1);
        pathBuffer.append(File.separator);
        pathBuffer.append(cal.get(Calendar.DAY_OF_MONTH));
        pathBuffer.append(File.separator);
        File file = new File(pathBuffer.toString());
        if(!file.exists())
        	file.mkdirs();
        return pathBuffer;
	}
	/**
	 * 获取文件缓存分片文件存储路径
	 * @return
	 */
	public static String getFileTempFolder(){
		return "d:/uploads/";
	}
	/**
     * 讲文件信息保存数据库
     * @param attachment
     * @throws CRUDException
     */
    public static void saveAttachmentData(Attachment attachment) throws CRUDException{
    	SpringUtils.getBean(AttachmentService.class).saveAttachment(attachment);
    }
    
    public class WebUploader{
    	/**
         * 错误详情
         */
        private String msg;
    	private final Logger log = LoggerFactory.getLogger(WebUploader.class);
    	/**
         * 分片验证
         * 验证对应分片文件是否存在，大小是否吻合
         * @param file  分片文件的路径
         * @param size  分片文件的大小
         * @return
         */
        public boolean chunkCheck(Attachment attachment){
            //检查目标分片是否存在且完整
            File target = new File(getFileTempFolder()+getMd5TempFileName(attachment)+ "/" + attachment.getChunkIndex());
            if(target.isFile() && attachment.getChunkSize() == target.length()){
                return true;
            }else{
                return false;
            }
        }

        /**
         * 分片合并操作
         * 要点:
         *  > 合并: NIO
         *  > 并发锁: 避免多线程同时触发合并操作
         *  > 清理: 合并清理不再需要的分片文件、文件夹、tmp文件
         * @param folder    分片文件所在的文件夹名称
         * @param ext       合并后的文件后缀名
         * @param chunks    分片总数
         * @param md5       文件签名
         * @param path      合并后的文件所存储的位置
         * String folder, String ext, int chunks, String md5,String type, String path
         * @return
         */
        public Attachment chunksMerge(Attachment attachment){

            //合并后的目标文件
            Attachment target;
            String tempFileName = getMd5TempFileName(attachment);
            //检查是否满足合并条件：分片数量是否足够
            if(attachment.getChunks() == this.getChunksNum(getFileTempFolder() + "/" + tempFileName)){

                //同步指定合并的对象
                Lock lock = FileLock.getLock(tempFileName);
                lock.lock();
                try{
                    //检查是否满足合并条件：分片数量是否足够
                    //File[] files = this.getChunks(path + "/" +folder);
                    List<File> files = new ArrayList<File>(Arrays.asList(this.getChunks(getFileTempFolder() + "/" +tempFileName)));
                    if(attachment.getChunks() == files.size()){

                        //按照名称排序文件，这里分片都是按照数字命名的
                        Collections.sort(files, new Comparator<File>() {
                            @Override
                            public int compare(File o1, File o2) {
                                if(Integer.valueOf(o1.getName()) < Integer.valueOf(o2.getName())){
                                    return -1;
                                }
                                return 1;
                            }
                        });

                        //创建合并后的文件
                        Attachment saveAttachment = resolve(attachment);
                        File outputFile = new File(saveAttachment.getFileFullPath());
                        if(outputFile.exists()){
                            log.error("文件[" + tempFileName + "]随机命名冲突");
                            this.setErrorMsg("文件随机命名冲突");
                            return null;
                        }
                        outputFile.createNewFile();
                        @SuppressWarnings("resource")
						FileChannel outChannel = new FileOutputStream(outputFile).getChannel();

                        //合并
                        FileChannel inChannel;
                        for(File file : files){
                            inChannel = new FileInputStream(file).getChannel();
                            inChannel.transferTo(0, inChannel.size(), outChannel);
                            inChannel.close();

                            //删除分片
                            if(!file.delete()){
                                log.error("分片[" + tempFileName + "=>" + file.getName() + "]删除失败");
                            }
                        }
                        outChannel.close();
                        files = null;

                        //将MD5签名和合并后的文件path存入持久层
                        saveAttachment.setSize(outputFile.length());
                        saveAttachmentData(saveAttachment);

                        //清理：文件夹，tmp文件
                        this.cleanSpace(tempFileName, getFileTempFolder());

                        return saveAttachment;
                    }
                }catch(Exception ex){
                    log.error("数据分片合并失败", ex);
                    this.setErrorMsg("数据分片合并失败");
                    return null;

                }finally {
                    //解锁
                    lock.unlock();
                    //清理锁对象
                    FileLock.removeLock(tempFileName);
                }
            }

            //去持久层查找对应md5签名，直接返回对应path
            target = md5Check(attachment.getMd5());
            if(target == null){
                log.error("文件[签名:" + attachment.getMd5() + "]数据不完整，可能该文件正在合并中");
                this.setErrorMsg("数据不完整，可能该文件正在合并中");
                return null;
            }

            return target;
        }

        /**
         * 为上传的文件创建对应的保存位置
         * 若上传的是分片，则会创建对应的文件夹结构和tmp文件
         * @param info  上传文件的相关信息
         * @param path  文件保存根路径
         * @return
         */
        public File getReadySpace(Attachment info, String path){

            //创建上传文件所需的文件夹
            if(!this.createFileFolder(path, false)){
                return null;
            }

            String newFileName;	//上传文件的新名称

            newFileName = String.valueOf(info.getChunk());

            String fileFolder = getMd5TempFileName(info);
            if(fileFolder == null){
                return null;
            }

            path += "/" + fileFolder;    //文件上传路径更新为指定文件信息签名后的临时文件夹，用于后期合并

            if(!this.createFileFolder(path, true)){
                return null;
            }

            return new File(path, newFileName);
        }
        /**
         * 获取文件分片上传唯一临时文件名
         * @param info
         * @return
         */
        private String getMd5TempFileName(Attachment info){
        	return md5(info.getUserId() + info.getName() + info.getType() + info.getLastModifiedDate() + info.getSize());
        }
        /**
         * 清理分片上传的相关数据
         * 文件夹，tmp文件
         * @param folder    文件夹名称
         * @param path      上传文件根路径
         * @return
         */
        private boolean cleanSpace(String folder, String path){
            //删除分片文件夹
            File garbage = new File(path + "/" + folder);
            if(!garbage.delete()){
                return false;
            }

            //删除tmp文件
            garbage = new File(path + "/" + folder + ".tmp");
            if(!garbage.delete()){
                return false;
            }

            return true;
        }

        /**
         * 获取指定文件的所有分片
         * @param folder    文件夹路径
         * @return
         */
        private File[] getChunks(String folder){
            File targetFolder = new File(folder);
            return targetFolder.listFiles(new FileFilter() {
                @Override
                public boolean accept(File file) {
                    if (file.isDirectory()) {
                        return false;
                    }
                    return true;
                }
            });
        }

        /**
         * 获取指定文件的分片数量
         * @param folder    文件夹路径
         * @return
         */
        private int getChunksNum(String folder){

           File[] filesList = this.getChunks(folder);
           if(null!=filesList)
        	   return filesList.length;
           else
        	   return 0;
        }

        /**
         * 创建存放上传的文件的文件夹
         * @param file  文件夹路径
         * @return
         */
        private boolean createFileFolder(String file, boolean hasTmp){

            //创建存放分片文件的临时文件夹
            File tmpFile = new File(file);
            if(!tmpFile.exists()){
                try {
                    tmpFile.mkdir();
                }catch(SecurityException ex){
                    log.error("无法创建文件夹", ex);
                    this.setErrorMsg("无法创建文件夹");
                    return false;
                }
            }

            if(hasTmp){
                //创建一个对应的文件，用来记录上传分片文件的修改时间，用于清理长期未完成的垃圾分片
                tmpFile = new File(file + ".tmp");
                if(tmpFile.exists()){
                    tmpFile.setLastModified(System.currentTimeMillis());
                }else{
                    try{
                        tmpFile.createNewFile();
                    }catch(IOException ex){
                        log.error("无法创建tmp文件", ex);
                        this.setErrorMsg("无法创建tmp文件");
                        return false;
                    }
                }
            }

            return true;
        }

        /**
         * 记录异常错误信息
         * @param msg   错误详细
         */
        private void setErrorMsg(String msg){
            this.msg = msg;
        }
        /**
         * 获取错误详细
         * @return
         */
        public String getErrorMsg(){
            return this.msg;
        }
    }
    static class FileLock {

        private static Map<String, Lock> LOCKS = new HashMap<String, Lock>();

        public static synchronized Lock getLock(String key){
            if(LOCKS.containsKey(key)){
                return LOCKS.get(key);
            }else{
                Lock one = new ReentrantLock();
                LOCKS.put(key, one);
                return one;
            }
        }

        public static synchronized void removeLock(String key){
            LOCKS.remove(key);
        }
    }
	public static void main(String[] args) {
		System.out.println(getFileMD5(new File("F:/setup/360cse_8.0.0.508.exe")));
	}
}
