import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://monifyapp.onrender.com/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  ApiService() {
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return Map<String, dynamic>.from(response.data as Map);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> post(String endpoint, dynamic data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return Map<String, dynamic>.from(response.data as Map);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return Map<String, dynamic>.from(response.data as Map);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return Map<String, dynamic>.from(response.data as Map);
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
    if (error is! DioException) {
      return 'Error desconocido: $error';
    }

    if (error.type == DioExceptionType.connectionTimeout) {
      return 'Tiempo de conexion agotado';
    }

    if (error.type == DioExceptionType.receiveTimeout) {
      return 'Tiempo de respuesta agotado';
    }

    if (error.type == DioExceptionType.cancel) {
      return 'Peticion cancelada';
    }

    if (error.type == DioExceptionType.badResponse) {
      final data = error.response?.data;

      if (data is Map<String, dynamic>) {
        if (data['message'] != null) {
          return data['message'].toString();
        }

        if (data['detail'] != null) {
          return data['detail'].toString();
        }

        if (data['error'] != null) {
          return data['error'].toString();
        }

        if (data['errors'] != null) {
          return data['errors'].toString();
        }

        return 'Error del servidor';
      }

      if (data is String) {
        return data;
      }

      return 'Error del servidor';
    }

    return 'Error de conexion: ${error.message}';
  }
}
