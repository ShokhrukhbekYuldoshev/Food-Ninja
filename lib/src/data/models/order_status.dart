import 'dart:ui';

import '../../presentation/utils/app_colors.dart';

enum OrderStatus {
  pending,
  preparing,
  delivering,
  delivered,
  canceled;

  @override
  String toString() {
    switch (this) {
      case OrderStatus.pending:
        return "Pending";
      case OrderStatus.preparing:
        return "Preparing";
      case OrderStatus.delivering:
        return "Delivering";
      case OrderStatus.delivered:
        return "Delivered";
      case OrderStatus.canceled:
        return "Canceled";
      default:
        return "Pending";
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.pending:
        return AppColors.pendingColor;
      case OrderStatus.preparing:
        return AppColors.preparingColor;
      case OrderStatus.delivering:
        return AppColors.deliveringColor;
      case OrderStatus.delivered:
        return AppColors.deliveredColor;
      case OrderStatus.canceled:
        return AppColors.canceledColor;
      default:
        return AppColors.pendingColor;
    }
  }
}
