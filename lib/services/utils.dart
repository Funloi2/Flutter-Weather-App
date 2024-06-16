String capitalize(String s) {
  if (s.isEmpty) {
    return s;
  }
  return s[0].toUpperCase() + s.substring(1);
}


// Space out the visibility value to make it more readable
String formatVisibility(double visibility) {
  return visibility.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ');
}

//Display the wind direction in cardinal points
String formatWindDirection(int windDirection) {
  if (windDirection >= 337.5 || windDirection < 22.5) {
    return "N";
  } else if (windDirection >= 22.5 && windDirection < 67.5) {
    return "NE";
  } else if (windDirection >= 67.5 && windDirection < 112.5) {
    return "E";
  } else if (windDirection >= 112.5 && windDirection < 157.5) {
    return "SE";
  } else if (windDirection >= 157.5 && windDirection < 202.5) {
    return "S";
  } else if (windDirection >= 202.5 && windDirection < 247.5) {
    return "SW";
  } else if (windDirection >= 247.5 && windDirection < 292.5) {
    return "W";
  } else {
    return "NW";
  }
}

String formatTimeFull(String time) {
  final parsedTime = DateTime.parse(time);
  return "${parsedTime.day}/${parsedTime.month}/${parsedTime.year} ${parsedTime.hour}:${parsedTime.minute}0";
}