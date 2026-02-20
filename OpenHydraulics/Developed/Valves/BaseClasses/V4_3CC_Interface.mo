within OpenHydraulics.Developed.Valves.BaseClasses;

model V4_3CC_Interface
  extends Interfaces.BaseClasses.PartialFluidComponent;
  
  // Ports
  Interfaces.FluidPort portP annotation(
    Placement(transformation(extent = {{-50, -90}, {-30, -70}})));
  Interfaces.FluidPort portA annotation(
    Placement(transformation(extent = {{-50, 70}, {-30, 90}})));
  Interfaces.FluidPort portT annotation(
    Placement(transformation(extent = {{30, -90}, {50, -70}})));
  Interfaces.FluidPort portB annotation(
    Placement(transformation(extent = {{30, 70}, {50, 90}})));
  // Control input
  parameter Boolean manualValveControl = false "Enable manual valve control" annotation(Dialog(group = "Valve Characteristics"), choices(checkBox = true));
  Modelica.Blocks.Interfaces.RealInput control if manualValveControl
    annotation (Placement(transformation(extent={{130,-20},{90,20}})));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{90, 20}, {130, -20}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-82, 100}, {-52, 60}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "A"), Text(extent = {{52, 100}, {82, 60}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "B"), Text(extent = {{50, -60}, {80, -100}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "T"), Text(extent = {{-80, -60}, {-50, -100}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "P"), Rectangle(extent = {{-90, 30}, {-30, -30}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-30, 30}, {30, -30}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{30, 30}, {90, -30}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid)}));
end V4_3CC_Interface;
