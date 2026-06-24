package com.thanhmila.codelearning.repository.projection;

import java.time.Instant;

public interface RootLessonCommentProjection {
    Long getId();
    String getContent();
    Instant getCreatedAt();
    Instant getUpdatedAt();
    Long getUserId();
    String getDisplayName();
    Long getReplyCount();
}

