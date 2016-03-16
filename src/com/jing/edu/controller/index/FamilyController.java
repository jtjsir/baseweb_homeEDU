package com.jing.edu.controller.index;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jing.edu.model.EduType.UserType;
import com.jing.edu.service.FamilyService;

@Controller
@RequestMapping(value = "/family")
public class FamilyController {

	@Resource
	public FamilyService familyService;

	@RequestMapping(value = "/index/tea")
	public String redirectToTea(HttpServletRequest request) {
		request.getSession().setAttribute("city", "杭州市");
		request.getSession().setAttribute("grade", "小学");
		request.getSession().setAttribute("subject", "数学");

		return "/family/tea/tea_index";
	}

	@RequestMapping(value = "/index/stu")
	public String redirectToStu(HttpServletRequest request) {
		request.getSession().setAttribute("city", "杭州市");
		request.getSession().setAttribute("grade", "小学");
		request.getSession().setAttribute("subject", "数学");

		return "/family/stu/stu_index";
	}

	/**
	 * 点击教师部营中的年级选项得到的科目集合
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/content/getsubject")
	public void getSubjectHtml(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8");

		String grade = request.getParameter("grade");
		request.getSession().setAttribute("grade", grade);
		StringBuffer buffer = null;
		PrintWriter writer = null;
		try {
			buffer = new StringBuffer();
			writer = response.getWriter();
			if ("小学".equals(grade)) {
				buffer.append("<span class=\"subject\"><a class=\"active\" id=\"yuwen\">语文</a></span>")
						.append("<span class=\"subject\"><a id=\"shuxue\">数学</a></span>")
						.append("<span class=\"subject\"><a id=\"yingyu\">英语</a></span>");
			} else if ("初中".equals(grade)) {
				buffer.append("<span class=\"subject\"><a class=\"active\" id=\"yuwen\">语文</a></span>")
						.append("<span class=\"subject\"><a id=\"shuxue\">数学</a></span>")
						.append("<span class=\"subject\"><a id=\"yingyu\">英语</a></span>")
						.append("<span class=\"subject\"><a id=\"kexue\">科学</a></span>");
			} else if ("高中".equals(grade)) {
				buffer.append("<span class=\"subject\"><a class=\"active\" id=\"yuwen\">语文</a></span>")
						.append("<span class=\"subject\"><a id=\"shuxue\">数学</a></span>")
						.append("<span class=\"subject\"><a id=\"yingyu\">英语</a></span>")
						.append("<span class=\"subject\"><a id=\"wuli\">物理</a></span>")
						.append("<span class=\"subject\"><a id=\"huaxue\">化学</a></span>")
						.append("<span class=\"subject\"><a id=\"shengwu\">生物</a></span>")
						.append("<span class=\"subject\"><a id=\"zhengzhi\">政治</a></span>")
						.append("<span class=\"subject\"><a id=\"lishi\">历史</a></span>")
						.append("<span class=\"subject\"><a id=\"dili\">地理</a></span>");
			}

			writer.write(buffer.toString());
			writer.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (writer != null) {
				writer.close();
			}
		}
	}

	@RequestMapping(value = "/stutea/infos")
	public void displayUserInfos(HttpServletRequest request, HttpServletResponse response) {
		String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
				+ request.getContextPath();

		String city = request.getParameter("city");
		String grade = request.getParameter("grade");
		String subject = request.getParameter("subject");

		String userType = request.getParameter("userType");
		String page = request.getParameter("page");

		if (city == null) {
			city = (String) request.getSession().getAttribute("city");
		} else {
			request.getSession().setAttribute("city", city);
		}
		if (grade == null) {
			grade = (String) request.getSession().getAttribute("grade");
		} else {
			request.getSession().setAttribute("grade", grade);
		}
		if (subject == null) {
			subject = (String) request.getSession().getAttribute("subject");
		} else {
			request.getSession().setAttribute("subject", subject);
		}

		// 将查询到的json数据返回给前台
		String gradeSubject = grade + subject;
		String familys = null;
		if (UserType.STUDENT.getName().equals(userType)) {
			familys = familyService.queryStuFamily(city, gradeSubject, basePath, page);
		} else if (UserType.TEACHER.getName().equals(userType)) {
			familys = familyService.queryTeaFamily(city, gradeSubject, basePath, page);
		}

		response.setContentType("text/html;charset=utf-8");
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			writer.write(familys);
			writer.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (writer != null) {
				writer.close();
			}
		}

	}

	@RequestMapping(value = "/all/stutea/infos")
	public void displayAllUsers(HttpServletRequest request, HttpServletResponse response) {
		String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
				+ request.getContextPath();

		String userType = request.getParameter("userType");
		String page = request.getParameter("page");
		String content = request.getParameter("content") ;
		String gradeSub = this.filterGradeSubKeys(content) ;
		// 将查询到的json数据返回给前台
		String familys = null;
		if (UserType.STUDENT.getName().equals(userType)) {
			familys = familyService.queryAllStuFamily(gradeSub, basePath,page);
		} else if (UserType.TEACHER.getName().equals(userType)) {
			familys = familyService.queryAllTeaFamily(gradeSub, basePath, page);
		}

		response.setContentType("text/html;charset=utf-8");
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			writer.write(familys);
			writer.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (writer != null) {
				writer.close();
			}
		}
	}

	@RequestMapping(value = "/tea/photo")
	public void displayTeaPhoto(HttpServletRequest request, HttpServletResponse response) {
		// imgid==username 确保username的唯一性
		String imgid = request.getParameter("imgid");

		// 图片字节流用response.getOutputstream
		response.setContentType("image/jpeg");
		BufferedInputStream bis = null;
		OutputStream writer = null;
		try {
			InputStream is = familyService.getPhoto(imgid, UserType.TEACHER.getName());
			bis = new BufferedInputStream(is);
			writer = response.getOutputStream();
			byte[] data = new byte[1024];
			int dataLen = 0;
			while ((dataLen = bis.read(data)) != -1) {
				writer.write(data, 0, dataLen);
			}
			writer.flush();
			is.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (bis != null) {
				try {
					bis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@RequestMapping(value = "/stu/photo")
	public void displayStuPhoto(HttpServletRequest request, HttpServletResponse response) {
		// imgid==username 确保username的唯一性
		String imgid = request.getParameter("imgid");

		// 图片字节流用response.getOutputstream
		response.setContentType("image/jpeg");
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		try {
			bis = new BufferedInputStream(familyService.getPhoto(imgid, UserType.STUDENT.getName()));
			bos = new BufferedOutputStream(response.getOutputStream());
			byte[] data = new byte[1024];
			int dataLen = 0;
			while ((dataLen = bis.read(data)) != -1) {
				bos.write(data, 0, dataLen);
			}
			bos.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (bis != null) {
				try {
					bis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (bos != null) {
				try {
					bos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	private String filterGradeSubKeys(String content){
		StringBuffer gradeSubBuffer = new StringBuffer() ;
		if(content.contains("小学")){
			gradeSubBuffer.append("小学") ;
		}else if(content.contains("初中")){
			gradeSubBuffer.append("初中") ;
		}else if (content.contains("高中")) {
			gradeSubBuffer.append("高中") ;
		}
		if(content.contains("数学")){
			gradeSubBuffer.append("数学");
		}else if(content.contains("语文")){
			gradeSubBuffer.append("语文") ;
		}else if(content.contains("英语")){
			gradeSubBuffer.append("英语") ;
		}else if(content.contains("科学")){
			gradeSubBuffer.append("科学") ;
		}else if(content.contains("物理")){
			gradeSubBuffer.append("物理") ;
		}else if(content.contains("化学")){
			gradeSubBuffer.append("化学") ;
		}else if(content.contains("生物")){
			gradeSubBuffer.append("生物") ;
		}else if(content.contains("历史")){
			gradeSubBuffer.append("历史") ;
		}else if(content.contains("政治")){
			gradeSubBuffer.append("政治") ;
		}else if(content.contains("地理")){
			gradeSubBuffer.append("地理") ;
		}
		if(gradeSubBuffer.toString().equals("")){
			gradeSubBuffer.append("傻逼") ;
		}
		return gradeSubBuffer.toString() ;
	}
}