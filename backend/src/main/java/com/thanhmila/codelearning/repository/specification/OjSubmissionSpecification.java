package com.thanhmila.codelearning.repository.specification;

import com.thanhmila.codelearning.entity.enums.OjVerdict;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeProblemEntity;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeSubmissionEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.JoinType;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;

public class OjSubmissionSpecification {

    public static Specification<OnlineJudgeSubmissionEntity> hasProblemTitle(String title) {
        return (root, query, criteriaBuilder) -> {
            if (title == null || title.trim().isEmpty()) {
                return null;
            }
            Join<OnlineJudgeSubmissionEntity, OnlineJudgeProblemEntity> problemJoin = root.join("problem", JoinType.INNER);
            return criteriaBuilder.like(criteriaBuilder.lower(problemJoin.get("title")), "%" + title.toLowerCase() + "%");
        };
    }

    public static Specification<OnlineJudgeSubmissionEntity> hasUserDisplayName(String displayName) {
        return (root, query, criteriaBuilder) -> {
            if (displayName == null || displayName.trim().isEmpty()) {
                return null;
            }
            Join<OnlineJudgeSubmissionEntity, UserEntity> userJoin = root.join("user", JoinType.INNER);
            return criteriaBuilder.like(criteriaBuilder.lower(userJoin.get("displayName")), "%" + displayName.toLowerCase() + "%");
        };
    }

    public static Specification<OnlineJudgeSubmissionEntity> hasVerdict(List<OjVerdict> verdicts) {
        return (root, query, criteriaBuilder) -> {
            if (verdicts == null || verdicts.isEmpty()) {
                return null;
            }
            return root.get("verdict").in(verdicts);
        };
    }

    public static Specification<OnlineJudgeSubmissionEntity> hasLanguageId(List<Integer> languageIds) {
        return (root, query, criteriaBuilder) -> {
            if (languageIds == null || languageIds.isEmpty()) {
                return null;
            }
            return root.get("languageId").in(languageIds);
        };
    }
}
