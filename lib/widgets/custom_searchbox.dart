import 'package:flutter/material.dart';

class CustomSearchBox extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onEditingComplete;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;

  const CustomSearchBox(
      {super.key,
      required this.controller,
      required this.onEditingComplete,
      this.onTap,
      this.onChanged,
      this.focusNode});

  @override
  State<CustomSearchBox> createState() => _CustomSearchBoxState();
}

class _CustomSearchBoxState extends State<CustomSearchBox> {
  bool isEditing = false;

  void onChanges(String value) {
    setState(() {
      if (widget.onChanged != null) {
        widget.onChanged!(value);
      }
      if (widget.controller.text.isEmpty) {
        isEditing = false;
      } else {
        isEditing = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          SizedBox(
            height: 40,
            child: TextField(
                focusNode: widget.focusNode,
                controller: widget.controller,
                onEditingComplete: () {
                  if (widget.controller.text.isEmpty) {
                    return;
                  }
                  isEditing = false;
                  widget.onEditingComplete(widget.controller.text);
                },
                onChanged: (value) {
                  onChanges(value);
                },
                onTap: () {
                  if (widget.onTap != null) {
                    widget.onTap!();
                  }
                  onChanges(widget.controller.text);
                },
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(
                  fillColor: Colors.grey[100],
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 20,
                    color: Color(0xFF02BC77),
                  ),
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  contentPadding: const EdgeInsets.fromLTRB(0, 5, 40, 5),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.grey[200]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.grey[200]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.grey[200]!),
                  ),
                  // labelText: 'Search',
                  // labelStyle: TextStyle(color: Colors.black),
                ),
                cursorColor: Colors.black,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    overflow: TextOverflow.fade)),
          ),
          isEditing == true
              ? Positioned(
                  right: 1,
                  top: -4,
                  child: IconButton(
                      onPressed: () {
                        widget.controller.clear();
                        onChanges(widget.controller.text);
                      },
                      icon: const Icon(Icons.close,
                          size: 20, color: Colors.grey)))
              : const SizedBox(),
        ],
      ),
    );
  }
}
