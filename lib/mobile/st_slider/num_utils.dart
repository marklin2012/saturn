class NumUtils {
  String formartNum(num? value, int position, {bool isRound = true}) {
    final temp = value.toString();
    if (value == 0) {
      return '0';
    } else if (position <= 0) {
      return temp;
    } else {
      if (temp.contains('.')) {
        final temp1 = temp.split('.').last;
        if (value! > 1) {
          return temp.split('.').first;
        } else if (temp1.length >= position) {
          if (isRound) {
            return value.toStringAsFixed(position);
          } else {
            return temp.substring(0, temp.length - (temp1.length - position));
          }
        } else {
          final temp2 = StringBuffer();
          for (int i = 0; i < position - temp1.length; i++) {
            temp2.write('0');
          }
          return temp + temp2.toString();
        }
      } else {
        final temp3 = StringBuffer(position > 0 ? '.' : '');
        for (int i = 0; i < position; i++) {
          temp3.write('0');
        }
        return temp + temp3.toString();
      }
    }
  }
}
