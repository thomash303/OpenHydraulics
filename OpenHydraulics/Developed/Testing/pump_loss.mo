within OpenHydraulics.Developed.Testing;

model pump_loss
  inner Systems.System system(redeclare package Medium = Developed.Media.GenericOil) annotation(
    Placement(transformation(origin = {-82, -84}, extent = {{-10, -10}, {10, 10}})));
  Machines.VariableDisplacementPump variableDisplacementMotor(p_init(displayUnit = "bar") = 3.5e6, CsD = {25, 50, 75, 100}, CvD = {25, 50, 75, 100}, CfD = {25, 50, 75, 100}, Cs = 5000*{3.2576e-9, 2.7658e-9, 2.1634e-9, 2.8241e-9}, Cv = {207433, 249350, 286122, 313991}, frictionEnable = true, leakageEnable = false, Dmax = 4e-6, Dmin = -4e-6, Cf = {-0.0012, -0.0017, -0.0017, -0.0003}) annotation(
    Placement(transformation(origin = {2, -2}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Sensors.FlowSensor flowSensor annotation(
    Placement(transformation(origin = {2, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Developed.Sensors.FlowSensor flowSensor1 annotation(
    Placement(transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 0, height = 1) annotation(
    Placement(transformation(origin = {68, 30}, extent = {{10, -10}, {-10, 10}})));
  Volumes.OpenTank tank(p_const = 1e5) annotation(
    Placement(transformation(origin = {0, -78}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed annotation(
    Placement(transformation(origin = {46, 0}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.Sine sine(amplitude = 100*2*3.14/60, f = 1/2.5, offset = 1500*2*3.14/60) annotation(
    Placement(transformation(origin = {98, -2}, extent = {{10, -10}, {-10, 10}})));
  OpenHydraulics.Developed.Volumes.OpenTank tank1(p_const = 1e6) annotation(
    Placement(transformation(origin = {0, 66}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
equation
  connect(ramp.y, variableDisplacementMotor.dispFraction) annotation(
    Line(points = {{58, 30}, {10, 17}, {9, -9}}, color = {0, 0, 127}));
  connect(tank.port, flowSensor1.port_b) annotation(
    Line(points = {{0, -68}, {0, -40}}, color = {255, 0, 0}));
  connect(sine.y, speed.w_ref) annotation(
    Line(points = {{88, -2}, {58, -2}, {58, 0}}, color = {0, 0, 127}));
  connect(speed.flange, variableDisplacementMotor.flange_a) annotation(
    Line(points = {{36, 0}, {10, 0}, {10, -2}}));
  connect(variableDisplacementMotor.portP, flowSensor.port_b) annotation(
    Line(points = {{2, 6}, {2, 18}}, color = {255, 0, 0}));
  connect(variableDisplacementMotor.portT, flowSensor1.port_a) annotation(
    Line(points = {{2, -10}, {0, -10}, {0, -20}}, color = {255, 0, 0}));
  connect(tank1.port, flowSensor.port_a) annotation(
    Line(points = {{0, 56}, {2, 56}, {2, 38}}, color = {255, 0, 0}));
  annotation(
    experiment(StartTime = 0, StopTime = 15, Tolerance = 1e-06, Interval = 0.002));
end pump_loss;
