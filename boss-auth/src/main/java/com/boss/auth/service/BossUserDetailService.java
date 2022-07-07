package com.boss.auth.service;

import com.boss.common.entity.BossAuthUser;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author DevinJoe
 * @since 2022/7/7
 */
@Service
public class BossUserDetailService implements UserDetailsService {

    @Resource
    private PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        BossAuthUser user = new BossAuthUser();
        user.setUsername(username);
        user.setPassword(this.passwordEncoder.encode("16250"));
        return new User(username, user.getPassword(), user.isEnabled(), user.isAccountNonExpired(),
                user.isCredentialNonExpired(), user.isAccountNonLocked(),
                AuthorityUtils.commaSeparatedStringToAuthorityList("user:add"));
    }
}
