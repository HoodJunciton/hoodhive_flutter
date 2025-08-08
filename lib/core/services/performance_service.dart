import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class PerformanceService {
  static final Logger _logger = Logger();
  static final Map<String, DateTime> _startTimes = {};
  static final Map<String, List<Duration>> _metrics = {};

  // Start measuring performance for a specific operation
  static void startTrace(String traceName) {
    _startTimes[traceName] = DateTime.now();
    _logger.d('Started trace: $traceName');
  }

  // Stop measuring and record the duration
  static void stopTrace(String traceName) {
    final startTime = _startTimes[traceName];
    if (startTime == null) {
      _logger.w('No start time found for trace: $traceName');
      return;
    }

    final duration = DateTime.now().difference(startTime);
    _recordMetric(traceName, duration);
    _startTimes.remove(traceName);
    
    _logger.d('Stopped trace: $traceName, Duration: ${duration.inMilliseconds}ms');
  }

  // Measure the duration of a future operation
  static Future<T> measureAsync<T>(
    String traceName,
    Future<T> Function() operation,
  ) async {
    startTrace(traceName);
    try {
      final result = await operation();
      stopTrace(traceName);
      return result;
    } catch (e) {
      stopTrace(traceName);
      rethrow;
    }
  }

  // Measure the duration of a synchronous operation
  static T measureSync<T>(
    String traceName,
    T Function() operation,
  ) {
    startTrace(traceName);
    try {
      final result = operation();
      stopTrace(traceName);
      return result;
    } catch (e) {
      stopTrace(traceName);
      rethrow;
    }
  }

  // Record custom metrics
  static void recordMetric(String metricName, num value) {
    _logger.d('Metric: $metricName = $value');
    
    // In production, send to analytics service
    if (kReleaseMode) {
      _sendToAnalytics(metricName, value);
    }
  }

  // Record network request metrics
  static void recordNetworkMetric({
    required String endpoint,
    required String method,
    required int statusCode,
    required Duration duration,
    required int requestSize,
    required int responseSize,
  }) {
    final metricName = 'network_${method.toLowerCase()}_${endpoint.replaceAll('/', '_')}';
    _recordMetric(metricName, duration);
    
    _logger.d('''
Network Metric:
  Endpoint: $method $endpoint
  Status: $statusCode
  Duration: ${duration.inMilliseconds}ms
  Request Size: ${requestSize}B
  Response Size: ${responseSize}B
    ''');

    if (kReleaseMode) {
      _sendNetworkMetricToAnalytics(
        endpoint: endpoint,
        method: method,
        statusCode: statusCode,
        duration: duration,
        requestSize: requestSize,
        responseSize: responseSize,
      );
    }
  }

  // Record app lifecycle metrics
  static void recordAppLifecycle(String event) {
    final timestamp = DateTime.now();
    _logger.d('App Lifecycle: $event at $timestamp');
    
    if (kReleaseMode) {
      _sendAppLifecycleToAnalytics(event, timestamp);
    }
  }

  // Record user interaction metrics
  static void recordUserInteraction({
    required String screen,
    required String action,
    Map<String, dynamic>? parameters,
  }) {
    _logger.d('User Interaction: $action on $screen');
    
    if (kReleaseMode) {
      _sendUserInteractionToAnalytics(
        screen: screen,
        action: action,
        parameters: parameters,
      );
    }
  }

  // Record error metrics
  static void recordError({
    required String error,
    required String stackTrace,
    String? screen,
    Map<String, dynamic>? context,
  }) {
    _logger.e('Error recorded: $error');
    
    if (kReleaseMode) {
      _sendErrorToAnalytics(
        error: error,
        stackTrace: stackTrace,
        screen: screen,
        context: context,
      );
    }
  }

  // Get performance statistics
  static Map<String, PerformanceStats> getStats() {
    final stats = <String, PerformanceStats>{};
    
    for (final entry in _metrics.entries) {
      final durations = entry.value;
      if (durations.isNotEmpty) {
        final totalMs = durations.fold<int>(0, (sum, d) => sum + d.inMilliseconds);
        final avgMs = totalMs / durations.length;
        final minMs = durations.map((d) => d.inMilliseconds).reduce((a, b) => a < b ? a : b);
        final maxMs = durations.map((d) => d.inMilliseconds).reduce((a, b) => a > b ? a : b);
        
        stats[entry.key] = PerformanceStats(
          count: durations.length,
          averageMs: avgMs,
          minMs: minMs,
          maxMs: maxMs,
          totalMs: totalMs,
        );
      }
    }
    
    return stats;
  }

  // Clear all metrics
  static void clearMetrics() {
    _metrics.clear();
    _startTimes.clear();
    _logger.d('Performance metrics cleared');
  }

  // Print performance report
  static void printReport() {
    final stats = getStats();
    if (stats.isEmpty) {
      _logger.i('No performance metrics available');
      return;
    }

    final buffer = StringBuffer();
    buffer.writeln('=== Performance Report ===');
    
    for (final entry in stats.entries) {
      final stat = entry.value;
      buffer.writeln('${entry.key}:');
      buffer.writeln('  Count: ${stat.count}');
      buffer.writeln('  Average: ${stat.averageMs.toStringAsFixed(2)}ms');
      buffer.writeln('  Min: ${stat.minMs}ms');
      buffer.writeln('  Max: ${stat.maxMs}ms');
      buffer.writeln('  Total: ${stat.totalMs}ms');
      buffer.writeln('');
    }
    
    _logger.i(buffer.toString());
  }

  static void _recordMetric(String name, Duration duration) {
    _metrics.putIfAbsent(name, () => []).add(duration);
  }

  static void _sendToAnalytics(String metricName, num value) {
    // TODO: Implement Firebase Analytics or other analytics service
    // FirebaseAnalytics.instance.logEvent(
    //   name: 'custom_metric',
    //   parameters: {
    //     'metric_name': metricName,
    //     'value': value,
    //   },
    // );
  }

  static void _sendNetworkMetricToAnalytics({
    required String endpoint,
    required String method,
    required int statusCode,
    required Duration duration,
    required int requestSize,
    required int responseSize,
  }) {
    // TODO: Implement network metrics tracking
    // FirebaseAnalytics.instance.logEvent(
    //   name: 'network_request',
    //   parameters: {
    //     'endpoint': endpoint,
    //     'method': method,
    //     'status_code': statusCode,
    //     'duration_ms': duration.inMilliseconds,
    //     'request_size': requestSize,
    //     'response_size': responseSize,
    //   },
    // );
  }

  static void _sendAppLifecycleToAnalytics(String event, DateTime timestamp) {
    // TODO: Implement app lifecycle tracking
    // FirebaseAnalytics.instance.logEvent(
    //   name: 'app_lifecycle',
    //   parameters: {
    //     'event': event,
    //     'timestamp': timestamp.millisecondsSinceEpoch,
    //   },
    // );
  }

  static void _sendUserInteractionToAnalytics({
    required String screen,
    required String action,
    Map<String, dynamic>? parameters,
  }) {
    // TODO: Implement user interaction tracking
    // FirebaseAnalytics.instance.logEvent(
    //   name: action,
    //   parameters: {
    //     'screen': screen,
    //     ...?parameters,
    //   },
    // );
  }

  static void _sendErrorToAnalytics({
    required String error,
    required String stackTrace,
    String? screen,
    Map<String, dynamic>? context,
  }) {
    // TODO: Implement error tracking
    // FirebaseCrashlytics.instance.recordError(
    //   error,
    //   StackTrace.fromString(stackTrace),
    //   reason: 'Performance Service Error',
    //   information: [
    //     if (screen != null) DiagnosticsProperty('screen', screen),
    //     if (context != null)
    //       ...context.entries.map((e) => DiagnosticsProperty(e.key, e.value)),
    //   ],
    // );
  }
}

class PerformanceStats {
  final int count;
  final double averageMs;
  final int minMs;
  final int maxMs;
  final int totalMs;

  PerformanceStats({
    required this.count,
    required this.averageMs,
    required this.minMs,
    required this.maxMs,
    required this.totalMs,
  });

  @override
  String toString() {
    return 'PerformanceStats(count: $count, avg: ${averageMs.toStringAsFixed(2)}ms, min: ${minMs}ms, max: ${maxMs}ms)';
  }
}

// Mixin for easy performance tracking in widgets and services
mixin PerformanceTrackingMixin {
  void trackPerformance(String traceName, VoidCallback operation) {
    PerformanceService.measureSync(traceName, operation);
  }

  Future<T> trackAsyncPerformance<T>(
    String traceName,
    Future<T> Function() operation,
  ) {
    return PerformanceService.measureAsync(traceName, operation);
  }

  void recordMetric(String name, num value) {
    PerformanceService.recordMetric(name, value);
  }

  void recordUserAction(String screen, String action, [Map<String, dynamic>? params]) {
    PerformanceService.recordUserInteraction(
      screen: screen,
      action: action,
      parameters: params,
    );
  }
}