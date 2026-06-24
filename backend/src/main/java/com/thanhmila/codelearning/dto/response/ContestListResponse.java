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
    boolean isRegistered;

    public ContestListResponse(Long id, String title, ZonedDateTime startTime, ZonedDateTime endTime, 
                               ContestStatus status, String createdByTeacherName, 
                               long numberOfParticipants, boolean isPublic) {
        this.id = id;
        this.title = title;
        this.startTime = startTime;
        this.endTime = endTime;
        this.status = status;
        this.createdByTeacherName = createdByTeacherName;
        this.numberOfParticipants = numberOfParticipants;
        this.isPublic = isPublic;
        this.isRegistered = false;
    }
}
