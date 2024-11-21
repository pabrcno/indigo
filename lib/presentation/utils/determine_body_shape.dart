String determineBodyShape(double chest, double waist, double hips) {
  if ((chest - hips).abs() <= 2.0 && (waist / hips) < 0.75) {
    return "Forma de reloj de arena";
  } else if (chest > hips && chest > waist) {
    return "Triángulo invertido";
  } else if (hips > chest && hips > waist) {
    return "Forma de pera";
  } else {
    return "Forma rectangular";
  }
}
