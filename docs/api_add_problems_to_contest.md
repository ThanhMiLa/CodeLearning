# API Design: Contest Problem Management (Add, Reorder, Delete)

This document outlines the API designs for managing problems within a contest (adding, reordering, and deleting problems).

---

## 1. Shared Business Rules

For all operations below, the following conditions must be satisfied:
1. **Authentication & Authorization:** The user must be authenticated. The user must have the `CONTEST_UPDATE_OWN` authority (or a similar admin privilege). The contest must exist, and the current user must be the teacher who created the contest. Otherwise, throw an `AppException(ErrorCode.ACCESS_DENIED)`.
2. **Contest Exists:** Check if the contest exists. If not, throw `AppException(ErrorCode.CONTEST_NOT_FOUND)`.
3. **Contest Status Condition:** The contest status must be **`UPCOMING`**. If the contest status is `RUNNING` or `ENDED`, modifications are forbidden; throw an `AppException(ErrorCode.INVALID_REQUEST)`.

---

## 2. API Endpoint 1: Add Problems to Contest

- **Endpoint:** `/contests/{id}/problems`
- **Method:** `POST`
- **Path Parameters:**
  - `id` (Long): The ID of the contest.
- **Request Body (JSON):**
  ```json
  {
    "problemIds": [10, 15, 23]
  }
  ```
- **Business Logic:**
  - Verify that the input list of `problemIds` is not empty.
  - Verify that every problem exists, has `problemScope = CONTEST`, `isActive = true`, and `isPublic = true`. If not, throw `AppException`.
  - Verify that no problem in the list is already in the contest.
  - Retrieve the current maximum `order_index` for this contest. Set the newly added problems' `order_index` to start at `max_order_index + 1` consecutively.
- **Response Body (Success - 200 OK):**
  ```json
  {
    "status": 200,
    "code": 200,
    "message": "Problems added to contest successfully",
    "result": null,
    "timestamp": "2026-06-12T03:00:00Z"
  }
  ```

---

## 3. API Endpoint 2: Reorder Problems in Contest

- **Endpoint:** `/contests/{id}/problems/reorder`
- **Method:** `PUT`
- **Path Parameters:**
  - `id` (Long): The ID of the contest.
- **Request Body (JSON):**
  A list of problem reorder entries:
  ```json
  [
    {
      "problemId": 10,
      "orderIndex": 2
    },
    {
      "problemId": 15,
      "orderIndex": 1
    }
  ]
  ```
- **Business Logic:**
  - Fetch all current problems associated with this contest.
  - Temporarily set the `order_index` of all these problems to a unique offset (e.g. `order_index = 10000 + i` or `orderIndex = problemId`) and flush changes. This avoids UNIQUE constraint (`uq_contest_problems_contest_order`) violations during intermediate updates.
  - Map the new `orderIndex` from the request to each corresponding problem.
  - Ensure all problems in the contest are accounted for and no invalid/non-existent `problemId` is present in the request.
  - Save the updated order indices.
- **Response Body (Success - 200 OK):**
  ```json
  {
    "status": 200,
    "code": 200,
    "message": "Contest problems reordered successfully",
    "result": null,
    "timestamp": "2026-06-12T03:00:00Z"
  }
  ```

---

## 4. API Endpoint 3: Delete Problem from Contest

- **Endpoint:** `/contests/{id}/problems/{problemId}`
- **Method:** `DELETE`
- **Path Parameters:**
  - `id` (Long): The ID of the contest.
  - `problemId` (Long): The ID of the problem to remove from the contest.
- **Business Logic:**
  - Verify that the problem association exists in the contest. If not, throw `AppException(ErrorCode.INVALID_REQUEST)`.
  - Delete the relation entry from the `contest_problems` table.
  - **Re-indexing:** To prevent gaps in the ordering (e.g., if problems had indices `1, 2, 3` and `2` was deleted), fetch the remaining problems ordered by their current `order_index`, and re-index them starting from `1` consecutively (`1, 2, ...`). Save the changes.
- **Response Body (Success - 200 OK):**
  ```json
  {
    "status": 200,
    "code": 200,
    "message": "Problem removed from contest successfully",
    "result": null,
    "timestamp": "2026-06-12T03:00:00Z"
  }
  ```
