package com.webproject.project01.Dao;

import com.webproject.project01.PO.User;
import com.webproject.project01.VO.UserVO;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface UserDao extends BaseDao<User> {
//    @Query(value = "select new com.webproject.project01.VO.UserVO(a.id, a.name, a.phone, a.email, a.password) from User where a.id= :id")
//    List<Object> queryAllById(@Param("id")long id);
//    @Query("select c from User u where :name is not null and u.name = :name")
//    List<User> findUserByName(@Param("name") String name);

    User findFirstByName(String name);

}
