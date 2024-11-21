import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:indigo/models/patient_health_metrics/patient_health_metric.dart';
import 'package:indigo/presentation/constants/spacings.dart';
import 'package:indigo/presentation/utils/patient_metics_ui_mapper.dart';
import 'package:indigo/presentation/widgets/paddings.dart';

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
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
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
            padding: kSmallPadding,
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
                Flexible(
                    child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                )),
              ],
            ),
          ),

          if (latestMetric != null) ...[
            // Latest metric value and status badge
            Padding(
                padding: kSmallPadding,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            latestMetric.value.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            unit,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey.shade600),
                          ),
                        ],
                      )),
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
            const SizedBox(height: standardSpacing),
            // Line chart
            Expanded(
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
                            '${metric.createdAt.day}/${metric.createdAt.month}/${metric.createdAt.year}',
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
            SizedBox(
              height: 80,
              child: Center(
                  child: Text(
                'No data available',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              )),
            ),
        ],
      ),
    );
  }
}
