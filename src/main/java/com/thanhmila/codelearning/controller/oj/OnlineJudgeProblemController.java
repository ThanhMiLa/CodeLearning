package com.thanhmila.codelearning.controller.oj;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import java.time.Instant;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.dto.response.OnlineJudgeProblemResponse;
import com.thanhmila.codelearning.service.oj.OnlineJudgeProblemService;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/online-judge")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class OnlineJudgeProblemController {
    
    OnlineJudgeProblemService onlineJudgeProblemService;


    @GetMapping("/problems")
    public ResponseEntity<ApiResponse<List<OnlineJudgeProblemResponse>>> getOnlineJudgeProblemList(
            @AuthenticationPrincipal Jwt jwt,
            @RequestParam Long lessonId){

        Long userId = null;
        if(jwt != null){
            userId = jwt.getClaim("userId");
        }

        var result = onlineJudgeProblemService.getOnlineJudgeProblemList(lessonId, userId);

        return ResponseEntity.ok(ApiResponse.<List<OnlineJudgeProblemResponse>>builder()
                .status(200)
                .code(1000)
                .message("Get online judge problem list successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }

    
}