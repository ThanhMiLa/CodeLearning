package com.thanhmila.codelearning.dto.request;

import com.thanhmila.codelearning.entity.enums.ProblemDifficulty;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProblemSearchRequest {

    String keyword;
    List<Long> tagIds;
    List<ProblemDifficulty> difficulties;
    Boolean isAccepted;

    @Builder.Default
    @Min(value = 0, message = "PAGE_INVALID")
    int page = 0;

    @Builder.Default
    @Max(value = 50, message = "PAGE_SIZE_INVALID")
    int size = 12;

    @Builder.Default
    String[] sortBy = {"totalSubmissions"};

    @Builder.Default
    String[] order = {"desc"};

    public Pageable getPageable() {
        List<Sort.Order> sortOrders = new ArrayList<>();
        if (sortBy != null) {
            for (int i = 0; i < sortBy.length; i++) {
                String sortDir = (order != null && i < order.length) ? order[i] : "asc";
                Sort.Direction direction = sortDir.equalsIgnoreCase("desc") ? Sort.Direction.DESC : Sort.Direction.ASC;
                sortOrders.add(new Sort.Order(direction, sortBy[i]));
            }
        }

        Sort dynamicSort = sortOrders.isEmpty() ? Sort.unsorted() : Sort.by(sortOrders);
        return PageRequest.of(page, size, dynamicSort);
    }
}
