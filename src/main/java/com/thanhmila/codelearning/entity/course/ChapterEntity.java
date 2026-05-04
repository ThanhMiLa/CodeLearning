package com.thanhmila.codelearning.entity.course;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(
        name = "chapters",
        uniqueConstraints = {
                @UniqueConstraint(
                        name = "uq_chapters_course_order",
                        columnNames = {"course_id", "order_index"}
                )
        }
)
public class ChapterEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "course_id", nullable = false)
    CourseEntity course;

    @Column(name = "title", nullable = false, length = 255)
    String title;

    @Column(name = "order_index", nullable = false)
    Integer orderIndex;

    @Builder.Default
    @OneToMany(mappedBy = "chapter", fetch = FetchType.LAZY)
    List<LessonEntity> lessons = new ArrayList<>();
}