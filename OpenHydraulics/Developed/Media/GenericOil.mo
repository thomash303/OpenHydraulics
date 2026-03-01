within OpenHydraulics.Developed.Media;

package GenericOil
 "Simple medium model for oil"

  // Importing from the MSL
  import Modelica.Units.SI;
  import Modelica.Icons.Function;
  
  extends Media.BaseClasses.PartialMedium(final mediumName = "GenericOil",
    final rho_ambient = 850,
    final beta = 1.5e9);
    
  redeclare final function extends density
    "Return density as a function of p and T"
    extends Function;

  algorithm
    //   for some reason OpenModelica doesn't like this expression being constant... will try to make it constant
    //rho := 850 + 5e-12*(p);
    rho := 850 + 5e-10*(p);
    //    rho := 870;
    annotation (smoothOrder=2);
  end density;

end GenericOil;
