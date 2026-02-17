within OpenHydraulics.Custom.Media;

model GenericOilSimple2

    
  // Importing from the MSL
  import Modelica.Units.SI;
  import Modelica.Icons.Function;

  extends OpenHydraulics.Custom.Media.BaseClasses.PartialMedium(final mediumName="GenericOilSimple");
  
  replaceable function density_nom "Return density as a function of p and T"
    extends Function;
    
    algorithm
    rho_nom := 850;
  end density_nom;

  redeclare final function extends density
    "Return density as a function of p and T"
    extends Function;

  algorithm
    //   for some reason OpenModelica doesn't like this expression... will try to make it constant
    rho := 870 + 5e-7*(p-p_ambient);
    //    rho := 870;
    annotation (smoothOrder=2);
  end density;

  redeclare final function extends dynamicViscosity
    extends Function;

  algorithm
    eta := 0.036;
    annotation (smoothOrder=2);
  end dynamicViscosity;

annotation (
  Documentation(info="<html>
<h4>Simple Linear Fluid Model</h4>
<p>
Oil model that includes temperature and pressure dependence for density and dynamic viscosity.
</p>
</html>"));

end GenericOilSimple2;
