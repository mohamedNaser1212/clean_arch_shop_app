import 'package:shop_app/Features/search_feature/data/search_model/search_data.dart';

class SearchDataList {
  final num? currentPage;
  final List<SearchProduct> data;
  final String? firstPageUrl;
  final num? from;
  final num? lastPage;
  final String? lastPageUrl;
  final dynamic nextPageUrl;
  final String? path;
  final num? perPage;
  final dynamic prevPageUrl;
  final num? to;
  final num? total;
  const SearchDataList({
    this.currentPage,
    required this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });
  factory SearchDataList.fromJson(Map<String, dynamic> json) {
    return SearchDataList(
      currentPage: json['current_page'],
      data: List<SearchProduct>.from(
          json['data'].map((x) => SearchProduct.fromJson(x))),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      nextPageUrl: json['next_page_url'],
    );
  }
}
