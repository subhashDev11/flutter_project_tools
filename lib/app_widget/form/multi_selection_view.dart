import 'package:flutter_project_tools/app_widget/app_widgets.dart';
import 'package:flutter/material.dart';

class MultiSelectionView extends StatefulWidget {
  const MultiSelectionView({
    Key? key,
    required this.items,
    required this.onValueChanged,
    required this.label,
  }) : super(key: key);

  final List<String> items;
  final ValueChanged<List<String>> onValueChanged;
  final String label;

  @override
  State<MultiSelectionView> createState() => _MultiSelectionViewState();
}

class _MultiSelectionViewState extends State<MultiSelectionView> {
  final selectedValueNotifier = ValueNotifier(<String>[]);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          title: widget.label,
        ),
        ValueListenableBuilder(
            valueListenable: selectedValueNotifier,
            builder: (_, selectedValueNotifier, child) => Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  spacing: 5,
                  children: widget.items.map((e) {
                    return Row(mainAxisSize: MainAxisSize.min, children: [
                      AppText(
                        title: e,
                      ),
                      Checkbox(
                        value: selectedValueNotifier.contains(e),
                        onChanged: (value) {
                          if (value == null) return;
                          if (value) {
                            if (selectedValueNotifier.asMap().containsKey(e)) {
                            } else {
                              selectedValueNotifier.add(e);
                            }
                          } else {
                            selectedValueNotifier.remove(e);
                          }
                          widget.onValueChanged(selectedValueNotifier);
                        },
                        fillColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                      )
                    ]);
                  }).toList(),
                )),
      ],
    );
  }
}
