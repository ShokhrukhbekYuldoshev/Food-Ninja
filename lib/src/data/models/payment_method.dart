enum PaymentMethod {
  visa,
  paypal;

  String get name {
    switch (this) {
      case PaymentMethod.visa:
        return 'Visa';
      case PaymentMethod.paypal:
        return 'Paypal';
      default:
        return '';
    }
  }
}
