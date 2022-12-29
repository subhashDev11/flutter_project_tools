import 'package:flutter/material.dart';
import 'common_widgets.dart';

class AppSearchBarView extends StatefulWidget {
  const AppSearchBarView({Key? key, required this.hinText, this.onSearchTap, this.onSearchClear, this.onSearchChanged})
      : super(key: key);

  final String hinText;
  final Function(String? value)? onSearchTap;
  final Function(String? value)? onSearchClear;
  final Function(String? value)? onSearchChanged;

  @override
  State<AppSearchBarView> createState() => _AppSearchBarViewState();
}

class _AppSearchBarViewState extends State<AppSearchBarView> {
  final searchTextController = ValueNotifier<TextEditingController>(TextEditingController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ShadowChildView(
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 50,
        ),
        child: TextFormField(
          controller: searchTextController.value,
          textInputAction: TextInputAction.search,
          style: theme.textTheme.titleSmall,
          onChanged: widget.onSearchChanged ??
              (String? value) {
                if (value == null || value.isEmpty) {
                  if (widget.onSearchClear != null) {
                    widget.onSearchClear!('');
                  }
                }
              },
          onFieldSubmitted: (String? value) {
            if (widget.onSearchTap != null) {
              widget.onSearchTap!(value);
            }
          },
          onSaved: (String? value) {
            if (widget.onSearchTap != null) {
              widget.onSearchTap!(value);
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchTextController.value.dispose();
    searchTextController.dispose();
    super.dispose();
  }
}
