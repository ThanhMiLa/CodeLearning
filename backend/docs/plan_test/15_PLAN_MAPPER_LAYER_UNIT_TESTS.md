# 📋 KẾ HOẠCH KIỂM THỬ: MAPPER LAYER UNIT TESTS (MAPSTRUCT MAPPINGS)
Dự án: **CodeLearning Platform Backend**  
Phân hệ: **Tầng Ánh xạ Dữ liệu (MapStruct) Entity $\leftrightarrow$ DTO**  
Vị trí tài liệu: `backend/docs/plan_test/15_PLAN_MAPPER_LAYER_UNIT_TESTS.md`  
Độ bao phủ mục tiêu: **Line Coverage $\ge 95\%$, Branch Coverage $\ge 90\%$**

---

## 1. Danh sách các Mapper trong phạm vi kiểm thử

| Mapper Interface | Package | Trọng tâm kiểm thử |
| :--- | :--- | :--- |
| **`UserMapper`** | `mapper/UserMapper.java` | Ánh xạ `UserEntity` sang `AuthenticationResponse`, `UserResponse`, `AdminUserResponse`; `mapRoles(roles)` (null vs non-null); Trích xuất `balance` từ `wallet` (null fallback `BigDecimal.ZERO`). |
| **`CourseMapper`** | `mapper/CourseMapper.java` | Ánh xạ `CourseEntity` sang `CourseListItemResponse`, `CourseDetailResponse`, `EnrolledCourseResponse`. |
| **`ChapterMapper`** | `mapper/ChapterMapper.java` | Ánh xạ `ChapterEntity` sang `ChapterResponse`, sắp xếp bài học con theo `orderIndex`. |
| **`LessonMapper`** | `mapper/LessonMapper.java` | Ánh xạ `LessonEntity` sang `LessonDetailResponse`, `LessonSummaryResponse`. |
| **`QuizMapper`** | `mapper/QuizMapper.java` | Ánh xạ `QuizEntity` & `QuizQuestionEntity` sang `QuizDetailResponse`. |
| **`CartMapper`** | `mapper/CartMapper.java` | Ánh xạ `CartEntity` & `CartItemEntity` sang `CartResponse`, tính tổng tiền giỏ hàng. |
| **`ContestMapper`** | `mapper/ContestMapper.java` | Ánh xạ `ContestEntity` sang `ContestResponse`, `ContestListResponse`. |
| **`OjProblemMapper`** | `mapper/OjProblemMapper.java` | Ánh xạ `OnlineJudgeProblemEntity` sang `OjPracticeProblemResponse`, format tags. |
| **`OjSubmissionMapper`**| `mapper/OjSubmissionMapper.java` | Ánh xạ `OnlineJudgeSubmissionEntity` sang `OjContestSubmissionResponse`. |

---

## 2. Phân tích chi tiết Dòng lệnh & Rẽ nhánh (Line & Branch Coverage Analysis)

### 2.1. `UserMapper.java`
* **`mapRoles(Set<RoleEntity> roles)`:**
  * **Nhánh 1:** `roles == null` -> Trả về `Collections.emptySet()`.
  * **Nhánh 2:** `roles` chứa nhiều phần tử (`"ADMIN"`, `"TEACHER"`) -> Stream map lấy `RoleEntity::getName`.
* **`toAdminUserResponse(UserEntity userEntity)`:**
  * **Nhánh 1:** `user.getWallet() == null` -> `balance = BigDecimal.ZERO`.
  * **Nhánh 2:** `user.getWallet() != null` nhưng `balance == null` -> `balance = BigDecimal.ZERO`.
  * **Nhánh 3:** `user.getWallet() != null` và có `balance` -> Trả về đúng số dư ví.
  * **Nhánh 4:** `user.getStatus() == null` -> `status = null`. Ngược lại -> `status.name()`.

### 2.2. `CartMapper.java`
* Ánh xạ danh sách items trong giỏ hàng: Kiểm tra giỏ hàng rỗng vs giỏ hàng có nhiều mặt hàng.

### 2.3. `CourseMapper.java` & `ChapterMapper.java`
* Kiểm tra ánh xạ danh mục, giảng viên, và tính toán số bài giảng.

---

## 3. Ma trận Kịch bản Kiểm thử (Test Cases Matrix)

| Test ID | Mapper / Method | Điều kiện đầu vào (Given) | Hành vi kỳ vọng (Then) |
| :--- | :--- | :--- | :--- |
| **MAP_USR_01** | `UserMapper.mapRoles` | `roles = null` | Trả về Set rỗng (`emptySet`) |
| **MAP_USR_02** | `UserMapper.mapRoles` | `roles = [Role("USER"), Role("ADMIN")]` | Trả về `Set.of("USER", "ADMIN")` |
| **MAP_USR_03** | `UserMapper.toAdminUserResponse` | User không có ví (`wallet = null`) | `balance = BigDecimal.ZERO` |
| **MAP_USR_04** | `UserMapper.toAdminUserResponse` | User có ví với số dư 50,000 | `balance = 50000` |
| **MAP_CRS_01** | `CourseMapper.toDetailResponse` | CourseEntity đầy đủ quan hệ | Mapping chính xác title, price, chapters |
| **MAP_CRT_01** | `CartMapper.toCartResponse` | CartEntity có 3 CartItemEntity | CartResponse chứa 3 items |

---

## 4. Test Blueprint Mẫu: `UserMapperTest.java`

```java
package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.response.AdminUserResponse;
import com.thanhmila.codelearning.dto.response.UserResponse;
import com.thanhmila.codelearning.entity.auth.RoleEntity;
import com.thanhmila.codelearning.entity.enums.UserStatus;
import com.thanhmila.codelearning.entity.payment.WalletEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mapstruct.factory.Mappers;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("UserMapper Unit Tests")
class UserMapperTest {

    private final UserMapper userMapper = Mappers.getMapper(UserMapper.class);

    @Test
    @DisplayName("mapRoles: roles là null trả về Set rỗng")
    void mapRoles_NullRoles_ReturnsEmptySet() {
        Set<String> result = userMapper.mapRoles(null);
        assertThat(result).isNotNull().isEmpty();
    }

    @Test
    @DisplayName("mapRoles: roles hợp lệ trả về tập tên quyền")
    void mapRoles_ValidRoles_ReturnsRoleNames() {
        RoleEntity role1 = RoleEntity.builder().name("ROLE_USER").build();
        RoleEntity role2 = RoleEntity.builder().name("ROLE_ADMIN").build();

        Set<String> result = userMapper.mapRoles(Set.of(role1, role2));
        assertThat(result).containsExactlyInAnyOrder("ROLE_USER", "ROLE_ADMIN");
    }

    @Test
    @DisplayName("toAdminUserResponse: wallet là null thì balance mặc định là 0")
    void toAdminUserResponse_NullWallet_BalanceDefaultsToZero() {
        UserEntity user = UserEntity.builder()
                .id(1L)
                .username("john")
                .status(UserStatus.ACTIVE)
                .wallet(null)
                .build();

        AdminUserResponse response = userMapper.toAdminUserResponse(user);

        assertThat(response.getBalance()).isEqualTo(BigDecimal.ZERO);
        assertThat(response.getStatus()).isEqualTo("ACTIVE");
    }

    @Test
    @DisplayName("toAdminUserResponse: wallet có số dư thì lấy đúng số dư")
    void toAdminUserResponse_WithWallet_ReturnsCorrectBalance() {
        WalletEntity wallet = WalletEntity.builder().balance(new BigDecimal("150000")).build();
        UserEntity user = UserEntity.builder()
                .id(2L)
                .username("jane")
                .status(UserStatus.ACTIVE)
                .wallet(wallet)
                .build();

        AdminUserResponse response = userMapper.toAdminUserResponse(user);

        assertThat(response.getBalance()).isEqualTo(new BigDecimal("150000"));
    }
}
```
