within OpenHydraulics.Developed.Testing;

model accumulator_decay
  inner Systems.System system(redeclare package Medium = OpenHydraulics.Developed.Media.GenericOil)  annotation(
    Placement(transformation(origin = {-82, -84}, extent = {{-10, -10}, {10, 10}})));
 Volumes.Accumulator HP_accumulator(liquidVolume = 0.01, gasVolume = 0.011, p_init = 1e6)  annotation(
    Placement(transformation(origin = {-24, 52}, extent = {{-10, -10}, {10, 10}})));
  Volumes.Accumulator LP_accumulator(liquidVolume = 0.01, gasVolume = 0.011)  annotation(
    Placement(transformation(origin = {4, -60}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 0.001)  annotation(
    Placement(transformation(origin = {48, -2}, extent = {{-10, -10}, {10, 10}})));
  Machines.FluidPower2MechRotConst fluidPower2MechRotConst annotation(
    Placement(transformation(origin = {0, -2}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(fluidPower2MechRotConst.flange_b, inertia.flange_a) annotation(
    Line(points = {{10, -2}, {38, -2}}));
  connect(HP_accumulator.port_a, fluidPower2MechRotConst.port_b) annotation(
    Line(points = {{-24, 42}, {0, 42}, {0, 8}}, color = {255, 0, 0}));
 connect(LP_accumulator.port_a, fluidPower2MechRotConst.port_a) annotation(
    Line(points = {{4, -50}, {0, -50}, {0, -12}}, color = {255, 0, 0}));
annotation(
    experiment(StartTime = 0, StopTime = 15, Tolerance = 1e-06, Interval = 0.002));
end accumulator_decay;
