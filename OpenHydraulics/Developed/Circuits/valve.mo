within OpenHydraulics.Developed.Circuits;

model valve
  inner Systems.System system annotation(
    Placement(transformation(origin = {-84, 82}, extent = {{-10, -10}, {10, 10}})));
  Sources.VarPressureSource varPSourceA annotation(
    Placement(transformation(origin = {-56, 32}, extent = {{-10, -10}, {10, 10}})));
  Sources.VarPressureSource varPSourceB annotation(
    Placement(transformation(origin = {-56, -32}, extent = {{-10, -10}, {10, 10}})));
  Volumes.OpenTank HPTank(p_const = 1e6)  annotation(
    Placement(transformation(origin = {64, 34}, extent = {{-10, -10}, {10, 10}})));
  Volumes.OpenTank LPTank annotation(
    Placement(transformation(origin = {52, -44}, extent = {{-10, -10}, {10, 10}})));
  Valves.V4_3CC v4_3cc(manualValveControl = false, p_crack(displayUnit = "MPa") = 75000, p_open(displayUnit = "MPa") = 1e5, CvData = Modelica.Fluid.Types.CvTypes.Av, Av = 0.001)  annotation(
    Placement(transformation(origin = {-2, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Custom.Basic.LaminarRestriction laminarRestriction(L = 10)  annotation(
    Placement(transformation(origin = {32, 34}, extent = {{-10, -10}, {10, 10}})));
  Custom.Basic.LaminarRestriction laminarRestriction1(L = 10)  annotation(
    Placement(transformation(origin = {28, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Sine sine(amplitude = 14e5, f = 10e5)  annotation(
    Placement(transformation(origin = {-110, 34}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Sine sine1(amplitude = 14e5, f = 10e5, phase = 3.141592653589793) annotation(
    Placement(transformation(origin = {-108, -20}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(laminarRestriction.port_b, HPTank.port) annotation(
    Line(points = {{42, 34}, {50, 34}, {50, 44}, {64, 44}}, color = {255, 0, 0}));
  connect(laminarRestriction.port_a, v4_3cc.portT) annotation(
    Line(points = {{22, 34}, {6, 34}, {6, 2}}, color = {255, 0, 0}));
  connect(v4_3cc.portP, laminarRestriction1.port_a) annotation(
    Line(points = {{6, -6}, {18, -6}, {18, -20}}, color = {255, 0, 0}));
  connect(laminarRestriction1.port_b, LPTank.port) annotation(
    Line(points = {{38, -20}, {52, -20}, {52, -34}}, color = {255, 0, 0}));
  connect(varPSourceB.port, v4_3cc.portA) annotation(
    Line(points = {{-56, -22}, {-10, -22}, {-10, -6}}, color = {255, 0, 0}));
  connect(varPSourceA.port, v4_3cc.portB) annotation(
    Line(points = {{-56, 42}, {-10, 42}, {-10, 2}}, color = {255, 0, 0}));
  connect(sine1.y, varPSourceB.control) annotation(
    Line(points = {{-96, -20}, {-66, -20}, {-66, -32}}, color = {0, 0, 127}));
  connect(sine.y, varPSourceA.control) annotation(
    Line(points = {{-98, 34}, {-83, 34}, {-83, 32}, {-66, 32}}, color = {0, 0, 127}));
end valve;
