within OpenHydraulics.Developed.Testing;

model motor_loss
  inner Systems.System system(redeclare package Medium = Developed.Media.GenericOil) annotation(
    Placement(transformation(origin = {-82, -84}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 0.001) annotation(
    Placement(transformation(origin = {46, 0}, extent = {{-10, -10}, {10, 10}})));
  Machines.VariableDisplacementMotor variableDisplacementMotor(p_init(displayUnit = "bar") = 3.5e6, CsD = {25, 50, 75, 100}, CvD = {25, 50, 75, 100}, CfD = {25, 50, 75, 100}, Cs = {-3.2576e-9, -2.7658e-9, -2.1634e-9, -2.8241e-9}, Cv = {207433, 249350, 286122, 313991}, frictionEnable = true, leakageEnable = true, Dmax = 4e-6, Dmin = -4e-6, Cf = {-0.0012, -0.0017, -0.0017, -0.0003}) annotation(
    Placement(transformation(origin = {2, -2}, extent = {{10, 10}, {-10, -10}})));
  Sensors.FlowSensor flowSensor annotation(
    Placement(transformation(origin = {2, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Developed.Sensors.FlowSensor flowSensor1 annotation(
    Placement(transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.Rotational.Components.Damper damper(d = 0.005, w_rel(start = -157.07963267948966, fixed = true, displayUnit = "rpm")) annotation(
    Placement(transformation(origin = {80, -2}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed1 annotation(
    Placement(transformation(origin = {106, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp(duration = 0, height = 1) annotation(
    Placement(transformation(origin = {68, 30}, extent = {{10, -10}, {-10, 10}})));
  Sources.ConstPressureSource constPSource(p_const = 1e6) annotation(
    Placement(transformation(origin = {6, 72}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
  Volumes.OpenTank tank(p_const = 1e5)  annotation(
    Placement(transformation(origin = {0, -78}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(flowSensor.port_b, variableDisplacementMotor.portT) annotation(
    Line(points = {{2, 18}, {2, 6}}, color = {255, 0, 0}));
  connect(variableDisplacementMotor.portP, flowSensor1.port_a) annotation(
    Line(points = {{2, -10}, {0, -10}, {0, -20}}, color = {255, 0, 0}));
  connect(fixed1.flange, damper.flange_b) annotation(
    Line(points = {{106, -20}, {104, -20}, {104, -2}, {90, -2}}));
  connect(damper.flange_a, inertia.flange_b) annotation(
    Line(points = {{70, -2}, {56, -2}, {56, 0}}));
  connect(inertia.flange_a, variableDisplacementMotor.flange_a) annotation(
    Line(points = {{36, 0}, {10, 0}, {10, -2}}));
  connect(ramp.y, variableDisplacementMotor.dispFraction) annotation(
    Line(points = {{58, 30}, {10, 30}, {10, 4}}, color = {0, 0, 127}));
  connect(constPSource.port, flowSensor.port_a) annotation(
    Line(points = {{6, 62}, {2, 62}, {2, 38}}, color = {255, 0, 0}));
  connect(tank.port, flowSensor1.port_b) annotation(
    Line(points = {{0, -68}, {0, -40}}, color = {255, 0, 0}));
  annotation(
    experiment(StartTime = 0, StopTime = 15, Tolerance = 1e-06, Interval = 0.002));
end motor_loss;
