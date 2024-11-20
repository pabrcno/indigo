import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';
import 'package:indigo/widgets/paddings.dart';

class PatientMetricHistoryChart extends StatelessWidget {
  final List<PatientHealthMetric> metrics;
  final Color curveColor;
  final String label;
  final String unit;
  final IconData icon;

  const PatientMetricHistoryChart({
    super.key,
    required this.metrics,
    required this.curveColor,
    required this.label,
    required this.unit,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final sortedMetrics = [...metrics]
      ..sort((a, b) => a.recordedAt.compareTo(b.recordedAt));
    final latestMetric = sortedMetrics.isNotEmpty ? sortedMetrics.last : null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and label
          Padding(
            padding: kPadding,
            child: Row(
              children: [
                Container(
                  padding: kSmallPadding,
                  decoration: BoxDecoration(
                    color: curveColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(icon, color: curveColor),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          if (latestMetric != null) ...[
            // Latest metric value and status badge
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            latestMetric.value.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 28),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            unit,
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: getStatusColor(getStatusForMetric(
                              metrics.first.metricType, latestMetric.value)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          getStatusForMetric(
                              metrics.first.metricType, latestMetric.value),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ])),
            const SizedBox(height: 16),
            // Line chart
            SizedBox(
              height: 80,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    // The double line imitates the desired effect
                    LineChartBarData(
                      isCurved: true,
                      color: Colors.transparent,
                      spots: sortedMetrics
                          .asMap()
                          .entries
                          .map((entry) => FlSpot(
                              entry.key.toDouble(), entry.value.value * 1.1))
                          .toList(),
                      dotData: const FlDotData(show: false),
                      barWidth: 1.5,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            curveColor.withOpacity(0.3),
                            curveColor.withOpacity(0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    LineChartBarData(
                      isCurved: true,
                      color: curveColor,
                      spots: sortedMetrics
                          .asMap()
                          .entries
                          .map((entry) =>
                              FlSpot(entry.key.toDouble(), entry.value.value))
                          .toList(),
                      dotData: const FlDotData(show: false),
                      barWidth: 1.5,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            curveColor.withOpacity(0.3),
                            curveColor.withOpacity(0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) =>
                          touchedSpots.map((spot) {
                        final index = spot.spotIndex;
                        final metric = sortedMetrics[index];
                        if (spot.barIndex == 0) {
                          return LineTooltipItem(
                            '${metric.recordedAt.day}/${metric.recordedAt.month}/${metric.recordedAt.year}',
                            const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        } else {
                          return LineTooltipItem(
                            '${metric.value.toStringAsFixed(1)} $unit',
                            const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        }
                      }).toList(),
                    ),
                    handleBuiltInTouches: true,
                  ),
                ),
              ),
            ),
          ] else
            Center(
              child: Text(
                'No data available',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ),
        ],
      ),
    );
  }

  String getStatusForMetric(EPatientHealthMetricField metric, double value) {
    switch (metric) {
      case EPatientHealthMetricField.glucose:
        if (value < 70) return 'Low';
        if (value <= 140) return 'Normal';
        return 'High';
      case EPatientHealthMetricField.bloodPressure:
        if (value < 90) return 'Low';
        if (value <= 120) return 'Normal';
        return 'High';
      case EPatientHealthMetricField.temperature:
        if (value < 36.5) return 'Low';
        if (value <= 37.5) return 'Normal';
        return 'High';
      case EPatientHealthMetricField.respiratoryRate:
        if (value < 12) return 'Low';
        if (value <= 20) return 'Normal';
        return 'High';
      default:
        return 'Unknown';
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Low':
        return Colors.blue;
      case 'Normal':
        return Colors.green;
      case 'High':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
