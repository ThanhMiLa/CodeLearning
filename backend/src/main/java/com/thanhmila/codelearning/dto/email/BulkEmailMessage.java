package com.thanhmila.codelearning.dto.email;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BulkEmailMessage implements Serializable {
    private String batchId;
    private String templateId;
    private List<UserEmailInfo> users;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class UserEmailInfo implements Serializable {
        private String email;
        private String name;
    }
}
