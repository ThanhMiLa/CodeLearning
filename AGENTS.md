# Repository Guidelines

## Project Structure & Module Organization

This monorepo contains a React client and a Spring Boot API. `frontend/src/` holds the Vite application: route-level views live in `pages/`, shared UI in `components/`, HTTP clients in `api/`, and shared types/utilities in `types/` and `utils/`. Static assets belong in `frontend/public/` or `frontend/src/assets/`.

The backend source is under `backend/src/main/java/com/thanhmila/codelearning/`. Keep the layered arrangement: domain-specific `controller/`, `service/`, `repository/`, `entity/`, `dto/`, and `mapper/` packages. Runtime configuration is in `backend/src/main/resources/`. The database schema reference is `database/schema-only.sql`; architecture notes are in `backend/docs/`.

## Technology Stack

### Frontend

- React `19.2.6` with TypeScript `~6.0.2`
- Vite `8.0.12` and Tailwind CSS `4.3.1`
- React Router `7.17.0`, Axios `1.18.0`, and i18next `26.3.1`
- Monaco Editor for the code editor; SockJS and STOMP for real-time WebSocket updates

### Backend

- Java `21` and Spring Boot `3.5.7`
- Spring MVC, Spring Data JPA, Spring Security, and OAuth2 Resource Server
- Spring WebFlux (`WebClient`) for asynchronous external calls and Spring WebSocket with STOMP
- MapStruct `1.5.5.Final`, Lombok, and Maven Wrapper (`./mvnw`)

### Infrastructure and Integrations

- PostgreSQL `15` for the primary application database; PostgreSQL `16.2` for Judge0
- Redis `7` for caching, rate limiting, and Online Judge progress counters
- RabbitMQ `3` for asynchronous email processing
- Judge0 `1.13.1` for sandboxed code execution
- Docker Compose for local and production orchestration
- PayOS for payments, SendGrid for email delivery, and Cloudinary for media storage

## Build, Test, and Development Commands

- `cd frontend && npm run dev` starts the Vite development server.
- `cd frontend && npm run lint` runs ESLint over TypeScript and TSX files.
- `cd frontend && npm run build` type-checks and creates the production bundle in `frontend/dist/`.
- `cd backend && ./mvnw spring-boot:run` starts the API (requires Java 21 and configured services/environment).
- `cd backend && ./mvnw test` compiles and runs Maven tests; use it before backend changes even though no committed test source set currently exists.
- `docker compose -f docker-compose.dev.yml up` starts local PostgreSQL, Redis, and RabbitMQ. Add `--profile backend`, `frontend`, or `judge0` when needed.

## Coding Style & Naming Conventions

Use the existing style: TypeScript uses 2-space indentation, single quotes, semicolons, and PascalCase React component filenames (for example, `ContestWorkspace.tsx`). Keep hooks and utilities camelCase. ESLint configuration is `frontend/eslint.config.js`; resolve lint findings rather than disabling rules broadly.

Java uses 4-space indentation and standard Spring naming: `*Controller`, `*Service`, `*ServiceImpl`, `*Repository`, `*Entity`, and request/response DTO suffixes. Prefer MapStruct mappers and Lombok patterns already used by adjacent code. Do not commit secrets from `backend/.env` or production configuration.

## High-Risk Domain Rules

- Preserve PayOS webhook signature verification, idempotency, and transaction locking when changing payment, wallet, or order flows.
- Preserve asynchronous Judge0 processing, WebSocket status updates, and Redis progress/cleanup behavior when changing Online Judge or contest flows.
- When changing user-visible frontend text, update both `frontend/src/locales/vi.json` and `frontend/src/locales/en.json`.
- Treat role-based authorization, JWT refresh-token rotation, and rate limiting as security-sensitive behavior; do not weaken them without explicit justification and tests.

## Testing Guidelines

Add focused tests alongside new backend behavior under `backend/src/test/java/`, named `*Test.java`. For frontend changes, at minimum run `npm run lint` and `npm run build`; introduce a test framework and matching `*.test.ts(x)` files when adding nontrivial client logic.

## Commit & Pull Request Guidelines

Follow the repository `commit` skill: use `<type>: <main change>` with a Conventional Commit type such as `feat`, `fix`, `refactor`, or `chore`. Keep commits small and imperative. Add a bullet-list body only when important supporting changes need review context. Pull requests should summarize the user-facing effect, note configuration or schema changes, link the relevant issue, list validation commands run, and include screenshots for visual frontend changes.
