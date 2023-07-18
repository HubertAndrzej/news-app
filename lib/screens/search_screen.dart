import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:news_app/constants/variables.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/article_widget.dart';
import 'package:news_app/widgets/empty_news_widget.dart';
import 'package:news_app/widgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<NewsModel>? _searchList = [];
  bool _isSearching = false;

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
    final NewsProvider newsProvider = Provider.of<NewsProvider>(context);

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
                        onEditingComplete: () async {
                          _searchList = await newsProvider.searchNewsProvider(
                            query: _searchTextController.text,
                          );
                          _isSearching = true;
                          _focusNode.unfocus();
                          setState(() {});
                        },
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
                                _isSearching = false;
                                _searchList!.clear();
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
              if (!_isSearching && _searchList!.isEmpty)
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
                          onTap: () async {
                            _searchTextController.text = searchKeywords[index];
                            _searchList = await newsProvider.searchNewsProvider(
                              query: _searchTextController.text,
                            );
                            _isSearching = true;
                            setState(() {});
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(color: color),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                child: FittedBox(
                                  child: Text(
                                    searchKeywords[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              if (_isSearching && _searchList!.isEmpty)
                const Expanded(
                  child: EmptyNewsWidget(
                    text: 'Ops! No result found',
                    imagePath: 'assets/images/search.png',
                  ),
                ),
              if (_searchList != null && _searchList!.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: _searchList!.length,
                    itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                      value: _searchList![index],
                      child: const ArticleWidget(),
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
