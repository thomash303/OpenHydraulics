within OpenHydraulics.Custom.Testing;

model Constant_displacement_pump
  Custom.Machines.ConstantDisplacementPump idealPump(Dconst = 0.01) annotation(
    Placement(transformation(origin = {18, 16}, extent = {{-10, -10}, {10, 10}})));
  inner Custom.Systems.System system(redeclare package Medium = Custom.Media.GenericOilSimple) annotation(
    Placement(transformation(origin = {-82, 70}, extent = {{-10, -10}, {10, 10}})));
  Custom.Volumes.BaseClasses.Tank tank(p_const = 5e5) annotation(
    Placement(transformation(origin = {18, -34}, extent = {{-10, -10}, {10, 10}})));
  Custom.Volumes.BaseClasses.Tank tank1 annotation(
    Placement(transformation(origin = {18, 62}, extent = {{10, 10}, {-10, -10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 1000) annotation(
    Placement(transformation(origin = {-52, 16}, extent = {{-10, -10}, {10, 10}})));    
equation
  connect(tank.port, idealPump.portT) annotation(
    Line(points = {{18, -24}, {18, 6}}, color = {255, 0, 0}));
  connect(idealPump.portP, tank1.port) annotation(
    Line(points = {{18, 26}, {18, 52}}, color = {255, 0, 0}));
  connect(idealPump.flange_a, inertia.flange_b) annotation(
    Line(points = {{8, 16}, {-42, 16}}));
  annotation(
    uses(OpenHydraulics(version = "2.0.0"), Modelica(version = "4.0.0")),
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-06, Interval = 0.002),
    Diagram);


end Constant_displacement_pump;
