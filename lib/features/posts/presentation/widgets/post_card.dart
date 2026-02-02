import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../providers/posts_state.dart';
import 'author_row.dart';
import 'post_image_placeholder.dart';

/// Widget representing a single post card (Instagram-like style).
/// Uses [AuthorRow] and [PostImagePlaceholder] for consistency with detail screen.
class PostCard extends StatelessWidget {
  final PostWithUser postWithUser;
  final VoidCallback onBookmarkTap;
  final VoidCallback? onTap;

  const PostCard({
    super.key,
    required this.postWithUser,
    required this.onBookmarkTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimens.postCardMarginH,
        vertical: AppDimens.postCardMarginV,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppBorderRadius.allM,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppPadding.allM,
              child: AuthorRow(
                authorName: postWithUser.authorName,
                subtitle: postWithUser.user?.username != null
                    ? '@${postWithUser.user!.username}'
                    : null,
                size: AuthorRowSize.small,
              ),
            ),
            const PostImagePlaceholder(),

            // Action buttons
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.paddingS,
                vertical: AppDimens.paddingXS,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onBookmarkTap,
                    icon: Icon(
                      postWithUser.isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color:
                          postWithUser.isBookmarked
                              ? AppColors.bookmarkActive
                              : null,
                    ),
                  ),
                  if (postWithUser.isBookmarked)
                    Text(
                      'Saved',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.bookmarkActive,
                      ),
                    ),
                ],
              ),
            ),

            // Post title
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimens.paddingL,
                0,
                AppDimens.paddingL,
                AppDimens.paddingS,
              ),
              child: Text(
                postWithUser.post.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Post body preview
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimens.paddingL,
                0,
                AppDimens.paddingL,
                AppDimens.paddingL,
              ),
              child: Text(
                postWithUser.post.body,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
