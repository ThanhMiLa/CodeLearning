package com.thanhmila.codelearning.entity.oj;

import com.thanhmila.codelearning.entity.user.TeacherEntity;
import com.thanhmila.codelearning.entity.course.LessonEntity;
import com.thanhmila.codelearning.entity.enums.ProblemDifficulty;
import com.thanhmila.codelearning.entity.enums.ProblemScope;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import java.time.ZonedDateTime;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "online_judge_problems")
public class OnlineJudgeProblemEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lesson_id")
    LessonEntity lesson;

    @Column(nullable = false)
    String title;

    @Column(columnDefinition = "TEXT")
    String description;

    @Column(name = "input_description", columnDefinition = "TEXT")
    String inputDescription;

    @Column(name = "output_description", columnDefinition = "TEXT")
    String outputDescription;

    @Column(columnDefinition = "TEXT")
    String constraints;

    @Column(name = "example_input", columnDefinition = "TEXT")
    String exampleInput;

    @Column(name = "example_output", columnDefinition = "TEXT")
    String exampleOutput;

    @Column(columnDefinition = "TEXT")
    String hint;

    @Enumerated(EnumType.STRING)
    @Column(name = "problem_scope", nullable = false)
    ProblemScope problemScope;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    ProblemDifficulty difficulty;

    @Column(name = "is_active", nullable = false)
    @Builder.Default
    Boolean isActive = true;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by_teacher_id", nullable = false)
    TeacherEntity createdByTeacher;

    @Column(name = "created_at", nullable = false, updatable = false)
    ZonedDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    ZonedDateTime updatedAt;

    @OneToMany(mappedBy = "problem", cascade = CascadeType.ALL, orphanRemoval = true)
    List<ProblemTestcaseEntity> testcases;

    @ManyToMany
    @JoinTable(
            name = "problem_tag_mappings",
            joinColumns = @JoinColumn(name = "problem_id"),
            inverseJoinColumns = @JoinColumn(name = "tag_id")
    )
    @Builder.Default
    Set<ProblemTagEntity> tags = new HashSet<>();

    @PrePersist
    protected void onCreate() {
        createdAt = ZonedDateTime.now();
        updatedAt = ZonedDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = ZonedDateTime.now();
    }
}