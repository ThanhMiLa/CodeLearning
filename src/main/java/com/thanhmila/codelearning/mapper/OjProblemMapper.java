package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.request.CreateOjProblemRequest;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeProblemEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface OjProblemMapper {

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "isActive", constant = "false")
    @Mapping(target = "isPublic", constant = "false")
    @Mapping(target = "totalTestCase", constant = "0")
    @Mapping(target = "totalSubmissions", constant = "0")
    @Mapping(target = "totalAccepted", constant = "0")
    @Mapping(target = "createdByTeacher", ignore = true)
    @Mapping(target = "timeLimitMs", defaultValue = "2000")
    @Mapping(target = "memoryLimitKb", defaultValue = "262144")
    @Mapping(target = "score", defaultValue = "100.0")
    @Mapping(target = "acceptanceRate", ignore = true)
    @Mapping(target = "difficultyLevel", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    @Mapping(target = "testcases", ignore = true)
    @Mapping(target = "tags", ignore = true)
    OnlineJudgeProblemEntity toEntity(CreateOjProblemRequest request);
}
