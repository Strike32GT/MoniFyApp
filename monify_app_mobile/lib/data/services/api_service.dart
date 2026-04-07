
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl : 'https://monifyapp.onrender.com/api',
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
  ));

  ApiService() {
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }


  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }


  Future<Map<String, dynamic>> post(String endpoint, dynamic data) async {
    try {
      final response = await _dio.post(endpoint, data : data);
      return response.data;
    }catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }


  Future<Map<String,dynamic>> delete (String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }



  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  String _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return 'Tiempo de conexión agotado';
        case DioExceptionType.receiveTimeout:
          return 'Tiempo de respuesta agotado';
        case DioExceptionType.badResponse:
          return error.response?.data['message'] ?? 'Error del servidor';
        case DioExceptionType.cancel:
          return 'Petición cancelada';
        default:
          return 'Error de conexión: ${error.message}';
      }
    }
    return 'Error desconocido: $error';
  }
}


