within OpenHydraulics.Custom.Interfaces.BaseClasses;

partial model PartialFluidComponent "Base model for any component involving fluid"
  
  // Importing from the MSL
  import Modelica.Units.SI;
  
  parameter Modelica.Units.SI.AbsolutePressure p_init = system.p_ambient "Initial pressure of the component" annotation(
    Dialog(tab = "Initialization", group = "Fluid"));
protected
  outer Systems.System system;
end PartialFluidComponent;
