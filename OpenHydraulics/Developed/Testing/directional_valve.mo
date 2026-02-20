within OpenHydraulics.Developed.Testing;

model directional_valve
  inner Systems.System system annotation(
    Placement(transformation(origin = {-88, 88}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport = false) annotation(
    Placement(transformation(extent = {{-60, -10}, {-40, 10}})));
  Modelica.Blocks.Sources.Sine sinusoid1(amplitude = 30, f = 0.1, startTime = 0, phase = 1.5707963267948966) annotation(
    Placement(transformation(origin = {-92, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Machines.FluidPower2MechRotConst fluidPower2MechRotConst annotation(
    Placement(transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}})));
  Volumes.CircuitTank circuitTank(V_max = 200000, V_init = 100000)  annotation(
    Placement(transformation(origin = {-2, -26}, extent = {{-10, -10}, {10, 10}})));
  Valves.V4_3CC v4_3cc(p_crack = 2e5, p_open = 2.5e5, manualValveControl = true)  annotation(
    Placement(transformation(origin = {14, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Custom.Basic.LaminarRestriction laminarRestriction(L = 0.1, D = 0.01)  annotation(
    Placement(transformation(origin = {60, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Ramp ramp(height = 5000, duration = 3)  annotation(
    Placement(transformation(origin = {-98, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y = 5000) annotation(
    Placement(transformation(origin = {10, 34}, extent = {{-96, -10}, {-76, 10}})));
  Modelica.Blocks.Sources.Sine sinusoid11(amplitude = 1, f = 0.5, startTime = 0) annotation(
    Placement(transformation(origin = {22, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Valves.ReliefValve reliefValve annotation(
    Placement(transformation(origin = {26, 70}, extent = {{-10, -10}, {10, 10}})));
  Valves.CheckValve checkValve   annotation(
    Placement(transformation(origin = {76, 72}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(torque.flange, fluidPower2MechRotConst.flange_a) annotation(
    Line(points = {{-40, 0}, {-30, 0}}));
  connect(v4_3cc.portA, laminarRestriction.port_a) annotation(
    Line(points = {{22, 4}, {60, 4}, {60, 6}}, color = {255, 0, 0}));
  connect(laminarRestriction.port_b, v4_3cc.portB) annotation(
    Line(points = {{60, -14}, {26, -14}, {26, -4}, {22, -4}}, color = {255, 0, 0}));
  connect(circuitTank.port_b, v4_3cc.portT) annotation(
    Line(points = {{8, -26}, {8, -15}, {6, -15}, {6, -4}}, color = {255, 0, 0}));
  connect(circuitTank.port_a, fluidPower2MechRotConst.port_a) annotation(
    Line(points = {{-12, -26}, {-20, -26}, {-20, -10}}, color = {255, 0, 0}));
  connect(fluidPower2MechRotConst.port_b, v4_3cc.portP) annotation(
    Line(points = {{-20, 10}, {6, 10}, {6, 4}}, color = {255, 0, 0}));
  connect(sinusoid11.y, v4_3cc.control) annotation(
    Line(points = {{22, -54}, {14, -54}, {14, -10}}, color = {0, 0, 127}));
  connect(realExpression.y, torque.tau) annotation(
    Line(points = {{-64, 34}, {-62, 34}, {-62, 0}}, color = {0, 0, 127}));
end directional_valve;
