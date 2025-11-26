within OpenHydraulics.Custom.Testing;

model accumulator_decay
  inner Systems.System system(redeclare package Medium = OpenHydraulics.Custom.Media.GenericOilSimple)  annotation(
    Placement(transformation(origin = {-80, -82}, extent = {{-10, -10}, {10, 10}})));
  Volumes.Accumulator HP_accumulator(liquidVolume = 0.01, gasVolume = 0.011, p_init = 1e6)  annotation(
    Placement(transformation(origin = {4, 58}, extent = {{-10, -10}, {10, 10}})));
  Volumes.Accumulator LP_accumulator(liquidVolume = 1000, gasVolume = 1100)  annotation(
    Placement(transformation(origin = {2, -66}, extent = {{-10, 10}, {10, -10}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y = 1)  annotation(
    Placement(transformation(origin = {-72, -12}, extent = {{-10, -10}, {10, 10}})));
  Machines.FluidPower2MechRotConst fluidPower2MechRotConst(Dconst = -0.001)  annotation(
    Placement(transformation(origin = {-4, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 0.001)  annotation(
    Placement(transformation(origin = {40, -4}, extent = {{-10, -10}, {10, 10}})));

  model pumping
  inner Systems.System system(redeclare package Medium = OpenHydraulics.Custom.Media.GenericOilSimple, T_ambient = 288.15)  annotation(
      Placement(transformation(origin = {-90, 86}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Components.Fixed fixed annotation(
      Placement(transformation(origin = {-26, 52}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp(duration = 100, height = 1000)  annotation(
      Placement(transformation(origin = {-68, -8}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Position position(f_crit = 1)  annotation(
      Placement(transformation(origin = {-28, -8}, extent = {{-10, -10}, {10, 10}})));
  Machines.FluidPower2MechRotConst fluidPower2MechRotConst(Dconst = 5e-5)  annotation(
      Placement(transformation(origin = {0, -8}, extent = {{-10, -10}, {10, 10}})));
  
  
  Cylinders.DoubleActingCylinder doubleActingCylinder(strokeLength = 0.4, q_nom = 1e-4, pistonMass = 0.1, useCushionHead = false, useCushionRod = false, s_init = 0.185, compressibleEnable = false, L_A2B = 0, D_A2B = 0, L_A2Env = 0, D_A2Env = 0, L_B2Env = 0, D_B2Env = 0)  annotation(
      Placement(transformation(origin = {20, 62}, extent = {{-10, -10}, {10, 10}})));
  Volumes.CircuitTank circuitTank annotation(
      Placement(transformation(origin = {24, -54}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(ramp.y, position.phi_ref) annotation(
      Line(points = {{-56, -8}, {-40, -8}}, color = {0, 0, 127}));
    connect(position.flange, fluidPower2MechRotConst.flange_a) annotation(
      Line(points = {{-18, -8}, {-10, -8}}));
  connect(fixed.flange, doubleActingCylinder.flange_a) annotation(
  Line(points = {{-26, 52}, {10, 52}, {10, 62}}, color = {0, 127, 0}));
  connect(doubleActingCylinder.port_a, fluidPower2MechRotConst.port_b) annotation(
  Line(points = {{12, 54}, {0, 54}, {0, 2}}, color = {255, 0, 0}));
    connect(fluidPower2MechRotConst.port_a, circuitTank.port_a) annotation(
      Line(points = {{0, -18}, {14, -18}, {14, -54}}, color = {255, 0, 0}));
  connect(circuitTank.port_b, doubleActingCylinder.port_b) annotation(
Line(points = {{34, -54}, {28, -54}, {28, 54}}, color = {255, 0, 0}));
    annotation(
      experiment(StartTime = 0, StopTime = 9, Tolerance = 1e-08, Interval = 0.002));
end pumping;

  Modelica.Blocks.Sources.Ramp ramp(height = 3, duration = 5)  annotation(
    Placement(transformation(origin = {38, -38}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed annotation(
    Placement(transformation(origin = {84, -18}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(LP_accumulator.port_a, fluidPower2MechRotConst.port_a) annotation(
    Line(points = {{2, -56}, {-4, -56}, {-4, -10}}, color = {255, 0, 0}));
  connect(fluidPower2MechRotConst.port_b, HP_accumulator.port_a) annotation(
    Line(points = {{-4, 10}, {4, 10}, {4, 48}}, color = {255, 0, 0}));
  connect(fluidPower2MechRotConst.flange_b, inertia.flange_a) annotation(
    Line(points = {{6, 0}, {30, 0}, {30, -4}}));
  connect(ramp.y, speed.w_ref) annotation(
    Line(points = {{50, -38}, {72, -38}, {72, -18}}, color = {0, 0, 127}));
  connect(speed.flange, inertia.flange_b) annotation(
    Line(points = {{94, -18}, {50, -18}, {50, -4}}));
  annotation(
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.002));
end accumulator_decay;
