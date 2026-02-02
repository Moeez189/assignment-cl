import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/loading_view.dart';
import '../providers/posts_provider.dart';
import '../providers/posts_state.dart';
import '../widgets/author_row.dart';
import '../widgets/empty_state.dart';
import '../widgets/post_image_placeholder.dart';

/// Post detail screen
class PostDetailScreen extends ConsumerWidget {
  final int postId;

  const PostDetailScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsState = ref.watch(postsNotifierProvider);
    final theme = Theme.of(context);

    if (postsState.status == PostsStatus.loading && postsState.posts.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Post Details')),
        body: const LoadingView(message: 'Loading post...'),
      );
    }

    final matches = postsState.posts.where((p) => p.post.id == postId).toList();
    final postWithUser = matches.isEmpty ? null : matches.first;

    if (postWithUser == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Post Details')),
        body: const EmptyState(
          title: 'Post not found',
          subtitle: 'This post may have been removed or the link is invalid.',
          icon: Icons.article_outlined,
        ),
      );
    }

    final isBookmarked = postsState.bookmarkedIds.contains(postId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(postsNotifierProvider.notifier).toggleBookmark(postId);
            },
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? AppColors.bookmarkActive : null,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppPadding.allL,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthorRow(
              authorName: postWithUser.authorName,
              subtitle: postWithUser.user?.email,
              size: AuthorRowSize.medium,
            ),
            const SizedBox(height: AppDimens.paddingXXL),
            PostImagePlaceholder(height: AppDimens.postDetailImageHeight),
            const SizedBox(height: AppDimens.paddingXXL),
            Text(
              postWithUser.post.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimens.paddingL),
            Divider(color: theme.colorScheme.outlineVariant),
            const SizedBox(height: AppDimens.paddingL),
            Text(
              postWithUser.post.body,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.6,
              ),
            ),
            const SizedBox(height: AppDimens.paddingXXL),
            Chip(
              avatar: const Icon(Icons.tag, size: 16),
              label: Text('Post #$postId'),
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
            ),
          ],
        ),
      ),
    );
  }
}
