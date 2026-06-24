package com.thanhmila.codelearning.event;

import lombok.Getter;
import org.springframework.context.ApplicationEvent;

@Getter
public class ContestStartedEvent extends ApplicationEvent {
    private final Long contestId;

    public ContestStartedEvent(Object source, Long contestId) {
        super(source);
        this.contestId = contestId;
    }
}
