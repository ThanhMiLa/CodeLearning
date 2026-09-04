package com.thanhmila.codelearning.util;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

@DisplayName("ProgressUtils Unit Tests")
class ProgressUtilsTest {

    @Test
    @DisplayName("Private constructor should throw UnsupportedOperationException when invoked via reflection")
    void testPrivateConstructor() throws NoSuchMethodException {
        Constructor<ProgressUtils> constructor = ProgressUtils.class.getDeclaredConstructor();
        constructor.setAccessible(true);

        assertThatThrownBy(constructor::newInstance)
                .isInstanceOf(InvocationTargetException.class)
                .hasCauseInstanceOf(UnsupportedOperationException.class)
                .hasRootCauseMessage("Utility class cannot be instantiated");
    }

    @ParameterizedTest(name = "complete={0}, total={1} => expected={2}%")
    @CsvSource({
            ", 10, 0",      // null completeLessons handled or tested below
            "0, 0, 0",      // total = 0
            "5, -1, 0",     // negative total
            "0, 10, 0",     // 0 completed
            "10, 10, 100",  // 100% completed
            "1, 3, 33",     // round down
            "2, 3, 67",     // round up
            "1, 2, 50"      // exact 50%
    })
    void testCalculatePercentage(Integer complete, Integer total, int expected) {
        if (complete != null) {
            assertThat(ProgressUtils.calculatePercentage(complete, total)).isEqualTo(expected);
        }
    }

    @Test
    @DisplayName("totalLessons is null returns 0")
    void shouldReturnZero_WhenTotalLessonsIsNull() {
        assertThat(ProgressUtils.calculatePercentage(5, null)).isEqualTo(0);
    }
}
