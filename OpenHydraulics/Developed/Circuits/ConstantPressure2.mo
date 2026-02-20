within OpenHydraulics.Developed.Circuits;

model ConstantPressure2
  Cylinders.DoubleActingCylinder doubleActingCylinder(boreDiameter = 0.1729, strokeLength = 0.5, pistonRodMass = 1, damping = 0, compressibleEnable = true, initType = Developed.Types.RevoluteInit.Position, s_init = 0.25) annotation(
    Placement(transformation(origin = {-52, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Valves.V4_3CC v4_3cc(p_crack(displayUnit = "MPa") = 75000, p_open(displayUnit = "MPa") = 1e5, p_init (displayUnit = "MPa")= 1e7) annotation(
    Placement(transformation(origin = {-16, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Volumes.Accumulator hpAccumulator(gasVolume = 4e1, p_precharge(displayUnit = "MPa") = 1e7, liquidVolume = 3.5e1, initType = Developed.Types.AccInit.Volume, p_init (displayUnit = "MPa")= 1e7) annotation(
    Placement(transformation(origin = {20, 36}, extent = {{-10, -10}, {10, 10}})));
  Volumes.Accumulator lpAccumulator(p_precharge(displayUnit = "MPa") = 6.6e6, liquidVolume = 1.25e1, gasVolume = 1.75e1, initType = Developed.Types.AccInit.Volume, p_init(displayUnit = "MPa") = 6.6e6) annotation(
    Placement(transformation(origin = {22, -8}, extent = {{-10, 10}, {10, -10}})));
  Machines.ConstantDisplacementPump constantDisplacementPump(Dconst = 0.00025, CMotorLeakage = 0.00025, p_init (displayUnit = "MPa")= 1e7) annotation(
    Placement(transformation(origin = {58, 22}, extent = {{10, 10}, {-10, -10}})));
  Modelica.Mechanics.Translational.Components.Mass mass(m = 7.285e4 + 8.694e4) annotation(
    Placement(transformation(origin = {-56, 50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.Translational.Components.Fixed fixed annotation(
    Placement(transformation(origin = {-52, -14}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sources.Force force annotation(
    Placement(transformation(origin = {-74, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Cosine cosine(amplitude = 1e5, f = 0.1, phase = 1.5707963267948966, startTime = 10) annotation(
    Placement(transformation(origin = {-112, 64}, extent = {{-10, -10}, {10, 10}})));
  inner Systems.System system(redeclare package Medium = Developed.Media.GenericOil, m_flow_start = 0.001) annotation(
    Placement(transformation(origin = {-78, -82}, extent = {{-10, -10}, {10, 10}})));
  Custom.Basic.LaminarRestriction laminarRestriction(L = 10, p_init(displayUnit = "MPa") = 6.6e6) annotation(
    Placement(transformation(origin = {48, -2}, extent = {{-10, -10}, {10, 10}})));
  Custom.Basic.LaminarRestriction laminarRestriction1(L = 10, p_init (displayUnit = "MPa")= 1.32e7) annotation(
    Placement(transformation(origin = {-6, 42}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 0.1)  annotation(
    Placement(transformation(origin = {100, 22}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(doubleActingCylinder.port_a, v4_3cc.portA) annotation(
    Line(points = {{-44, 2}, {-24, 2}, {-24, 8}}, color = {255, 0, 0}));
  connect(doubleActingCylinder.port_b, v4_3cc.portB) annotation(
    Line(points = {{-44, 18}, {-24, 18}, {-24, 16}}, color = {255, 0, 0}));
  connect(constantDisplacementPump.portP, hpAccumulator.port_a) annotation(
    Line(points = {{58, 32}, {58, 22}, {20, 22}, {20, 26}}, color = {255, 0, 0}));
  connect(lpAccumulator.port_a, v4_3cc.portP) annotation(
    Line(points = {{22, 2}, {-8, 2}, {-8, 8}}, color = {255, 0, 0}));
  connect(mass.flange_b, doubleActingCylinder.flange_b) annotation(
    Line(points = {{-56, 40}, {-52, 40}, {-52, 20}}, color = {0, 127, 0}));
  connect(fixed.flange, doubleActingCylinder.flange_a) annotation(
    Line(points = {{-52, -14}, {-52, 0}}, color = {0, 127, 0}));
  connect(force.flange, mass.flange_a) annotation(
    Line(points = {{-64, 70}, {-56, 70}, {-56, 60}}, color = {0, 127, 0}));
  connect(cosine.y, force.f) annotation(
    Line(points = {{-101, 64}, {-93.5, 64}, {-93.5, 70}, {-86, 70}}, color = {0, 0, 127}));
  connect(lpAccumulator.port_a, laminarRestriction.port_a) annotation(
    Line(points = {{22, 2}, {38, 2}, {38, -2}}, color = {255, 0, 0}));
  connect(laminarRestriction.port_b, constantDisplacementPump.portT) annotation(
    Line(points = {{58, -2}, {58, 12}}, color = {255, 0, 0}));
  connect(hpAccumulator.port_a, laminarRestriction1.port_b) annotation(
    Line(points = {{20, 26}, {4, 26}, {4, 42}}, color = {255, 0, 0}));
  connect(laminarRestriction1.port_a, v4_3cc.portT) annotation(
    Line(points = {{-16, 42}, {-8, 42}, {-8, 16}}, color = {255, 0, 0}));
  connect(inertia.flange_a, constantDisplacementPump.flange_a) annotation(
    Line(points = {{90, 22}, {68, 22}}));
  annotation(
    Diagram);
end ConstantPressure2;
