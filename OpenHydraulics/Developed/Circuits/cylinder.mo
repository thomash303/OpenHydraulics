within OpenHydraulics.Developed.Circuits;

model cylinder
  Cylinders.DoubleActingCylinder doubleActingCylinder(compressibleEnable = true, strokeLength = 1.5, initType = OpenHydraulics.Developed.Types.RevoluteInit.Position, s_init = 0.75, boreDiameter = 0.1729)  annotation(
    Placement(transformation(origin = {-54, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.Translational.Components.Mass mass(m = 7.285e4 + 8.694e4)  annotation(
    Placement(transformation(origin = {-56, 36}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.Translational.Components.Fixed ground annotation(
    Placement(transformation(origin = {-54, -42}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sources.Force force annotation(
    Placement(transformation(origin = {-84, 54}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Sine sine(amplitude = 5e5, f = 0.1)  annotation(
    Placement(transformation(origin = {-126, 54}, extent = {{-10, -10}, {10, 10}})));
  Custom.Basic.LaminarRestriction laminarRestriction(L = 10)  annotation(
    Placement(transformation(origin = {-12, -2}, extent = {{-10, -10}, {10, 10}})));
  Custom.Basic.LaminarRestriction laminarRestriction1(L = 10)  annotation(
    Placement(transformation(origin = {-12, -18}, extent = {{-10, -10}, {10, 10}})));
  inner Systems.System system annotation(
    Placement(transformation(origin = {-82, 88}, extent = {{-10, -10}, {10, 10}})));
  Volumes.OpenTank HPTank(p_const = 5e5)  annotation(
    Placement(transformation(origin = {28, -4}, extent = {{-10, -10}, {10, 10}})));
  Volumes.OpenTank LPTank annotation(
    Placement(transformation(origin = {26, -38}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(doubleActingCylinder.flange_b, mass.flange_b) annotation(
    Line(points = {{-54, 0}, {-56, 0}, {-56, 26}}, color = {0, 127, 0}));
  connect(ground.flange, doubleActingCylinder.flange_a) annotation(
    Line(points = {{-54, -42}, {-54, -20}}, color = {0, 127, 0}));
  connect(force.flange, mass.flange_a) annotation(
    Line(points = {{-74, 54}, {-56, 54}, {-56, 46}}, color = {0, 127, 0}));
  connect(sine.y, force.f) annotation(
    Line(points = {{-114, 54}, {-96, 54}}, color = {0, 0, 127}));
  connect(doubleActingCylinder.port_b, laminarRestriction.port_a) annotation(
    Line(points = {{-46, -2}, {-22, -2}}, color = {255, 0, 0}));
  connect(doubleActingCylinder.port_a, laminarRestriction1.port_a) annotation(
    Line(points = {{-46, -18}, {-22, -18}}, color = {255, 0, 0}));
  connect(LPTank.port, laminarRestriction1.port_b) annotation(
    Line(points = {{26, -28}, {-2, -28}, {-2, -18}}, color = {255, 0, 0}));
  connect(HPTank.port, laminarRestriction.port_b) annotation(
    Line(points = {{28, 6}, {-2, 6}, {-2, -2}}, color = {255, 0, 0}));
end cylinder;
