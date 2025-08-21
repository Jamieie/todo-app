package org.example.todoapp.mappers;

import org.apache.ibatis.annotations.Mapper;
import org.example.todoapp.domain.UserVO;

import java.util.Optional;

@Mapper
public interface UsersMapper {
    Optional<UserVO> findByEmail(String email);
    int insertUser(UserVO user);
    Optional<UserVO> findById(String userId);
}
