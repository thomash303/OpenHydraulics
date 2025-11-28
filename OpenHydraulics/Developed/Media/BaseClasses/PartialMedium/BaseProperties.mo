within OpenHydraulics.Developed.Media.BaseClasses.PartialMedium;

model BaseProperties

  // Medium Parameters
  parameter SI.Temperature T_ambient_med = 298.15 "Reference temperature of Medium: default 25 deg Celsius";
  parameter SI.AbsolutePressure p_ambient_med = 101325 "Reference pressure of the medium";
  parameter SI.Density rho_ambient = 850 "Reference density of the medium";

end BaseProperties;
