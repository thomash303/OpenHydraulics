within OpenHydraulics.Developed.Testing;

model simple_FMU_force_fmu
  Modelica.Mechanics.Translational.Components.GeneralPositionToForceAdaptor positionToForceAdaptor(use_pder = true, use_pder2 = true)  annotation(
    Placement(transformation(origin = {-16, 27}, extent = {{-20, -17}, {20, 17}})));
  Developed.Cylinders.DoubleActingCylinder doubleActingCylinder(boreDiameter = 0.04, closedLength = 0.0001, compressibleEnable = true, maxPressure = 2e8, p_init = 1e6, pistonRodMass = 1, rodDiameter(displayUnit = "mm") = 0.029, strokeLength = 3) annotation(
    Placement(transformation(origin = {46, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.Translational.Components.Fixed fixed annotation(
    Placement(transformation(origin = {46, -44}, extent = {{-10, -10}, {10, 10}})));
  Custom.Basic.LaminarRestriction laminarRestriction(L = 10)  annotation(
    Placement(transformation(origin = {86, 30}, extent = {{-10, -10}, {10, 10}})));
  Custom.Basic.LaminarRestriction laminarRestriction1(L = 10)  annotation(
    Placement(transformation(origin = {84, 14}, extent = {{-10, -10}, {10, 10}})));
  Custom.Basic.OpenTank tank annotation(
    Placement(transformation(origin = {130, 28}, extent = {{-10, -10}, {10, 10}})));
  Custom.Basic.OpenTank tank1 annotation(
    Placement(transformation(origin = {118, -8}, extent = {{-10, -10}, {10, 10}})));
  inner Developed.Systems.System system(redeclare package Medium = Developed.Media.GenericOil)  annotation(
    Placement(transformation(origin = {-64, -58}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealOutput f annotation(
    Placement(transformation(origin = {150, 8}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, -60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealInput s annotation(
    Placement(transformation(origin = {-136, 46}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-136, 46}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealInput v annotation(
    Placement(transformation(origin = {-132, 18}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-132, 18}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealInput a annotation(
    Placement(transformation(origin = {-130, -22}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-130, -22}, extent = {{-20, -20}, {20, 20}})));
equation
  connect(doubleActingCylinder.flange_a, fixed.flange) annotation(
    Line(points = {{46, 12}, {46, -44}}, color = {0, 127, 0}));
  connect(doubleActingCylinder.flange_b, positionToForceAdaptor.flange) annotation(
    Line(points = {{46, 32}, {-12, 32}, {-12, 27}}, color = {0, 127, 0}));
  connect(laminarRestriction.port_b, tank.port) annotation(
    Line(points = {{96, 30}, {130, 30}, {130, 38}}, color = {255, 0, 0}));
  connect(laminarRestriction1.port_b, tank1.port) annotation(
    Line(points = {{94, 14}, {118, 14}, {118, 2}}, color = {255, 0, 0}));
  connect(laminarRestriction.port_a, doubleActingCylinder.port_b) annotation(
    Line(points = {{76, 30}, {54, 30}}, color = {255, 0, 0}));
  connect(laminarRestriction1.port_a, doubleActingCylinder.port_a) annotation(
    Line(points = {{74, 14}, {54, 14}}, color = {255, 0, 0}));
  connect(s, positionToForceAdaptor.p) annotation(
    Line(points = {{-136, 46}, {-22, 46}, {-22, 40}}, color = {0, 0, 127}));
  connect(positionToForceAdaptor.f, f) annotation(
    Line(points = {{-22, 14}, {-28, 14}, {-28, -34}, {150, -34}, {150, 8}}, color = {0, 0, 127}));
  connect(v, positionToForceAdaptor.pder) annotation(
    Line(points = {{-132, 18}, {-58, 18}, {-58, 36}, {-22, 36}}, color = {0, 0, 127}));
  connect(a, positionToForceAdaptor.pder2) annotation(
    Line(points = {{-130, -22}, {-48, -22}, {-48, 30}, {-22, 30}}, color = {0, 0, 127}));
end simple_FMU_force_fmu;
