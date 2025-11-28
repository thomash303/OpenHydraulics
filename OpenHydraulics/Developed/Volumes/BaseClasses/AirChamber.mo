within OpenHydraulics.Developed.Volumes.BaseClasses;

model AirChamber
  "Model representing the interaction between gas dynamics and fluid dynamics"
  
  // Importing and inheriting from the MSL
  extends Modelica.Mechanics.Translational.Interfaces.PartialCompliant;
  import Modelica.Units.SI;
  
  // Implicit connections
  outer Systems.System system;

  // Parameters
  parameter SI.Area A = 1 "Area of piston";
  parameter SI.AbsolutePressure p_precharge = 1e6 "precharge pressure";
  parameter SI.Volume V_precharge = 0.5 "initial precharge volume";
  parameter Real gamma = 1.4 "Adiabatic index for an ideal gas(default set assuming dry air)";
  parameter SI.Volume residualVolume = 0 "Volume when chamber is fully compressed";
  parameter SI.TranslationalSpringConstant stopStiffness = 1e9 "stiffness when piston reaches stop";
  parameter Boolean initializePressure = true "true = pressure; false = volume" annotation(
    Dialog(tab = "Initialization"),
    Evaluate = true);
  parameter SI.AbsolutePressure p_init "Initial pressure" annotation(
    Dialog(tab = "Initialization", enable = initializePressure));
  parameter SI.Volume V_init = V_precharge "Initial volume" annotation(
    Dialog(tab = "Initialization", enable = not initializePressure));
  SI.AbsolutePressure p(start = p_precharge) "pressure of air in chamber";
  SI.Volume V "Volume of air in chamber";
  
protected
  Boolean empty "true when chamber is empty";
  SI.Force f_stop "contact force when chamber is empty";
  Real pVgamma "p*V^gamma";

initial equation
  if initializePressure then
    p = p_init;
    V = V_precharge*(p_precharge/p_init)^(1/gamma);
  else
    p = p_precharge*(V_precharge/V_init)^gamma;
    V = V_init;
  end if;
equation
// behavior of the gas: p*V^gamma = constant
// NOTE: isothermal gas law replaced with icentropic gas law
  pVgamma = p*V^gamma;
  der(pVgamma) = 0;
  V = s_rel*A + residualVolume;
  0 = A*(p - system.p_ambient) + f + f_stop;
  
  // Relation between gas state and cylinder behavior
  empty = s_rel < 0;
  f_stop = if empty then -s_rel*stopStiffness - der(s_rel)*10 else 0;
  annotation(
    Diagram(graphics = {Rectangle(extent = {{-80, 40}, {80, -40}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{100, 4}, {40, -4}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Rectangle(extent = {{30, 40}, {40, -40}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-40, 40}, {-30, -40}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-40, 4}, {-100, -4}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid)}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-80, 40}, {80, -40}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{100, 4}, {44, -4}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Rectangle(extent = {{34, 39}, {44, -39}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-44, 39}, {-34, -39}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-44, 4}, {-100, -4}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Text(extent = {{0, 100}, {0, 60}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, textString = "%name")}));
end AirChamber;
