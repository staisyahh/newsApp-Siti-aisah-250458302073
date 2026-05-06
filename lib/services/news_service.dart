import 'dart:convert';

import 'package:news_app/models/news_response.dart';
import 'package:news_app/utils/constant.dart';
import 'package:http/http.dart' as http;

// service ini buat ngambil data dari api
// nanti bakall panggl ke news controller buat diolah terus ditampilin ke ui
class NewsService {
  static const String _baseUrl = Constants.baseUrl;
  static final String _apiKey = Constants.apiKey;

// buat ngambil berita terbaru/
  Future<NewsResponse> getTopHeadlines({
    String country = Constants.defaultCountry, // default negara
    String? category, // ? kalo kosong gapapa, kategori optional
    int page = 1, // halaman pertama
    int pageSize = 20, // jumlah berita per halaman
  }) async {
    try {
      final Map<String, String> queryParams = {
        'apiKey': _apiKey,
        'country': country,
        'page': page.toString(),
        'pageSize': pageSize.toString(),
      };

      if (category != null && category.isNotEmpty) { 
        queryParams['category'] = category;
      }

      // ini buat bikin url request ke api dengan parameter yang udah kita siapin
      final uri = Uri.parse('$_baseUrl${Constants.topHeadlines}').replace(queryParameters: queryParams);
      final Response = await http.get(uri);
      if (Response.statusCode == 200) {
        return NewsResponse.fromJson(jsonDecode(Response.body));
      } else {
        throw Exception('Failed to load news: ${Response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }

  // function buat search
  Future<NewsResponse> searchNews({
    required String query,
    int page = 1,
    int pageSize = 20,
    String ?sortBy,
  }) async{
    try{ 
       final Map<String, String> queryParams = {
        'apiKey': _apiKey,
        'q': query,
        'page': page.toString(),
        'pageSize': pageSize.toString(),
      };

      if (sortBy != null && sortBy.isNotEmpty) {
        queryParams['sortBy'] = sortBy;
      }

      final uri = Uri.parse('$_baseUrl${Constants.everything}').replace(queryParameters: queryParams);
      final Response = await http.get(uri);
      if (Response.statusCode == 200) {
        return NewsResponse.fromJson(jsonDecode(Response.body));
      } else {
        throw Exception('Failed to load news: ${Response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching news: $e');
    }
  }
}