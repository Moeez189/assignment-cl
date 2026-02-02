import 'package:flutter/material.dart';
import '../../../../core/theme/app_dimens.dart';

/// Reusable author header: avatar (initial) + name + optional subtitle.
/// Used in post card (small) and post detail (medium).
enum AuthorRowSize {
  small,
  medium,
}

/// Widget displaying author avatar and name with optional subtitle.
class AuthorRow extends StatelessWidget {
  final String authorName;
  final String? subtitle;
  final AuthorRowSize size;

  const AuthorRow({
    super.key,
    required this.authorName,
    this.subtitle,
    this.size = AuthorRowSize.small,
  });

  double get _avatarRadius {
    switch (size) {
      case AuthorRowSize.small:
        return AppDimens.avatarS / 2;
      case AuthorRowSize.medium:
        return AppDimens.avatarM / 2;
    }
  }

  TextStyle? _titleStyle(BuildContext context) {
    final theme = Theme.of(context);
    switch (size) {
      case AuthorRowSize.small:
        return theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
        );
      case AuthorRowSize.medium:
        return theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        CircleAvatar(
          radius: _avatarRadius,
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Text(
            authorName.isNotEmpty ? authorName[0].toUpperCase() : '?',
            style: TextStyle(
              color: theme.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
              fontSize: size == AuthorRowSize.small ? null : 18,
            ),
          ),
        ),
        SizedBox(width: AppDimens.paddingM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                authorName,
                style: _titleStyle(context),
              ),
              if (subtitle != null && subtitle!.isNotEmpty)
                Text(
                  subtitle!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
