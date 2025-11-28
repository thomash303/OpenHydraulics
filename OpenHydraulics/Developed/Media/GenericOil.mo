within OpenHydraulics.Developed.Media;

package GenericOil
 "Simple medium model for oil"

  // Importing from the MSL
  import Modelica.Units.SI;
  import Modelica.Icons.Function;
  
  extends Media.BaseClasses.PartialMedium(final mediumName = "GenericOil",
    final rho_ambient = 850,
    final beta = 1.5e9);


end GenericOil;
