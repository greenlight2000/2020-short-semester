package com.webproject.project01.Service;

import com.webproject.project01.Dao.UserDao;
import com.webproject.project01.PO.User;
import com.webproject.project01.VO.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService extends BaseService<User> {
    @Autowired
    private UserDao userDao;
    //按一个key查找users
    public List<User> searchUsers(String key, String value, boolean isFuzzy){
        return super.searchTs(key, value, isFuzzy, userDao);
    }
    //查看个人信息
    public UserVO getUserInfo(long id){
        User user = userDao.getOne(id);
        UserVO userVO = buildUserVo(user);
        return userVO;
    }
    //检查密码是否正确
    public boolean checkPwValid(long id, String password){
        User user = userDao.getOne(id);
        return user.getPassword().equals(password);
    }
    //修改个人信息
    public String update(long id, String email, String phone, String password){
        User user = userDao.getOne(id);
        if(email != null)
            user.setEmail(email);
        if(phone != null)
            user.setPhone(phone);
        if(password != null)
            user.setPassword(password);
        userDao.save(user);
        return "success";
    }
    public String updateEmail(long id, String oldEmail, String newEmail){
        String status = "success";
        User user = userDao.getOne(id);
        if(user.getEmail().equals(oldEmail)){
            user.setEmail(newEmail);
            userDao.save(user);
        }
        else
            status = "invalid old email";
        return status;
    }
    public String updatePhone(long id, String oldPhone, String newPhone){
        String status = "success";
        User user = userDao.getOne(id);
        if(user.getEmail().equals(oldPhone)){
            user.setEmail(newPhone);
            userDao.save(user);
        }
        else
            status = "invalid old phone number";
        return status;
    }
    public String updatePassword(long id, String oldPassword, String newPassword){
        String status = "success";
        User user = userDao.getOne(id);
        if(user.getEmail().equals(oldPassword)) {
            user.setEmail(newPassword);
            userDao.save(user);
        }else
            status = "invalid old password";
        return status;
    }
    //后端检查email格式
    public boolean validEmail(String email){
        String EMAIL_REGEX = "^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$";
        return email.matches(EMAIL_REGEX);
    }
    //后端检查email格式
    public boolean validPhone(String phone){
        String PHONE_REGEX = "^((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8}$";
        return phone.matches(PHONE_REGEX);
    }
    //检查是否已经被注册
    public boolean existedName(String name){
        return !(searchUsers("name",name,false).isEmpty());
    }
    //检查是否已经被注册
    public boolean existedEmail(String email){
        return !(searchUsers("email",email,false).isEmpty());
    }
    //检查是否已经被注册
    public boolean existedPhone(String phone){
        return !(searchUsers("phone",phone,false).isEmpty());
    }
    public UserVO buildUserVo(User user){
        UserVO userVO = new UserVO(user.getId(),user.getName(),user.getPhone(),user.getEmail(),user.getPassword());
        return userVO;
    }
    public User buildUser(UserVO userVO){
        User user;
        if(userDao.existsById(userVO.getId()))
            user = userDao.getOne(userVO.getId());
        else
            user = new User();
        user.setName(userVO.getName());
        user.setEmail(userVO.getEmail());
        user.setPhone(userVO.getPhone());
        user.setPassword(userVO.getPassword());
        return user;
    }
    public void upload(User user){
        userDao.save(user);
    }

}
