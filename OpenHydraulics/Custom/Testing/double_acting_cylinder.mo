within OpenHydraulics.Custom.Testing;

model double_acting_cylinder

      
  parameter Real dispFraction = 1;
  parameter Real Cv = 60000 "Coefficient of viscous drag";
  parameter Real Cf = 0.007
    "Coefficient of Coulomb friction (fraction of full stroke torque)";
  parameter Real Cs = 1.8e-9 "Leakage coefficient";
  parameter Real Vr = 0.54 "Volume ratio of pump or motor";
  parameter Modelica.Units.SI.DynamicViscosity mu = system.Medium.dynamicViscosity(5e6)
    "Dynamic viscosity (used only for efficiency models)";
  parameter Modelica.Units.SI.BulkModulus B = system.Medium.approxBulkModulus(5e6);
  Cylinders.DoubleActingCylinder doubleActingCylinder(strokeLength = 1, pistonMass = 2, s_init = 0.3, useCushionHead = false, closedLength = 0.4, initType = OpenHydraulics.Types.RevoluteInit.Position, fixHeadPressure = false)  annotation(
    Placement(transformation(origin = {-78, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.Translational.Sources.Force force annotation(
    Placement(transformation(origin = {-114, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Cosine sine(amplitude = 4, startTime = 0, f = 0.2)  annotation(
    Placement(transformation(origin = {-168, 38}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Components.Fixed fixed annotation(
    Placement(transformation(origin = {-78, -10}, extent = {{-10, -10}, {10, 10}})));


  inner Systems.System system(redeclare package Medium = OpenHydraulics.Custom.Media.GenericOilSimple)  annotation(
    Placement(transformation(origin = {34, 58}, extent = {{-10, -10}, {10, 10}})));
  Volumes.CircuitTank circuitTank annotation(
    Placement(transformation(origin = {-32, -2}, extent = {{-10, -10}, {10, 10}})));
equation


  connect(sine.y, force.f) annotation(
    Line(points = {{-156, 38}, {-126, 38}, {-126, 40}}, color = {0, 0, 127}));
  connect(fixed.flange, doubleActingCylinder.flange_a) annotation(
    Line(points = {{-78, -10}, {-78, 14}}, color = {0, 127, 0}));
  connect(force.flange, doubleActingCylinder.flange_b) annotation(
    Line(points = {{-104, 40}, {-78, 40}, {-78, 34}}, color = {0, 127, 0}));
  connect(circuitTank.port_a, doubleActingCylinder.port_a) annotation(
    Line(points = {{-42, -2}, {-70, -2}, {-70, 16}}, color = {255, 0, 0}));
  connect(circuitTank.port_b, doubleActingCylinder.port_b) annotation(
    Line(points = {{-22, -2}, {-18, -2}, {-18, 32}, {-70, 32}}, color = {255, 0, 0}));
  annotation(
    uses(OpenHydraulics(version = "2.0.0"), Modelica(version = "4.0.0")),
  Diagram(coordinateSystem(extent = {{-180, 100}, {80, -100}})),
  version = "",
  experiment(StartTime = 0, StopTime = 70, Tolerance = 1e-07, Interval = 0.005));


end double_acting_cylinder;
