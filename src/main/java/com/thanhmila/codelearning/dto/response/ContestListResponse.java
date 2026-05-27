package com.thanhmila.codelearning.dto.response;

import com.thanhmila.codelearning.entity.enums.ContestStatus;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.ZonedDateTime;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ContestListResponse {
    Long id;
    String title;
    ZonedDateTime startTime;
    ZonedDateTime endTime;
    ContestStatus status;
    String createdByTeacherName;
    long numberOfParticipants;
    boolean isPublic;
}
