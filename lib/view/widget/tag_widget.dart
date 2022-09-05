import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TagsBuilder extends StatelessWidget {
  const TagsBuilder(
    this.tags, {
    Key? key,
    required this.onTagPressed,
  }) : super(key: key);

  final List<String> tags;
  final void Function(String value) onTagPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Wrap(
        spacing: 6,
        children: List.generate(
          tags.length,
          (index) => TagWidget(
            tag: tags[index],
            onPressed: () {
              onTagPressed(tags[index]);
            },
          ),
        ),
      ),
    );
  }
}

class TagWidget extends StatelessWidget {
  const TagWidget({
    Key? key,
    required this.tag,
    required this.onPressed,
  }) : super(key: key);

  final String tag;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.purple.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 8,
        ),
        child: Text(
          tag,
          style: Get.textTheme.headline6!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
