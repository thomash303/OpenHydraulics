within OpenHydraulics.Developed.Media;

model GenericOil
 "Simple medium model for oil"

  // Importing from the MSL
  import Modelica.Units.SI;
  import Modelica.Icons.Function;

  extends Media.BaseClasses.PartialMedium(final mediumName="GenericOil");


end GenericOil;
