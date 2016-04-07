package com.hplatform.core.common.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;
import org.apache.tools.zip.ZipOutputStream;

import cn.org.rapid_framework.util.ObjectUtils;

/**
 * 功能:zip压缩、解压(支持中文文件名) 说明:使用Apache Ant提供的zip工具org.apache.tools.zip实现zip压缩和解压功能.
 * 解决了由于java.util.zip包不支持汉字的问题。
 */
@SuppressWarnings("unchecked")
public class ZipUtil {

	private static int bufSize = 8096;
	private static Log log = LogFactory.getLog(ZipUtil.class);

	/**
	 * 压缩多个文件或目录。可以指定多个单独的文件或目录。
	 * 
	 * @param files
	 *            要压缩的文件或目录组成的<code>File</code>数组。
	 * @param zipFileName
	 *            压缩后的zip文件名，如果后缀不是".zip, .jar, .war"，自动添加后缀".zip"。
	 * @return 成功返回null，否则返回失败信息
	 */
	public static String antzip(File[] files, String zipFileName) {
		// 未指定压缩文件名，默认为"ZipFile"
		if (StringUtils.isBlank(zipFileName))
			zipFileName = "ZipFile";

		// 添加".zip"后缀
		if (!zipFileName.toLowerCase().endsWith(".zip")
				&& !zipFileName.toLowerCase().endsWith(".jar")
				&& !zipFileName.toLowerCase().endsWith(".war"))
			zipFileName += ".zip";
		File filezip = new File(zipFileName);
		if (filezip.exists())
			filezip.delete();
		ZipOutputStream zipOutput = null;
		try {
			zipOutput = new ZipOutputStream(new BufferedOutputStream(
					new FileOutputStream(zipFileName)));
			zipOutput.setEncoding("GBK");
			for (File file : files)
				antzipFiles(file, zipOutput, "");
			log.info("压缩文件成功：" + zipFileName);
		} catch (Exception e) {
			log.error("压缩文件异常", e);
			return e.getMessage();
		} finally {
			try {
				assert zipOutput != null;
				zipOutput.close();
			} catch (Exception e) {
				log.error("异常", e);
			}
		}
		return null;
	}

	/**
	 * 压缩文件夹内的所有文件和目录。
	 * 
	 * @param zipDirectory
	 *            需要压缩的文件夹名
	 * @return 成功返回null，否则返回失败信息
	 */
	public static String antzip(String zipDirectory) {
		File zipDir = new File(zipDirectory);
		return antzip(zipDirectory, zipDir.getPath(), false);
	}

	/**
	 * 压缩文件夹内的所有文件和目录。
	 * 
	 * @param zipDirectory
	 *            需要压缩的文件夹名
	 * @param zipFileName
	 *            压缩后的zip文件名，如果后缀不是".zip, .jar, .war"， 自动添加后缀".zip"。
	 * @param includeSelfDir
	 *            是否包含自身文件夹
	 * @return 成功返回null，否则返回失败信息
	 */
	public static String antzip(String zipDirectory, String zipFileName,
			boolean includeSelfDir) {
		File zipDir = new File(zipDirectory);
		File[] willZipFileArr;
		if (includeSelfDir || zipDir.isFile())
			willZipFileArr = new File[] { zipDir };
		else
			willZipFileArr = zipDir.listFiles();
		return antzip(willZipFileArr, zipFileName);
	}

	/**
	 * @param baseDir
	 *            所要压缩的目录名（包含绝对路径）
	 * @param objFileName
	 *            压缩后的文件名
	 * @param checkfile
	 *            
	 * @throws Exception
	 *             file 为指定要打包的文件 如果指定了 则其他参数flag、checkfile无效
	 */
	public static void createZip(File file, boolean flag, String baseDir,
			String objFileName, boolean checkfile) throws Exception {
		File folderObject = new File(baseDir);
		if (folderObject.exists()) {
			// 压缩文件名
			ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(
					objFileName));
			zos.setEncoding("GBK");
			ZipEntry ze = null;
			int readLen = 0;
			byte[] buf = new byte[1024];
			if (null != file) {// 指定了某个文件
			// 创建一个ZipEntry，并设置Name和其它的一些属性
				ze = new ZipEntry(getAbsFileName(baseDir, file));
				ze.setSize(file.length());
				ze.setTime(file.lastModified());
				// 将ZipEntry加到zos中，再写入实际的文件内容
				zos.putNextEntry(ze);
				InputStream is = new BufferedInputStream(new FileInputStream(
						file));
				while ((readLen = is.read(buf, 0, 1024)) != -1)
					zos.write(buf, 0, readLen);
				is.close();
			} else {
				List fileList = getSubFiles(new File(baseDir));
				for (int i = 0; i < fileList.size(); i++) {
					File f = (File) fileList.get(i);
					if (flag)// 增量同步下进行文件时间判断，全量同步则打包所有文件
						if (checkfile && !f.isDirectory()) {// ftp同步功能（只压缩修改时间为1天内的文件）
							Calendar cal = Calendar.getInstance();
							cal.setTime(new Date());
							cal.add(Calendar.DATE, -1);
							Date fDate = new Date(f.lastModified());
							if (fDate.compareTo(cal.getTime()) < 0)
								continue;
						}
					// 创建一个ZipEntry，并设置Name和其它的一些属性
					ze = new ZipEntry(getAbsFileName(baseDir, f));
					ze.setSize(f.length());
					ze.setTime(f.lastModified());
					// 将ZipEntry加到zos中，再写入实际的文件内容
					zos.putNextEntry(ze);
					InputStream is = new BufferedInputStream(
							new FileInputStream(f));
					while ((readLen = is.read(buf, 0, 1024)) != -1)
						zos.write(buf, 0, readLen);
					is.close();
				}
			}
			zos.close();
		} else
			throw new Exception("this folder isnot exist!");
	}

	// 主函数，用于测试ZipFileUtils类
	public static void main(String[] args) throws Exception {
		System.out.println("开始解压");
		ZipUtil.unZip("E:\\temp\\酒店页面.zip", "E:\\temp\\");
		System.out.println("解压end");
	}

	/**
	 * 解压指定zip文件。
	 * 
	 * @param unZipFile
	 *            需要解压的zip文件对象
	 * @return 成功返回null，否则返回失败信息
	 */
	public static boolean unZip(File unZipFile) {
		return unZip(unZipFile.getPath(), null);
	}

	/**
	 * 解压指定zip文件到指定的目录。
	 * 
	 * @param unZipFile
	 *            需要解压的zip文件对象
	 * @param destFileName
	 *            解压目的目录
	 * @return 成功返回null，否则返回失败信息
	 */
	public static boolean unZip(File unZipFile, String destFileName) {
		return unZip(unZipFile.getPath(), destFileName);
	}

	/**
	 * 解压指定zip文件。
	 * 
	 * @param unZipFileName
	 *            需要解压的zip文件名
	 * @return 成功返回null，否则返回失败信息
	 */
	public static boolean unZip(String unZipFileName) {
		return unZip(unZipFileName, null);
	}

	/**
	 * 解压指定zip文件到指定的目录。
	 * 
	 * @param unZipFileName
	 *            需要解压的zip文件名
	 * @param destFileName
	 *            解压目的目录，如果为null则为当前zip文件所有目录
	 * @return 成功返回null，否则返回失败信息
	 */
	public static boolean unZip(String unZipFileName, String destFileName) {
		File unzipFile = new File(unZipFileName);

		if (StringUtils.isBlank(destFileName) || destFileName.trim().length() == 0)
			destFileName = unzipFile.getParent();

		File destFile;
		ZipFile zipFile = null;
		try {
			zipFile = new ZipFile(unzipFile, "GBK");
			for (Enumeration entries = zipFile.getEntries(); entries
					.hasMoreElements();) {
				ZipEntry entry = (ZipEntry) entries.nextElement();
				destFile = new File(destFileName, entry.getName());
				unZipFile(destFile, zipFile, entry, true); // 执行解压
			}
		} catch (Exception e) {
			log.error("解压ZIP文件异常", e);
			return false;
		} finally {
			try {
				assert zipFile != null;
				zipFile.close();
			} catch (Exception e) {
				log.error("异常", e);
			}
		}
		return true;
	}

	/**
	 * 解压指定zip文件到指定的目录。(只有改变或不存在的才覆盖)
	 * 
	 * @param unZipFileName
	 *            需要解压的zip文件名
	 * @param destFileName
	 *            解压目的目录，如果为null则为当前zip文件所有目录
	 * @return 成功返回null，否则返回失败信息
	 */
	public static String unZipWithFileCheck(String unZipFileName,
			String destFileName) {
		File unzipFile = new File(unZipFileName);
		StringBuffer sBuffer = new StringBuffer();
		if (StringUtils.isBlank(destFileName) || destFileName.trim().length() == 0)
			destFileName = unzipFile.getParent();
		File destFile;
		ZipFile zipFile = null;
		try {
			zipFile = new ZipFile(unzipFile, "GBK");
			java.text.DecimalFormat df = new java.text.DecimalFormat("#####.##");
			for (Enumeration entries = zipFile.getEntries(); entries
					.hasMoreElements();) {
				ZipEntry entry = (ZipEntry) entries.nextElement();
				destFile = new File(destFileName, entry.getName());
				boolean needwrite = false;
				String path = destFile.getAbsolutePath();
				path = path.replaceAll("\\\\", "/").replaceAll("//", "/");
				path = path.substring(path.indexOf("/hdtv/") + 5);
				if (!destFile.exists()) {// 本地不存在
					needwrite = true;
					sBuffer.append("     ")
							.append("        [新增]   ")
							.append(path)
							.append(" 时间:")
							.append(""
//									DateUtils.formatDate(
//									new Date(entry.getTime()),
//									"yyyy-MM-dd HH:mm:ss")
									).append(" 大小: ")
							.append(df.format(entry.getSize() / 1024.0))
							.append(" KB！").append("\r\n");
				} else {
					long entrytime = entry.getTime();
					long localtime = destFile.lastModified();
					long entrysize = entry.getSize();
					long localsize = destFile.length();
					if (entrytime != localtime || entrysize != localsize) {
						needwrite = true;
						sBuffer.append("     ")
								.append("        [修改]   ")
								.append(path)
								.append(" 更新为时间:")
								.append(""
//										DateUtils.formatDate(
//										new Date(entrytime),
//										"yyyy-MM-dd HH:mm:ss")
										).append(" 大小: ")
								.append(df.format(entrysize / 1024.0))
								.append(" KB！").append("\r\n");
					}
				}
				if (needwrite) {
					InputStream inputStream;
					FileOutputStream fileOut;
					if (entry.isDirectory())
						destFile.mkdirs();
					else {
						// 如果指定文件的父目录不存在,则创建之.
						File parent = destFile.getParentFile();
						if (ObjectUtils.isNotEmpty(parent) && !parent.exists())
							parent.mkdirs();
						inputStream = zipFile.getInputStream(entry);
						fileOut = new FileOutputStream(destFile);
						byte[] buf = new byte[bufSize];
						int readedBytes;
						while ((readedBytes = inputStream.read(buf)) > 0)
							fileOut.write(buf, 0, readedBytes);
						fileOut.close();
						inputStream.close();
						destFile.setLastModified(entry.getTime());
					}
				}
			}
		} catch (Exception e) {
			log.error("解压ZIP文件异常", e);
			sBuffer.append("解压ZIP文件异常:").append(e.getMessage()).append("\r\n");
		} finally {
			try {
				if (ObjectUtils.isNotEmpty(zipFile))
					zipFile.close();
			} catch (Exception e) {
				log.error("异常", e);
			}
		}
		return sBuffer.toString();
	}

	public static boolean unZipWithoutOverWrite(String unZipFileName,
			String destFileName) {
		File unzipFile = new File(unZipFileName);
		if (StringUtils.isBlank(destFileName) || destFileName.trim().length() == 0)
			destFileName = unzipFile.getParent();
		File destFile;
		ZipFile zipFile = null;
		try {
			zipFile = new ZipFile(unzipFile, "GBK");
			for (Enumeration entries = zipFile.getEntries(); entries
					.hasMoreElements();) {
				ZipEntry entry = (ZipEntry) entries.nextElement();
				destFile = new File(destFileName, entry.getName());
				unZipFile(destFile, zipFile, entry, false); // 执行解压
			}
		} catch (Exception e) {
			log.error("解压ZIP文件异常", e);
			return false;
		} finally {
			try {
				assert zipFile != null;
				zipFile.close();
			} catch (Exception e) {
				log.error("异常", e);
			}
		}
		return true;
	}

	/**
	 * @param file
	 *            压缩文件
	 * @param zipOutput
	 *            ZipOutputStream
	 * @param pathName
	 *            相对路径
	 * @throws Exception
	 *             异常
	 */
	private static void antzipFiles(File file, ZipOutputStream zipOutput,
			String pathName) throws Exception {
		String fileName = pathName + file.getName();
		if (file.isDirectory()) {
			fileName = fileName + "/";
			ZipEntry entry = new ZipEntry(fileName);
			entry.setTime(file.lastModified());
			zipOutput.putNextEntry(entry);
			zipOutput.closeEntry();
			String fileNames[] = file.list();
			if (ObjectUtils.isNotEmpty(fileNames)) {
				for (String fileName2 : fileNames)
					antzipFiles(new File(file, fileName2), zipOutput, fileName);
				zipOutput.closeEntry();
			}
		} else {
			ZipEntry jarEntry = new ZipEntry(fileName);
			BufferedInputStream in = new BufferedInputStream(
					new FileInputStream(file));
			zipOutput.putNextEntry(jarEntry);

			byte[] buf = new byte[bufSize];
			int len;
			while ((len = in.read(buf)) >= 0)
				zipOutput.write(buf, 0, len);
			in.close();
			zipOutput.closeEntry();
		}
	}

	/**
	 * 给定根目录，返回另一个文件名的相对路径，用于zip文件中的路径.
	 * 
	 * @param baseDir
	 *            java.lang.String 根目录
	 * @param realFileName
	 *            java.io.File 实际的文件名
	 * @return 相对文件名
	 */
	private static String getAbsFileName(String baseDir, File realFileName) {
		File real = realFileName;
		File base = new File(baseDir);
		String ret = real.getName();
		while (true) {
			real = real.getParentFile();
			if (ObjectUtils.isEmpty(real))
				break;
			if (real.equals(base))
				break;
			else
				ret = real.getName() + "/" + ret;
		}
		return ret;
	}

	/**
	 * 取得指定目录下的所有文件列表，包括子目录.
	 * 
	 * @param baseDir
	 *            File 指定的目录
	 * @return 包含java.io.File的List
	 */

	private static List getSubFiles(File baseDir) {
		List ret = new ArrayList();
		File[] tmp = baseDir.listFiles();
		for (File element : tmp) {
			if (element.isFile())
				ret.add(element);
			if (element.isDirectory())
				ret.addAll(getSubFiles(element));
		}
		return ret;
	}

	/* 执行解压 */
	private static void unZipFile(File destFile, ZipFile zipFile,
			ZipEntry entry, boolean isOverWriteIgnore) throws IOException {
		InputStream inputStream;
		FileOutputStream fileOut;
		if (entry.isDirectory())
			destFile.mkdirs();
		else // 是文件
		{
			// 如果指定文件的父目录不存在,则创建之.
			File parent = destFile.getParentFile();
			if (ObjectUtils.isNotEmpty(parent)&& !parent.exists())
				parent.mkdirs();
			boolean isOverWriteFlag = true;
			if (!isOverWriteIgnore)
				if (parent.isDirectory()) {
					String[] childfiles = parent.list();
					for (String cf : childfiles) {
						File file2X = new File(parent.getAbsolutePath() + "/"
								+ cf);
						if (file2X.exists()) {
							if (file2X.isFile()) {
								if (file2X.getName().equals(destFile.getName())) {
									isOverWriteFlag = false;
									break;
								}
							} else if (file2X.isDirectory())
								continue;
						} else
							throw new RuntimeException("File not exist!");
					}
				}
			if (isOverWriteFlag) {/* 执行解压的 ,如果发现有重复的文件则不进行覆盖 */
				inputStream = zipFile.getInputStream(entry);
				fileOut = new FileOutputStream(destFile);
				byte[] buf = new byte[bufSize];
				int readedBytes;
				while ((readedBytes = inputStream.read(buf)) > 0)
					fileOut.write(buf, 0, readedBytes);
				fileOut.close();
				inputStream.close();
			}
		}
	}

}
