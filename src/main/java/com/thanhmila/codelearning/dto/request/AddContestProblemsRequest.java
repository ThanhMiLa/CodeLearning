package com.thanhmila.codelearning.dto.request;

import jakarta.validation.constraints.NotEmpty;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class AddContestProblemsRequest {

    @NotEmpty(message = "Problem list must not be empty")
    List<Long> problemIds;
}
