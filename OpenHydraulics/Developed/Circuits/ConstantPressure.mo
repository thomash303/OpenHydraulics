within OpenHydraulics.Developed.Circuits;

model ConstantPressure
  Cylinders.DoubleActingCylinder doubleActingCylinder(boreDiameter = 0.173, strokeLength = 1, closedLength = 2, pistonRodMass = 1, damping = 0)  annotation(
    Placement(transformation(origin = {-52, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Valves.V4_3CC v4_3cc annotation(
    Placement(transformation(origin = {-16, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Volumes.Accumulator hpAccumulator(gasVolume = 7.5, p_precharge(displayUnit = "MPa") = 1.32e7)  annotation(
    Placement(transformation(origin = {20, 36}, extent = {{-10, -10}, {10, 10}})));
  Volumes.Accumulator lpAccumulator(p_precharge(displayUnit = "MPa") = 6.6e6)  annotation(
    Placement(transformation(origin = {22, -8}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
  Machines.ConstantDisplacementPump constantDisplacementPump(Dconst = 0.00025)  annotation(
    Placement(transformation(origin = {42, 12}, extent = {{10, 10}, {-10, -10}})));
  Modelica.Mechanics.Translational.Components.Mass mass(m = 150000)  annotation(
    Placement(transformation(origin = {-56, 50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.Translational.Components.Fixed fixed annotation(
    Placement(transformation(origin = {-52, -14}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sources.Force force annotation(
    Placement(transformation(origin = {-74, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Cosine cosine(amplitude = 1000, f = 0.1)  annotation(
    Placement(transformation(origin = {-114, 70}, extent = {{-10, -10}, {10, 10}})));
  inner Systems.System system(redeclare package Medium = OpenHydraulics.Developed.Media.GenericOil, m_flow_start = 0.001)  annotation(
    Placement(transformation(origin = {-78, -82}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(doubleActingCylinder.port_a, v4_3cc.portA) annotation(
    Line(points = {{-44, 2}, {-24, 2}, {-24, 8}}, color = {255, 0, 0}));
  connect(doubleActingCylinder.port_b, v4_3cc.portB) annotation(
    Line(points = {{-44, 18}, {-24, 18}, {-24, 16}}, color = {255, 0, 0}));
  connect(constantDisplacementPump.portT, hpAccumulator.port_a) annotation(
    Line(points = {{42, 22}, {20, 22}, {20, 26}}, color = {255, 0, 0}));
  connect(constantDisplacementPump.portP, lpAccumulator.port_a) annotation(
    Line(points = {{42, 2}, {22, 2}}, color = {255, 0, 0}));
  connect(lpAccumulator.port_a, v4_3cc.portP) annotation(
    Line(points = {{22, 2}, {-8, 2}, {-8, 8}}, color = {255, 0, 0}));
  connect(hpAccumulator.port_a, v4_3cc.portT) annotation(
    Line(points = {{20, 26}, {-8, 26}, {-8, 16}}, color = {255, 0, 0}));
  connect(mass.flange_b, doubleActingCylinder.flange_b) annotation(
    Line(points = {{-56, 40}, {-52, 40}, {-52, 20}}, color = {0, 127, 0}));
  connect(fixed.flange, doubleActingCylinder.flange_a) annotation(
    Line(points = {{-52, -14}, {-52, 0}}, color = {0, 127, 0}));
  connect(force.flange, mass.flange_a) annotation(
    Line(points = {{-64, 70}, {-56, 70}, {-56, 60}}, color = {0, 127, 0}));
  connect(cosine.y, force.f) annotation(
    Line(points = {{-102, 70}, {-86, 70}}, color = {0, 0, 127}));
end ConstantPressure;
