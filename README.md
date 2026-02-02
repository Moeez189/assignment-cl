# Posts App – Flutter Proof of Concept

A simple Flutter mobile app that fetches posts and users from [JSONPlaceholder](https://jsonplaceholder.typicode.com/), displays them in an Instagram-like list, and supports filtering by title and persistent bookmarks.

## Prerequisites

- **Flutter** (stable channel)
- **Dart** 3.6+

## How to Run

1. Clone the repository (or unpack the ZIP).
2. From the project root, install dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app on a device or emulator:

   ```bash
   flutter run
   ```

4. **(Optional)** If you change any Freezed/JSON models, regenerate code:

   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

## Project Structure

The app uses a **feature-first** layout with a shared **core**:

```
lib/
├── main.dart                 # Entry point: ProviderScope, SharedPreferences override, MyApp
├── core/                     # Shared infrastructure (no feature logic)
│   ├── constants/            # API base URL, storage keys
│   ├── mixins/               # Reusable behavior (loading, snackbar, validation)
│   ├── network/              # Dio client, ApiResult
│   ├── router/               # go_router config, route paths
│   ├── theme/                # Colors, dimensions, text styles, light/dark theme
│   ├── usecases/             # Base UseCase / UseCaseNoParams
│   ├── utils/                # AppLogger
│   └── widgets/              # Shared UI (e.g. LoadingView)
└── features/
    └── posts/
        ├── data/             # Implementation layer
        │   ├── datasources/   # Remote (Dio), Local (SharedPreferences)
        │   ├── models/        # Freezed + json_serializable
        │   └── repositories/  # PostRepositoryImpl
        ├── domain/            # Business logic (no Flutter)
        │   ├── entities/      # Post, User
        │   ├── repositories/  # PostRepository interface
        │   └── usecases/      # GetPosts, GetUsers, GetBookmarks, Add/RemoveBookmark
        └── presentation/
            ├── providers/     # Riverpod providers, PostsNotifier, PostsState
            ├── screens/       # Posts, Bookmarks, Post detail
            └── widgets/       # PostCard, SearchBar, EmptyState, ErrorView, AuthorRow, etc.
```

**Code review:** For a structured walkthrough with the client (architecture, API handling, state, testing, UI), see [CODE_REVIEW.md](CODE_REVIEW.md).

## Architecture

### Layers

- **`core`** – Shared code: theme, router, network (Dio), constants, base use cases, logger, shared widgets.
- **`data`** – Datasources (remote API, local bookmarks), models (Freezed + json_serializable), repository implementation.
- **`domain`** – Entities, repository interface, use cases. No Flutter or data-layer imports.
- **`presentation`** – Screens, widgets, Riverpod providers and state.

**Data flow:** UI → Provider (StateNotifier) → Use cases → Repository → Datasources.

### API and User Handling

- **Endpoints:** `GET /posts` and `GET /users` from `https://jsonplaceholder.typicode.com`.
- **Strategy:** Posts and users are fetched **in parallel** with `Future.wait` in `PostsNotifier.fetchPosts()`. A single `userId → User` map is built from the users list. Each post is combined with `userMap[post.userId]` into a `PostWithUser`; author name is `user?.name ?? 'Unknown Author'`. One round-trip for posts and one for users; no N+1.
- **State:** Riverpod `StateNotifier` holds `PostsState` (Freezed). Filtering by **title** (search) and **bookmarks** (show bookmarked only) is done in derived getters `filteredPosts` and `bookmarkedPosts`.

### Bookmarks

- Bookmarked post IDs are stored in **SharedPreferences** and loaded at app start with posts. Each `PostWithUser` gets `isBookmarked` from this set. Toggling a bookmark updates SharedPreferences and in-memory state so the UI stays in sync and bookmarks persist across restarts.

### State Management

- **Riverpod** for dependency injection and state. **StateNotifier + Freezed** for the posts feature (status, posts, bookmarked IDs, search query, show-bookmarks-only). Loading, error, and loaded states are handled in the UI (LoadingView, ErrorView with retry, list with pull-to-refresh).

## Testing

Run all tests:

```bash
flutter test
```

Tests cover: state getters (filteredPosts, bookmarkedPosts), use cases (mocked repository), repository impl (mocked datasources), PostsNotifier (mocked use cases), and a widget smoke test (app bar title) with a fake remote datasource so no real network calls are made.
