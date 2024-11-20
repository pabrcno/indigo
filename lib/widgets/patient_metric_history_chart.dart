import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';

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
    // Sort the metrics history to display the curve properly
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
        children: [
          Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(icon, color: curveColor),
                      const SizedBox(width: 8),
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: curveColor,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          if (latestMetric != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(children: [
                      Row(
                        children: [
                          Text(
                            latestMetric.value.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            unit,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: getStatusColor(
                                getStatusForMetric(metrics.first.metricType,
                                    latestMetric.value),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              getStatusForMetric(
                                  metrics.first.metricType, latestMetric.value),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ])),
                SizedBox(
                  height: 80,
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          color: curveColor,
                          spots: sortedMetrics
                              .asMap()
                              .entries
                              .map(
                                (entry) => FlSpot(
                                  entry.key.toDouble(),
                                  entry.value.value,
                                ),
                              )
                              .toList(),
                          dotData: const FlDotData(
                            show: false, // Disable dots
                          ),
                          barWidth: 1,
                          aboveBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                curveColor.withOpacity(0.3),
                                curveColor.withOpacity(0.0),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                curveColor.withOpacity(0.3),
                                curveColor.withOpacity(0.1),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ],
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((spot) {
                              final index = spot.spotIndex;
                              final metric = sortedMetrics[index];
                              return LineTooltipItem(
                                '${metric.recordedAt.day}/${metric.recordedAt.month}/${metric.recordedAt.year}\n'
                                '${metric.value.toStringAsFixed(1)} $unit',
                                const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              );
                            }).toList();
                          },
                        ),
                        handleBuiltInTouches: true,
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            Center(
              child: Text(
                'No data available',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade600,
                ),
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
