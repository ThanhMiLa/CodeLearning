package com.thanhmila.codelearning.repository.specification;

import com.thanhmila.codelearning.entity.enums.OjVerdict;
import com.thanhmila.codelearning.entity.enums.ProblemDifficulty;
import com.thanhmila.codelearning.entity.enums.ProblemScope;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeProblemEntity;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeSubmissionEntity;
import com.thanhmila.codelearning.entity.oj.ProblemTagEntity;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.JoinType;
import jakarta.persistence.criteria.Root;
import jakarta.persistence.criteria.Subquery;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;

public class ProblemSpecification {

    public static Specification<OnlineJudgeProblemEntity> hasScope(ProblemScope scope) {
        return (root, query, cb) -> cb.equal(root.get("problemScope"), scope);
    }

    public static Specification<OnlineJudgeProblemEntity> isPublicAndActive() {
        return (root, query, cb) -> cb.and(
                cb.isTrue(root.get("isPublic")),
                cb.isTrue(root.get("isActive"))
        );
    }

    public static Specification<OnlineJudgeProblemEntity> hasKeyword(String keyword) {
        return (root, query, cb) ->
                cb.like(cb.lower(root.get("title")), "%" + keyword.toLowerCase() + "%");
    }

    public static Specification<OnlineJudgeProblemEntity> hasTags(List<Long> tagIds) {
        return (root, query, cb) -> {
            query.distinct(true);
            Join<OnlineJudgeProblemEntity, ProblemTagEntity> tagsJoin = root.join("tags", JoinType.INNER);
            return tagsJoin.get("id").in(tagIds);
        };
    }

    public static Specification<OnlineJudgeProblemEntity> hasDifficulties(List<ProblemDifficulty> difficulties) {
        return (root, query, cb) -> root.get("difficulty").in(difficulties);
    }

    public static Specification<OnlineJudgeProblemEntity> hasUserAccepted(Boolean isAccepted, Long userId) {
        return (root, query, cb) -> {
            Subquery<Long> subquery = query.subquery(Long.class);
            Root<OnlineJudgeSubmissionEntity> subRoot = subquery.from(OnlineJudgeSubmissionEntity.class);
            subquery.select(subRoot.get("problem").get("id"))
                    .where(cb.and(
                            cb.equal(subRoot.get("user").get("id"), userId),
                            cb.equal(subRoot.get("verdict"), OjVerdict.ACCEPTED)
                    ));

            if (isAccepted) {
                return cb.in(root.get("id")).value(subquery);
            } else {
                return cb.not(root.get("id").in(subquery));
            }
        };
    }

    public static Specification<OnlineJudgeProblemEntity> hasIsPublic(Boolean isPublic) {
        return (root, query, cb) -> cb.equal(root.get("isPublic"), isPublic);
    }

    public static Specification<OnlineJudgeProblemEntity> hasDifficulty(ProblemDifficulty difficulty) {
        return (root, query, cb) -> cb.equal(root.get("difficulty"), difficulty);
    }
}
