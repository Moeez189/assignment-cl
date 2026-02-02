import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/loading_view.dart';
import '../providers/posts_provider.dart';
import '../providers/posts_state.dart';
import '../widgets/post_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/empty_state.dart';
import '../widgets/error_view.dart';

/// Main screen displaying the list of posts
class PostsScreen extends ConsumerStatefulWidget {
  const PostsScreen({super.key});

  @override
  ConsumerState<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends ConsumerState<PostsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch posts when screen loads
    Future.microtask(() {
      ref.read(postsNotifierProvider.notifier).fetchPosts();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postsState = ref.watch(postsNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        elevation: 0,
        actions: [
          // Navigate to bookmarks screen
          IconButton(
            onPressed: () {
              context.push(AppRoutes.bookmarks);
            },
            icon: Icon(Icons.bookmark, color: AppColors.bookmarkActive),
            tooltip: 'View Bookmarks',
          ),
          // Bookmark filter toggle
          IconButton(
            onPressed: () {
              ref
                  .read(postsNotifierProvider.notifier)
                  .toggleShowBookmarksOnly();
            },
            icon: Icon(
              postsState.showBookmarksOnly
                  ? Icons.filter_alt
                  : Icons.filter_alt_outlined,
              color:
                  postsState.showBookmarksOnly
                      ? theme.colorScheme.primary
                      : null,
            ),
            tooltip:
                postsState.showBookmarksOnly
                    ? 'Show all posts'
                    : 'Filter bookmarked only',
          ),
        ],
      ),
      body: Column(
        children: [
          // Bookmark filter indicator
          if (postsState.showBookmarksOnly)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.paddingL,
                vertical: AppDimens.paddingS,
              ),
              color: theme.colorScheme.primaryContainer,
              child: Row(
                children: [
                  Icon(
                    Icons.filter_alt,
                    size: AppDimens.iconS,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(width: AppDimens.paddingS),
                  Text(
                    'Showing bookmarked posts only',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      ref
                          .read(postsNotifierProvider.notifier)
                          .toggleShowBookmarksOnly();
                    },
                    child: const Text('Show All'),
                  ),
                ],
              ),
            ),

          // Search bar (single controller to avoid focus loss / cursor jump)
          PostSearchBar(
            controller: _searchController,
            onChanged: (query) {
              ref.read(postsNotifierProvider.notifier).updateSearchQuery(query);
              if (query.isEmpty) {
                _searchController.clear();
              }
            },
          ),

          // Content
          Expanded(child: _buildContent(postsState)),
        ],
      ),
    );
  }

  Widget _buildContent(PostsState postsState) {
    switch (postsState.status) {
      case PostsStatus.initial:
      case PostsStatus.loading:
        return const LoadingView(message: 'Loading posts...');

      case PostsStatus.error:
        return ErrorView(
          message: postsState.errorMessage ?? 'Unknown error occurred',
          onRetry: () {
            ref.read(postsNotifierProvider.notifier).fetchPosts();
          },
        );

      case PostsStatus.loaded:
        final filteredPosts = postsState.filteredPosts;

        if (filteredPosts.isEmpty) {
          if (postsState.searchQuery.isNotEmpty) {
            return EmptyState(
              title: 'No results found',
              subtitle: 'No posts match "${postsState.searchQuery}"',
              icon: Icons.search_off,
            );
          }
          if (postsState.showBookmarksOnly) {
            return const EmptyState(
              title: 'No bookmarks yet',
              subtitle: 'Bookmark posts to see them here',
              icon: Icons.bookmark_border,
            );
          }
          return EmptyState(
            title: 'No posts available',
            subtitle: 'Pull to refresh or tap retry',
            icon: Icons.inbox_outlined,
            onRetry: () {
              ref.read(postsNotifierProvider.notifier).fetchPosts();
            },
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await ref.read(postsNotifierProvider.notifier).fetchPosts();
          },
          child: ListView.builder(
            padding: AppPadding.postListPadding,
            itemCount: filteredPosts.length,
            itemBuilder: (context, index) {
              final postWithUser = filteredPosts[index];
              return PostCard(
                postWithUser: postWithUser,
                onBookmarkTap: () {
                  ref
                      .read(postsNotifierProvider.notifier)
                      .toggleBookmark(postWithUser.post.id);
                },
                onTap: () {
                  context.push(AppRoutes.postDetailPath(postWithUser.post.id));
                },
              );
            },
          ),
        );
    }
  }
}
