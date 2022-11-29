import 'dart:convert';
import 'package:http/http.dart' as http;

class GeneralCryptoApi {
  // Get General Crypto Market Stats
  Future getCryptoMarketGeneralView() async {
    final uri = Uri.https('www.coingecko.p.rapidapi.com', '/global');
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host': 'coingecko.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      throw Exception('Failed to load');
    }
  }

  //Get Crypto MarketCap
  Future getCryptoMarketCap() async {
    final uri = Uri.https('www.coinpaprika1.p.rapidapi.com', '/global');
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host': 'coinpaprika1.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      throw Exception('Failed to load');
    }
  }

  // Get Crypto Daily Fear Index
  Future getDailyFearIndex() async {
    final uri = Uri.https('www.crypto-ranking-data.p.rapidapi.com', '/fng');
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host': 'crypto-ranking-data.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      throw Exception('Failed to load');
    }
  }

  // Get Crypto Weekly Fear Index
  Future getWeeklyFearIndex() async {
    final uri = Uri.https('www.crypto-ranking-data.p.rapidapi.com', '/fng/7');
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host': 'crypto-ranking-data.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      throw Exception('Failed to load');
    }
  }

  // Get Crypto Monthly Fear Index
  Future getMonthlyFearIndex() async {
    final uri = Uri.https('www.crypto-ranking-data.p.rapidapi.com', '/fng/30');
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host': 'crypto-ranking-data.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      throw Exception('Failed to load');
    }
  }

  //Get Crypto Top Gainers And Losers
  Future getTopGainersAndLosers() async {
    final uri = Uri.https(
        'www.crypto-update-live.p.rapidapi.com', '/top-gainers-losers');
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host': 'crypto-update-live.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      throw Exception('Failed to load');
    }
  }

  Future getTop1000CoinsByMarketCap() async {
    final queryParameters = {
      'vs_currency': 'usd',
      'page': '1',
      'per_page': '1000',
      'order': 'market_cap_desc'
    };

    final uri = Uri.https(
      'www.coingecko.p.rapidapi.com',
      '/coins/markets',
      queryParameters,
    );
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host': 'coingecko.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      throw Exception('Failed to load');
    }
  }

  Future getCoinData(String id) async {
    final queryParameters = {
      'localization': 'true',
      'tickers': 'true',
      'market_data': 'true',
      'community_data': 'true',
      'developer_data': 'true',
      'sparkline': 'false'
    };

    final uri = Uri.https(
      'www.coingecko.p.rapidapi.com',
      '/coins/$id',
      queryParameters,
    );
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host': 'coingecko.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      throw Exception('Failed to load');
    }
  }

  Future getAllCoins1() async {
    final queryParameters = {
      'vs_currency': 'usd',
      'page': '1',
      'per_page': '200',
      'order': 'market_cap_desc'
    };

    final uri = Uri.https(
      'www.coingecko.p.rapidapi.com',
      '/coins/markets',
      queryParameters,
    );
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host': 'coingecko.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      throw Exception('Failed to load');
    }
  }

  Future getAllCoins2() async {
    final queryParameters = {
      'vs_currency': 'usd',
      'page': '2',
      'per_page': '200',
      'order': 'market_cap_desc'
    };

    final uri = Uri.https(
      'www.coingecko.p.rapidapi.com',
      '/coins/markets',
      queryParameters,
    );
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host': 'coingecko.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      throw Exception('Failed to load');
    }
  }

  Future getAllCoins3() async {
    final queryParameters = {
      'vs_currency': 'usd',
      'page': '3',
      'per_page': '200',
      'order': 'market_cap_desc'
    };

    final uri = Uri.https(
      'www.coingecko.p.rapidapi.com',
      '/coins/markets',
      queryParameters,
    );
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host': 'coingecko.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      throw Exception('Failed to load');
    }
  }

  Future getAllCoins4() async {
    final queryParameters = {
      'vs_currency': 'usd',
      'page': '4',
      'per_page': '200',
      'order': 'market_cap_desc'
    };

    final uri = Uri.https(
      'www.coingecko.p.rapidapi.com',
      '/coins/markets',
      queryParameters,
    );
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host': 'coingecko.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      throw Exception('Failed to load');
    }
  }

  Future getAllCoins5() async {
    final queryParameters = {
      'vs_currency': 'usd',
      'page': '5',
      'per_page': '200',
      'order': 'market_cap_desc'
    };

    final uri = Uri.https(
      'www.coingecko.p.rapidapi.com',
      '/coins/markets',
      queryParameters,
    );
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host': 'coingecko.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      throw Exception('Failed to load');
    }
  }

  Future getAllCoins6() async {
    final queryParameters = {
      'vs_currency': 'usd',
      'page': '6',
      'per_page': '200',
      'order': 'market_cap_desc'
    };

    final uri = Uri.https(
      'www.coingecko.p.rapidapi.com',
      '/coins/markets',
      queryParameters,
    );
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host': 'coingecko.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      throw Exception('Failed to load');
    }
  }

  Future getAllCoins7() async {
    final queryParameters = {
      'vs_currency': 'usd',
      'page': '7',
      'per_page': '200',
      'order': 'market_cap_desc'
    };

    final uri = Uri.https(
      'www.coingecko.p.rapidapi.com',
      '/coins/markets',
      queryParameters,
    );
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host': 'coingecko.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      throw Exception('Failed to load');
    }
  }

  Future getAllCoins8() async {
    final queryParameters = {
      'vs_currency': 'usd',
      'page': '8',
      'per_page': '200',
      'order': 'market_cap_desc'
    };

    final uri = Uri.https(
      'www.coingecko.p.rapidapi.com',
      '/coins/markets',
      queryParameters,
    );
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host': 'coingecko.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      throw Exception('Failed to load');
    }
  }

  Future getAllCoins9() async {
    final queryParameters = {
      'vs_currency': 'usd',
      'page': '9',
      'per_page': '200',
      'order': 'market_cap_desc'
    };

    final uri = Uri.https(
      'www.coingecko.p.rapidapi.com',
      '/coins/markets',
      queryParameters,
    );
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host': 'coingecko.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      throw Exception('Failed to load');
    }
  }

  Future getAllCoins10() async {
    final queryParameters = {
      'vs_currency': 'usd',
      'page': '10',
      'per_page': '200',
      'order': 'market_cap_desc'
    };

    final uri = Uri.https(
      'www.coingecko.p.rapidapi.com',
      '/coins/markets',
      queryParameters,
    );
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host': 'coingecko.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      throw Exception('Failed to load');
    }
  }

  Future getExchanges() async {
    final uri = Uri.https('www.coingecko.p.rapidapi.com', '/exchanges');
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host': 'coingecko.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      //print('done');
      return jsonDecode(response.body);
    } else {
      //print('not done');
      throw Exception('Failed to load');
    }
  }

  Future getImportantCryptoNews() async {
    final uri = Uri.https('www.crypto-news16.p.rapidapi.com', '/news/top/50');
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host': 'crypto-news16.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      print(response.body);
      throw Exception('Failed to load');
    }
  }

  Future getTrendingCyptoMentions(String timeStamp) async {
    final queryParameters = {
      'social': 'twitter',
      'isCrypto': 'true',
      'timestamp': timeStamp,
      'limit': '10'
    };

    final uri = Uri.https(
        'www.finance-social-sentiment-for-twitter-and-stocktwits.p.rapidapi.com',
        '/get-social-trending/posts',
        queryParameters);
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host':
          'finance-social-sentiment-for-twitter-and-stocktwits.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      print(response.body);
      throw Exception('Failed to load');
    }
  }

  Future getBullishCryptoMentions(String timeStamp) async {
    final queryParameters = {
      'social': 'twitter',
      'isCrypto': 'true',
      'timestamp': timeStamp,
      'limit': '10'
    };

    final uri = Uri.https(
        'www.finance-social-sentiment-for-twitter-and-stocktwits.p.rapidapi.com',
        '/get-sentiment-trending/bullish',
        queryParameters);
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host':
          'finance-social-sentiment-for-twitter-and-stocktwits.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      print(response.body);
      throw Exception('Failed to load');
    }
  }

  Future getBearishCryptoMentions(String timeStamp) async {
    final queryParameters = {
      'social': 'twitter',
      'isCrypto': 'true',
      'timestamp': timeStamp,
      'limit': '10'
    };

    final uri = Uri.https(
        'www.finance-social-sentiment-for-twitter-and-stocktwits.p.rapidapi.com',
        '/get-sentiment-trending/bearish',
        queryParameters);
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host':
          'finance-social-sentiment-for-twitter-and-stocktwits.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      print(response.body);
      throw Exception('Failed to load');
    }
  }
}
