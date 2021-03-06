package com.jing.edu.controller.user;

import java.io.File;
import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.jing.edu.common.util.StringUtil;
import com.jing.edu.model.Course;
import com.jing.edu.model.User;
import com.jing.edu.model.UserDetail;
import com.jing.edu.model.UserDetailStu;
import com.jing.edu.model.UserDetailTea;
import com.jing.edu.model.EduType.UserType;
import com.jing.edu.service.CourseService;
import com.jing.edu.service.UserDetailService;

/**
 * 教师或者学生的个人中心Controller
 * 
 * @author jing
 *
 */
@Controller
@RequestMapping(value = "/user/detail")
public class UserDetailController {

	@Resource
	public UserDetailService detailService;

	@Resource
	public CourseService courseService;

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String saveUserInfo(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("imageFile") MultipartFile file) {
		String redirectStr = null;
		String type = request.getParameter("userType");
		// 判断图片是否合格
		boolean flag = detailService.validatePhoto(file.getSize());
		if (flag) {
			String level = request.getParameter("level");
			String username = request.getParameter("username");
			String realname = request.getParameter("realname");
			// 教授课程
			String subjects = StringUtil.subjectsContact(request.getParameterValues("subjects"));
			try {
				// 图片缓存到服务器
				String rootPhotoPath = request.getServletContext().getRealPath("/upload_photos");
				File serverFolder = new File(rootPhotoPath);
				if (!serverFolder.exists()) {
					serverFolder.mkdirs();
				}
				detailService.addPhotoToServer(rootPhotoPath, type, realname, subjects, level, file.getBytes());
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			if ("tea".equals(type)) {
				String introduction = request.getParameter("introduction");
				String honor = request.getParameter("honor");
				// 价格
				String smallprice = request.getParameter("small-price");
				String mediumprice = request.getParameter("medium-price");
				String seniorprice = request.getParameter("senior-price");
				String price = StringUtil.priceContact(smallprice, mediumprice, seniorprice);
				// location
				String city = request.getParameter("city");
				String school = request.getParameter("school");

				UserDetailTea detailTea = new UserDetailTea();
				Course course = new Course();
				try {
					detailTea.setCity(city);
					detailTea.setHonor(honor);
					detailTea.setIntroduction(introduction);
					detailTea.setIsonline(1);
					detailTea.setLevel(level);
					detailTea.setName(username);
					detailTea.setPrice(price);
					detailTea.setRealName(realname);
					detailTea.setSchool(school);
					detailTea.setSubject(subjects);
					detailTea.setType(1);
					detailTea.setImage(file.getBytes());

					course.setTeacherId(Integer.valueOf(request.getParameter("id")));
					course.setGrade(level);
					course.setName(subjects);
					course.setPrice(price);
					course.setTeacherName(realname);
				} catch (IOException e) {
					e.printStackTrace();
				}
				if (null != detailService.queryUserDetail(username, UserType.TEACHER)) {
					detailService.update(detailTea);
				} else {
					detailService.insertDetailInfo(detailTea);
				}
				request.getSession().setAttribute("userDetail", detailTea);
				request.getSession().setAttribute("result", "上传图片与信息成功~");
				redirectStr = "redirect:/user/detail/tea/index";

			} else if ("stu".equals(type)) {
				String city = request.getParameter("city");
				String introduction = request.getParameter("introduction");
				String address = request.getParameter("address");
				// 价格
				String smallprice = request.getParameter("small-price");
				String mediumprice = request.getParameter("medium-price");
				String seniorprice = request.getParameter("senior-price");
				String price = StringUtil.priceContact(smallprice, mediumprice, seniorprice);

				UserDetailStu detailStu = new UserDetailStu();
				try {
					detailStu.setAddress(address);
					detailStu.setCity(city);
					detailStu.setIntroduction(introduction);
					detailStu.setIsonline(1);
					detailStu.setLevel(level);
					detailStu.setName(username);
					detailStu.setRealName(realname);
					detailStu.setSubject(subjects);
					detailStu.setPrice(price);
					detailStu.setType(2);
					detailStu.setImage(file.getBytes());
				} catch (IOException e) {
					e.printStackTrace();
				}
				if (null != detailService.queryUserDetail(username, UserType.STUDENT)) {
					detailService.update(detailStu);
				} else {
					detailService.insertDetailInfo(detailStu);
				}
				request.getSession().setAttribute("userDetail", detailStu);
				request.getSession().setAttribute("result", "上传图片与信息成功~");
				redirectStr = "redirect:/user/detail/stu/index";
			}
		} else {
			redirectStr = "redirect:/user/detail/" + type + "/index";
			request.getSession().setAttribute("result", "上传的图片不可大于2M且不可小于7KB");
		}

		return redirectStr;
	}

	@RequestMapping(value = "/tea/index")
	public String redirectToTeaIndex(HttpServletRequest request) {
		// 默认没有完善用户的真实姓名
		String hasDetail = "0";
		String username = ((User) request.getSession().getAttribute("user")).getUsername();
		UserDetail detail = detailService.queryUserDetail(username, UserType.TEACHER);
		if (null != detail && null != detail.getRealName()) {
			hasDetail = "1";
		}
		request.setAttribute("hasDetail", hasDetail);
		return "user/detail/tea/index";
	}

	@RequestMapping(value = "/stu/index")
	public String redirectToStuIndex(HttpServletRequest request) {
		// 默认没有用户的具体信息
		String hasDetail = "0";
		String username = ((User) request.getSession().getAttribute("user")).getUsername();
		UserDetail detail = detailService.queryUserDetail(username, UserType.STUDENT);
		if (null != detail && null != detail.getRealName()) {
			hasDetail = "1";
		}
		request.setAttribute("hasDetail", hasDetail);
		return "user/detail/stu/index";
	}

	@RequestMapping(value = "/tea/index/right/info")
	public String redirectToTeaIndexInfo(HttpServletRequest request) {
		return "user/detail/tea/right/right_info";
	}

	@RequestMapping(value = "/tea/index/right/message")
	public String redirectToTeaIndexMessage(HttpServletRequest request) {
		return "user/detail/tea/right/right_message";
	}

	@RequestMapping(value = "/stu/index/right/info")
	public String redirectToStuIndexInfo(HttpServletRequest request) {
		return "user/detail/stu/right/right_info";
	}

	@RequestMapping(value = "/stu/index/right/message")
	public String redirectToStuIndexMessage(HttpServletRequest request) {
		return "user/detail/stu/right/right_message";
	}
}
