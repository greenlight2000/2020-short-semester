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

    public List<User> searchUsers(String key, String value, boolean isFuzzy){
        return super.searchTs(key, value, isFuzzy, userDao);
    }

    //check information
    public UserVO getUserInfo(long id){
        User user = userDao.getOne(id);
        UserVO userVO = buildUserVo(user);
        return userVO;
    }
    //check validation
    public boolean checkPwValid(long id, String password){
        User user = userDao.getOne(id);
        return user.getPassword().equals(password);
    }
    //modify information
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
    public String updateEmail(long id, String newEmail){
        String status = "success";
        User user = userDao.getOne(id);
        if(!validEmail(newEmail)){
            status = "invalid email format";
        } else if(existedEmail(newEmail)){
            status = newEmail+" has been registered";
        }else{
            user.setEmail(newEmail);
            userDao.save(user);
        }

        return status;
    }
    public String updatePhone(long id, String newPhone){
        String status = "success";
        User user = userDao.getOne(id);
        if(!validPhone(newPhone)){
            status = "invalid phone format";
        } else if(existedPhone(newPhone)){
            status = newPhone+" has been registered";
        }else {
            user.setEmail(newPhone);
            userDao.save(user);
        }
        return status;
    }
    public String updateName(long id, String newName){
        String status = "success";
        User user = userDao.getOne(id);
        if(existedName(newName)){
            status = newName+" has been registered";
        }else {
            user.setName(newName);
            userDao.save(user);
        }
        return status;
    }
    public String updatePassword(long id, String oldPassword, String newPassword){
        String status = "success";
        User user = userDao.getOne(id);
        if(checkPwValid(id,oldPassword)) {
            user.setPassword(newPassword);
            userDao.save(user);
        }else
            status = "invalid old password";
        return status;
    }
    //check email format
    public boolean validEmail(String email){
        String EMAIL_REGEX = "^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$";
        return email.matches(EMAIL_REGEX);
    }
    //check email format
    public boolean validPhone(String phone){
        String PHONE_REGEX = "^((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8}$";
        return phone.matches(PHONE_REGEX);
    }
    //check duplication
    public boolean existedName(String name){
        return !(searchUsers("name",name,false).isEmpty());
    }
    //check duplication
    public boolean existedEmail(String email){
        return !(searchUsers("email",email,false).isEmpty());
    }
    //check duplication
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
