import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:news_app/constants/variables.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/vertical_spacing_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    if (mounted) {
      _searchTextController.dispose();
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context: context).getColor;

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _focusNode.unfocus();
                        Navigator.pop(context);
                      },
                      child: const Icon(IconlyLight.arrowLeft2),
                    ),
                    Flexible(
                      child: TextField(
                        focusNode: _focusNode,
                        controller: _searchTextController,
                        style: TextStyle(color: color),
                        autofocus: true,
                        textInputAction: TextInputAction.search,
                        keyboardType: TextInputType.text,
                        onEditingComplete: () {},
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 2),
                          hintText: 'Search...',
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffix: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: GestureDetector(
                              onTap: () {
                                _searchTextController.clear();
                                _focusNode.unfocus();
                                setState(() {});
                              },
                              child: const Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const VerticalSpacingWidget(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: MasonryGridView.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemCount: searchKeywords.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(color: color),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              searchKeywords[index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
