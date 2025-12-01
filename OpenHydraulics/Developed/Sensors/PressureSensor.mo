within OpenHydraulics.Developed.Sensors;

model PressureSensor "Model representing a pressure sensor"
  // Inheriting from the OET
  extends Interfaces.BaseClasses.PartialFluidComponent;
  // Importing and inheriting from the MSL
  import Modelica.Units.SI;
  import Modelica.Blocks.Interfaces.RealOutput;
  // Parameters
  parameter Types.PressureTypes pressureType =  Types.PressureTypes.Absolute "Specify desired pressure measurent type";
  parameter SI.Volume V = 0 "Volume for non-ideal pressure sensor" annotation(
    Dialog(tab = "Advanced"));
  // Fluid ports
  Interfaces.FluidPort port_a annotation(
    Placement(transformation(origin = {-50, 0}, extent = {{-10, -110}, {10, -90}}), iconTransformation(origin = {-30, 0}, extent = {{-10, -110}, {10, -90}})));
  Interfaces.FluidPort port_b if pressureType == Types.PressureTypes.Relative annotation(
    Placement(transformation(origin = {50, 0}, extent = {{-10, -110}, {10, -90}}), iconTransformation(origin = {30, -2}, extent = {{-10, -110}, {10, -90}})));
  Volumes.BaseClasses.VolumeClosed volumeClosed_a(final V = V, final n_ports = 1) annotation(
    Placement(transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Volumes.BaseClasses.VolumeClosed volumeClosed_b(final V = V, final n_ports = 1) if pressureType == Types.PressureTypes.Relative annotation(
    Placement(transformation(origin = {48, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  RealOutput y annotation(
    Placement(transformation(origin = {34, 0}, extent = {{60, -10}, {80, 10}}), iconTransformation(extent = {{60, -10}, {80, 10}})));
equation
// Absolute
  if pressureType == Types.PressureTypes.Absolute then
    y = port_a.p - 0;
  elseif pressureType == Types.PressureTypes.Gauge then
    y = port_a.p - system.p_ambient;
  else
    y = port_a.p - port_b.p;
  end if;
  
  connect(port_a, volumeClosed_a.port[1]) annotation(
    Line(points = {{-50, -100}, {-50, -49.625}, {-50, 0.05}, {-50, 0.05}}, color = {255, 0, 0}));
  connect(port_b, volumeClosed_b.port[1]) annotation(
    Line(points = {{50, -100}, {48, -100}, {48, 0}}, color = {255, 0, 0}));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-54, 54}, {54, -54}}), Line(points = {{32, 32}, {-32, -32}}), Polygon(fillPattern = FillPattern.Solid, points = {{-32, -32}, {-24, -14}, {-14, -24}, {-32, -32}}), Line(origin = {-30.3704, 4.44444}, points = {{0, -50}, {0, -100}}, color = {255, 0, 0}), Text(textColor = {0, 0, 255}, extent = {{0, 56}, {0, 82}}, textString = "%name"), Line(points = {{60, 0}, {54, 0}}, color = {0, 0, 127}), Line(origin = {30, 7.4074}, points = {{0, -52}, {0, -100}}, color = {255, 0, 0}, visible = pressureType ==  Types.PressureTypes.Relative)}),
    Diagram(graphics = {Line(origin = {-54.074, 0.370368}, points = {{148, -1}, {10, 0}}, color = {0, 0, 255}, pattern = LinePattern.Dash)}));
end PressureSensor;
