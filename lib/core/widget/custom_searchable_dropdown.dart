import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/core/theme/app_colors_context_extension.dart';
import 'package:flutter_template/core/widget/custom_dialog.dart';

class CustomSearchableDropdown<T> extends FormField<T> {
  CustomSearchableDropdown({
    super.key,
    T? value,
    String? hint,
    String? title,
    bool? disable,
    required List<DropDownItem> items,
    void Function(T?)? onChanged,
    EdgeInsetsGeometry? contentPadding,
    super.validator,
  }) : super(
          initialValue: value,
          builder: (FormFieldState<T> state) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (state.value != value) {
                state.didChange(value);
              }
            });

            return _CustomSearchableDropdownStateful<T>(
              key: key,
              value: state.value,
              hint: hint,
              title: title,
              disable: disable ?? false,
              items: items,
              onChanged: (newValue) {
                state.didChange(newValue);
                if (onChanged != null) {
                  onChanged(newValue);
                }
              },
              contentPadding: contentPadding,
              errorText: state.errorText,
            );
          },
        );
}

class _CustomSearchableDropdownStateful<T> extends StatefulWidget {
  const _CustomSearchableDropdownStateful({
    super.key,
    this.value,
    this.hint,
    this.title,
    required this.disable,
    required this.items,
    this.onChanged,
    this.contentPadding,
    this.errorText,
  });

  final T? value;
  final String? hint;
  final String? title;
  final bool disable;
  final List<DropDownItem> items;
  final void Function(T?)? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final String? errorText;

  @override
  State<_CustomSearchableDropdownStateful<T>> createState() =>
      _CustomSearchableDropdownState<T>();
}

class _CustomSearchableDropdownState<T>
    extends State<_CustomSearchableDropdownStateful<T>> {
  T? _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  void didUpdateWidget(
    covariant _CustomSearchableDropdownStateful<T> oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);
    // Detect external value change and update UI
    if (oldWidget.value != widget.value) {
      setState(() {
        _currentValue = widget.value;
      });
    }
  }

  void showFilter() {
    showDialog(
      context: context,
      builder: (context) {
        final searchController = TextEditingController();
        List<DropDownItem> filteredItems = widget.items;
        final theme = Theme.of(context);

        return CustomDialog(
          title: widget.title ?? '',
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              void filterItems(String value) {
                setDialogState(() {
                  filteredItems = widget.items
                      .where(
                        (item) => item.name.toLowerCase().contains(
                              value.toLowerCase(),
                            ),
                      )
                      .toList();
                });
              }

              return SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.6,
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(hint: Text('Search')),
                      onChanged: filterItems,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          return InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              setState(() {
                                _currentValue = item.value;
                              });
                              widget.onChanged?.call(item.value);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                item.name,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedName = widget.items
        .firstWhereOrNull((element) => element.value == _currentValue)
        ?.name;

    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: widget.disable ? null : showFilter,
          child: Container(
            padding: widget.contentPadding ??
                EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: context.appColors.background,
              borderRadius: BorderRadius.all(Radius.circular(6)),
              border: Border.all(
                color: widget.errorText != null
                    ? context.appColors.error
                    : context.appColors.neutralPalette.shade300.withValues(
                        alpha: 0.4,
                      ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    selectedName ?? widget.hint ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: widget.disable
                          ? Colors.grey
                          : selectedName == null
                              ? Colors.grey
                              : null,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: widget.disable ? Colors.grey : Colors.black54,
                ),
              ],
            ),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 12),
            child: Text(
              widget.errorText!,
              style: TextStyle(color: context.appColors.error, fontSize: 11),
            ),
          ),
      ],
    );
  }
}

class DropDownItem {
  final String name;
  final dynamic value;

  const DropDownItem({required this.name, required this.value});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DropDownItem &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => name.hashCode ^ value.hashCode;
}
