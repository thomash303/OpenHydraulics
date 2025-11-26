within OpenHydraulics.Custom.Testing;

model Variable_displacement_pump

  OpenHydraulics.Custom.Machines.VariableDisplacementPump idealPump(Dmin = -0.001)  annotation(
    Placement(transformation(origin = {18, 16}, extent = {{-10, -10}, {10, 10}})));
  inner OpenHydraulics.Custom.Systems.System system(redeclare package Medium = OpenHydraulics.Custom.Media.GenericOilSimple) annotation(
    Placement(transformation(origin = {-82, 70}, extent = {{-10, -10}, {10, 10}})));
  OpenHydraulics.Custom.Volumes.BaseClasses.Tank tank(p_const = 2e5)  annotation(
    Placement(transformation(origin = {18, -34}, extent = {{-10, -10}, {10, 10}})));
  OpenHydraulics.Custom.Volumes.BaseClasses.Tank tank1 annotation(
    Placement(transformation(origin = {18, 62}, extent = {{10, 10}, {-10, -10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 1000)  annotation(
    Placement(transformation(origin = {-52, 16}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Sine sine(amplitude = 1, f = 0.1)  annotation(
    Placement(transformation(origin = {-78, -26}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed annotation(
    Placement(transformation(origin = {-92, 14}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp(height = 5, duration = 5)  annotation(
    Placement(transformation(origin = {-142, 10}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(tank.port, idealPump.portT) annotation(
    Line(points = {{18, -24}, {18, 6}}, color = {255, 0, 0}));
  connect(idealPump.portP, tank1.port) annotation(
    Line(points = {{18, 26}, {18, 52}}, color = {255, 0, 0}));
  connect(idealPump.flange_a, inertia.flange_b) annotation(
    Line(points = {{8, 16}, {-42, 16}}));
  connect(sine.y, idealPump.dispFraction) annotation(
    Line(points = {{-66, -26}, {10, -26}, {10, 8}}, color = {0, 0, 127}));
  connect(speed.flange, inertia.flange_a) annotation(
    Line(points = {{-82, 14}, {-62, 14}, {-62, 16}}));
  connect(ramp.y, speed.w_ref) annotation(
    Line(points = {{-130, 10}, {-104, 10}, {-104, 14}}, color = {0, 0, 127}));
  annotation(
    uses(OpenHydraulics(version = "2.0.0"), Modelica(version = "4.0.0")),
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-06, Interval = 0.01),
  Diagram);


end Variable_displacement_pump;
