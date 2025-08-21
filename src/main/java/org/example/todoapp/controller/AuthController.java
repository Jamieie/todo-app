package org.example.todoapp.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.example.todoapp.domain.SignupRequestDTO;
import org.example.todoapp.service.AuthService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @GetMapping("/login")
    public void login() {}

    /* Spring Security로 대체
    @PostMapping("/login")
    public String login(@Valid LoginRequestDTO loginRequestDTO, 
                       BindingResult bindingResult,
                       HttpServletRequest request,
                       Model model) {

        // 사용자 입력값이 유효하지 않을 경우
        if (bindingResult.hasErrors()) {
            model.addAttribute("error", "입력값을 확인해주세요.");
            return "auth/login";
        }

        LoginResponseDTO loginResponse = authService.login(loginRequestDTO);

        HttpSession session = request.getSession(true);
        session.setAttribute("user", loginResponse);

        return "redirect:/dashboard";
    }

    @PostMapping("/logout")
    public String logout(HttpServletRequest request, RedirectAttributes rttr) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        rttr.addFlashAttribute("message", "로그아웃되었습니다.");
        return "redirect:/auth/login";
    }
    */

    @GetMapping("/signup")
    public void signup() {}

    @PostMapping("/signup")
    public String signup(@Valid SignupRequestDTO signupRequestDTO,
                        BindingResult bindingResult,
                        Model model) {

        // 사용자 입력값이 유효하지 않을 경우
        if (bindingResult.hasErrors()) {
            model.addAttribute("error", "입력값을 확인해주세요.");
            return "auth/signup";
        }

        authService.signup(signupRequestDTO);
        model.addAttribute("success", "회원가입이 완료되었습니다. 로그인해주세요.");
        return "auth/login";
    }
}
