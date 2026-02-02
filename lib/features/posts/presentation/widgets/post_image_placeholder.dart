import 'package:flutter/material.dart';
import '../../../../core/theme/app_dimens.dart';

/// Reusable gradient placeholder for post content (image area).
/// Used in post card and post detail screen.
class PostImagePlaceholder extends StatelessWidget {
  final double? height;

  const PostImagePlaceholder({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveHeight = height ?? AppDimens.postImageHeight;

    return Container(
      width: double.infinity,
      height: effectiveHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
            theme.colorScheme.secondaryContainer.withValues(alpha: 0.3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: height != null ? AppBorderRadius.allM : null,
      ),
      child: Center(
        child: Icon(
          Icons.article_outlined,
          size: AppDimens.iconXXL,
          color: theme.colorScheme.primary.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
