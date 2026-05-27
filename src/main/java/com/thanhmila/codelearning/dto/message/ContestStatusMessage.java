package com.thanhmila.codelearning.dto.message;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.Instant;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ContestStatusMessage {
    private String contestId;
    private String action; // "START" or "END"
    private Instant targetTime;
}
