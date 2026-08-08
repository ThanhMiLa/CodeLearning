package com.thanhmila.codelearning.dto.email;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SendGridEmailRequest {
    private From from;
    private String template_id;
    private List<Personalization> personalizations;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class From {
        private String email;
        private String name;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Personalization {
        private List<To> to;
        private Map<String, Object> dynamic_template_data;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class To {
        private String email;
    }
}
