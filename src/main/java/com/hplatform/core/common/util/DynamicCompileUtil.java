package com.hplatform.core.common.util;

import javax.tools.JavaCompiler;
import javax.tools.StandardJavaFileManager;
import javax.tools.ToolProvider;
import java.io.File;
import java.io.IOException;
import java.util.Arrays;


/**
 * Created by Administrator on 2016/12/8.
 */
public class DynamicCompileUtil {
    public static boolean compileJavaCode(File[] sourceFiles){
        //1:取得当前系统java编译器
        JavaCompiler javaCompiler= ToolProvider.getSystemJavaCompiler();
        //2:获取一个文件管理器StandardJavaFileManage
        StandardJavaFileManager javaFileManager=javaCompiler.getStandardFileManager(null, null, null);
        //3.文件管理器根与文件连接起来
        Iterable it=javaFileManager.getJavaFileObjects(sourceFiles);
//        String dependsJars = FileUtil.joinFilName(new File(FileUtil.getProjectClassPath()).getParent()+"\\lib\\",";");
        String catalinaJars = FileUtil.joinFilName(System.getProperty("catalina.home")+"\\lib\\",";");
        String classpathJars = FileUtil.joinFilName(new File(FileUtil.getProjectClassPath()).getParent()+"\\lib\\",";");
        System.out.println(catalinaJars);
        System.out.println(classpathJars);
        //4.创建编译的任务
        JavaCompiler.CompilationTask task=javaCompiler.getTask(null,
                javaFileManager,null, Arrays.asList(
                        "-encoding","UTF-8",
                        "-classpath",catalinaJars+classpathJars,
                        "-sourcepath", FileUtil.getProjectPath()+"\\src\\main\\java",
                        "-d",FileUtil.getProjectClassPath()), null, it);
        //执行编译
        task.call();
        try {
            javaFileManager.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return true;
    }
}
