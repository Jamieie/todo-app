package org.example.todoapp.security;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.todoapp.domain.CustomUserDetails;
import org.example.todoapp.domain.UserVO;
import org.example.todoapp.mappers.UsersMapper;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Slf4j
@Service("customUserDetailsService")
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {

    private final UsersMapper usersMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        log.info("=== CustomUserDetailsService loadUserByUsername ===");
        log.info("loadUserByUsername: {}", username);

        if (usersMapper.findByEmail(username).isPresent()) {
            UserVO user = usersMapper.findByEmail(username).get();
            return new CustomUserDetails(user);
        }

        throw new UsernameNotFoundException(username);
    }
}
