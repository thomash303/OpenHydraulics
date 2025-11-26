within OpenHydraulics.Custom.Testing;

model accumulator

      
  parameter Real dispFraction = 1;
  parameter Real Cv = 60000 "Coefficient of viscous drag";
  parameter Real Cf = 0.007
    "Coefficient of Coulomb friction (fraction of full stroke torque)";
  parameter Real Cs = 1.8e-9 "Leakage coefficient";
  parameter Real Vr = 0.54 "Volume ratio of pump or motor";
  parameter Modelica.Units.SI.DynamicViscosity mu = 0.036
    "Dynamic viscosity (used only for efficiency models)";
  parameter Modelica.Units.SI.BulkModulus B = 1.86 * 10^5;
  Modelica.Blocks.Sources.Cosine sine(amplitude = 100, startTime = 0, f = 0.2, offset = 0.4)  annotation(
    Placement(transformation(origin = {-218, 40}, extent = {{-10, -10}, {10, 10}})));
  Lines.NJunction j1(n_ports=4) annotation(
    Placement(transformation(origin = {-24, 8}, extent = {{-10, -10}, {10, 10}})));
  Lines.NJunction j2(n_ports=4) annotation(
    Placement(transformation(origin = {-30, -20}, extent = {{-10, -10}, {10, 10}})));
  Volumes.Accumulator accumulator(gasVolume = 0.11, liquidVolume = 0.1, p_precharge = 3e5, initType = OpenHydraulics.Types.AccInit.Pressure) annotation(
    Placement(transformation(origin = {-30, -60}, extent = {{-10, 10}, {10, -10}})));
  Volumes.Accumulator accumulator1(gasVolume = 0.2, liquidVolume = 0.15, p_precharge = 1e6, initType = OpenHydraulics.Types.AccInit.Pressure) annotation(
    Placement(transformation(origin = {-22, 30}, extent = {{-10, -10}, {10, 10}})));


  Basic.LaminarRestriction laminarRestriction(L = 100, D = 5)  annotation(
    Placement(transformation(origin = {32, -6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  inner Systems.System system(redeclare package Medium = OpenHydraulics.Custom.Media.GenericOilSimple)  annotation(
    Placement(transformation(origin = {30, -82}, extent = {{-10, -10}, {10, 10}})));
  Cylinders.DoubleActingCylinder doubleActingCylinder(strokeLength = 2, closedLength = 0.2, boreDiameter = 0.08, rodDiameter = 0.01, initType = OpenHydraulics.Types.RevoluteInit.Free)  annotation(
    Placement(transformation(origin = {-82, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.Translational.Components.Fixed fixed annotation(
    Placement(transformation(origin = {-84, -44}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sources.Force force annotation(
    Placement(transformation(origin = {-168, 38}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Components.Mass mass(m = 10)  annotation(
    Placement(transformation(origin = {-108, 44}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(accumulator.port_a, j2.port[2]) annotation(
    Line(points = {{-30, -50}, {-30, -20}}, color = {255, 0, 0}));
  connect(accumulator1.port_a, j1.port[2]) annotation(
    Line(points = {{-22, 20}, {-24, 20}, {-24, 8}}, color = {255, 0, 0}));
  connect(laminarRestriction.port_a, j1.port[3]) annotation(
    Line(points = {{32, 4}, {6, 4}, {6, 8}, {-24, 8}}, color = {255, 0, 0}));
  connect(laminarRestriction.port_b, j2.port[3]) annotation(
    Line(points = {{32, -16}, {8, -16}, {8, -20}, {-30, -20}}, color = {255, 0, 0}));
  connect(doubleActingCylinder.port_b, j1.port[1]) annotation(
    Line(points = {{-74, 4}, {-24, 4}, {-24, 8}}, color = {255, 0, 0}));
  connect(doubleActingCylinder.port_a, j2.port[1]) annotation(
    Line(points = {{-74, -12}, {-30, -12}, {-30, -20}}, color = {255, 0, 0}));
  connect(fixed.flange, doubleActingCylinder.flange_a) annotation(
    Line(points = {{-84, -44}, {-82, -44}, {-82, -14}}, color = {0, 127, 0}));
  connect(sine.y, force.f) annotation(
    Line(points = {{-206, 40}, {-180, 40}, {-180, 38}}, color = {0, 0, 127}));
  connect(mass.flange_b, doubleActingCylinder.flange_b) annotation(
    Line(points = {{-98, 44}, {-82, 44}, {-82, 6}}, color = {0, 127, 0}));
  connect(force.flange, mass.flange_a) annotation(
    Line(points = {{-158, 38}, {-118, 38}, {-118, 44}}, color = {0, 127, 0}));
  annotation(
    uses(OpenHydraulics(version = "2.0.0"), Modelica(version = "4.0.0")),
  Diagram(coordinateSystem(extent = {{-180, 100}, {80, -100}})),
  version = "",
  experiment(StartTime = 0, StopTime = 70, Tolerance = 1e-07, Interval = 0.005));

end accumulator;
