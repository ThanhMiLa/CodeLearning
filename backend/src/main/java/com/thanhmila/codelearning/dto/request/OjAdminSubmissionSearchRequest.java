package com.thanhmila.codelearning.dto.request;

import com.thanhmila.codelearning.entity.enums.OjVerdict;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;
import java.util.List;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class OjAdminSubmissionSearchRequest {
    String problemTitle;
    String userDisplayName;
    List<OjVerdict> verdict;
    List<Integer> languageId;
}
