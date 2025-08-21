package org.example.todoapp.service;

import lombok.RequiredArgsConstructor;
import org.example.todoapp.domain.SignupRequestDTO;
import org.example.todoapp.domain.UserVO;
import org.example.todoapp.exception.EmailAlreadyExistsException;
import org.example.todoapp.exception.SignupFailedException;
import org.example.todoapp.exception.SignupValidationException;
import org.example.todoapp.mappers.TaskListMapper;
import org.example.todoapp.mappers.UsersMapper;
import org.example.todoapp.util.DtoVoConverter;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {

    private final UsersMapper usersMapper;
    private final PasswordEncoder passwordEncoder;
    private final TaskListService taskListService;

    @Override
    public void signup(SignupRequestDTO signupRequestDTO) {
        // 비밀번호 두 개 다르거나 이미 존재하는 email이면 예외 발생
        if (!signupRequestDTO.equalsPasswords()) {
            throw new SignupValidationException("확인 비밀번호가 일치하지 않습니다.");
        }
        usersMapper.findByEmail(signupRequestDTO.getEmail()).ifPresent(user -> {
            throw new EmailAlreadyExistsException("사용 중인 이메일입니다.");
        });

        // user DB에 저장 후 안 됐을 경우 예외 발생
        UserVO userVO = DtoVoConverter.signupRequestDTOtoUserVO(signupRequestDTO);
        userVO.setPassword(passwordEncoder.encode(signupRequestDTO.getPassword()));
        int count = usersMapper.insertUser(userVO);
        if (count == 0) {
            throw new SignupFailedException("회원가입에 실패했습니다.");
        }

        taskListService.createDefaultTaskList(userVO.getUserId());
    }

    /*
    @Override
    public LoginResponseDTO login(LoginRequestDTO loginRequestDTO) {
        UserVO user = authenticate(loginRequestDTO);
        
        if (user == null) {
            throw new AuthenticationFailedException("이메일 또는 비밀번호가 올바르지 않습니다.");
        }
        
        return new LoginResponseDTO(user.getUserId(), user.getEmail(), user.getName());
    }

    // 로그인 정보 검증하는 메서드
    private UserVO authenticate(LoginRequestDTO loginRequestDTO) {

        UserVO user = usersMapper.findByEmail(loginRequestDTO.getEmail()).orElse(null);

        if (user == null) {
            return null;
        }

        // 로그인 비밀번호 입력값 해싱하여 DB 저장 비밀번호와 비교
        String hashedPassword = HashUtil.hashPassword(loginRequestDTO.getPassword());
        if (hashedPassword.equals(user.getPassword())) {
            return user;
        }

        return null;
    }
    */
}