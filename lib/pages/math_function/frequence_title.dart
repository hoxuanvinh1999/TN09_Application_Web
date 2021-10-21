String titleFrequence(
    {required String frequence, required String jourFrequence}) {
  if (frequence == '1') {
    return jourFrequence + ' chaque semaine';
  } else {
    return jourFrequence + ' toutes les ' + frequence + ' semaines';
  }
}
