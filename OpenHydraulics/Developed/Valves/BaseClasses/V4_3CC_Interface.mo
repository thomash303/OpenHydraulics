within OpenHydraulics.Developed.Valves.BaseClasses;

partial model V4_3CC_Interface
  extends Interfaces.BaseClasses.PartialFluidComponent;
  
    // Initialization parameters
  parameter SI.Pressure p_init_P = system.p_ambient "Initial pressure at port P" annotation(
    Dialog(tab = "Initialization", group = "Fluid"));
  parameter SI.Pressure p_init_T = system.p_ambient "Initial pressure at port T" annotation(
    Dialog(tab = "Initialization", group = "Fluid"));
    
  // Ports
  Interfaces.FluidPort portP(p(start = p_init_P)) annotation(
    Placement(transformation(extent = {{-50, -90}, {-30, -70}})));
  Interfaces.FluidPort portA(p(start = p_init)) annotation(
    Placement(transformation(extent = {{-50, 70}, {-30, 90}})));
  Interfaces.FluidPort portT(p(start = p_init_T)) annotation(
    Placement(transformation(extent = {{30, -90}, {50, -70}})));
  Interfaces.FluidPort portB(p(start = p_init)) annotation(
    Placement(transformation(extent = {{30, 70}, {50, 90}})));
  // Control input
  parameter Boolean manualValveControl = false "Enable manual valve control" annotation(Dialog(group = "Valve Characteristics"), choices(checkBox = true));
  Modelica.Blocks.Interfaces.RealInput control if manualValveControl
    annotation (Placement(transformation(extent={{130,-20},{90,20}})));
    
  // Power and energy at port P and T
  SI.Power P_T = portT.p * portT.m_flow / system.rho_ambient "Hydraulic power at port T";    
  SI.Power P_P = portP.p * portP.m_flow / system.rho_ambient "Hydraulic power at port P";  
  
  SI.Energy E_T "Hydraulic energy at port T";
  SI.Energy E_P "Hydraulic energy at port P";
  
equation
  // Energy
  der(E_T) = P_T;
  der(E_P) = P_P;

  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{90, 20}, {130, -20}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-82, 100}, {-52, 60}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "A"), Text(extent = {{52, 100}, {82, 60}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "B"), Text(extent = {{50, -60}, {80, -100}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "T"), Text(extent = {{-80, -60}, {-50, -100}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "P"), Rectangle(extent = {{-90, 30}, {-30, -30}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-30, 30}, {30, -30}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{30, 30}, {90, -30}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid)}));
end V4_3CC_Interface;
