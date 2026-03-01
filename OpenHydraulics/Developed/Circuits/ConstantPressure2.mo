within OpenHydraulics.Developed.Circuits;

model ConstantPressure2
  Cylinders.DoubleActingCylinder doubleActingCylinder(boreDiameter = 0.15, strokeLength = 2, pistonRodMass = 5, damping = 0, compressibleEnable = true, initType = Developed.Types.RevoluteInit.Position, s_init = 1, p_init(displayUnit = "MPa"), stribeckFrictionEnable = true, Cv = 10000, Cst = 10, f_st = 15000, leakageEnable = true, CHeadExLeakage = 0.000000002, CRodExLeakage = 0.000000002, CInLeakage = 0.000000005, f_c = 200, rodDiameter = 0) annotation(
    Placement(transformation(origin = {-52, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Valves.V4_3CC v4_3cc(p_crack(displayUnit = "bar") = 1e5, p_open(displayUnit = "bar") = 125000, p_init (displayUnit = "bar") = 7e6, CvData = Modelica.Fluid.Types.CvTypes.Av, Av = 0.0005) annotation(
    Placement(transformation(origin = {-14, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Volumes.Accumulator hpAccumulator(gasVolume = 1, p_precharge(displayUnit = "bar") = 3e6, liquidVolume = 0.8, initType = OpenHydraulics.Developed.Types.AccInit.Pressure, p_init (displayUnit = "bar") = 7e6, pistonDamping = 10) annotation(
    Placement(transformation(origin = {22, 36}, extent = {{-10, -10}, {10, 10}})));
  Volumes.Accumulator lpAccumulator(p_precharge(displayUnit = "bar") = 5e5, liquidVolume = 3*1.25e0, gasVolume = 3*1.75e0, initType = OpenHydraulics.Developed.Types.AccInit.Pressure, p_init(displayUnit = "bar") = 1e6) annotation(
    Placement(transformation(origin = {22, -8}, extent = {{-10, 10}, {10, -10}})));
  Machines.ConstantDisplacementPump constantDisplacementPump(Dconst = -0.00032, CMotorLeakage = 3.12e-8, p_init (displayUnit = "bar")= 7e6, leakageEnable = false) annotation(
    Placement(transformation(origin = {64, 22}, extent = {{10, 10}, {-10, -10}})));
  Modelica.Mechanics.Translational.Components.Mass mass(m = 7.285e4 + 8.694e4) annotation(
    Placement(transformation(origin = {-56, 50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.Translational.Components.Fixed fixed annotation(
    Placement(transformation(origin = {-52, -14}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sources.Force force annotation(
    Placement(transformation(origin = {-74, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Cosine cosine(amplitude = 1.3e5, f = 0.05) annotation(
    Placement(transformation(origin = {-112, 64}, extent = {{-10, -10}, {10, 10}})));
  inner Systems.System system(redeclare package Medium = Developed.Media.GenericOil, m_flow_start = 2) annotation(
    Placement(transformation(origin = {-78, -82}, extent = {{-10, -10}, {10, 10}})));
  Custom.Basic.LaminarRestriction laminarRestriction(L = 0.01, p_init(displayUnit = "bar") = 1e6, D = 1) annotation(
    Placement(transformation(origin = {48, -2}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Components.Damper damper(d = 11.5)  annotation(
    Placement(transformation(origin = {142, 22}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.Rotational.Components.Fixed fixed1 annotation(
    Placement(transformation(origin = {166, -10}, extent = {{-10, -10}, {10, 10}})));

Modelica.Units.SI.Force Fpto = 0.01767*(hpAccumulator.port_a.p - lpAccumulator.port_a.p)*sign(mass.v);
equation
  connect(constantDisplacementPump.portP, hpAccumulator.port_a) annotation(
    Line(points = {{64, 12}, {64, 22}, {22, 22}, {22, 26}}, color = {255, 0, 0}));
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
    Line(points = {{58, -2}, {58, 5}, {64, 5}, {64, 32}}, color = {255, 0, 0}));
  connect(damper.flange_a, fixed1.flange) annotation(
    Line(points = {{152, 22}, {166, 22}, {166, -10}}));
  connect(damper.flange_b, constantDisplacementPump.flange_a) annotation(
    Line(points = {{132, 22}, {74, 22}}));
  connect(hpAccumulator.port_a, v4_3cc.portT) annotation(
    Line(points = {{22, 26}, {-6, 26}, {-6, 16}}, color = {255, 0, 0}));
  connect(lpAccumulator.port_a, v4_3cc.portP) annotation(
    Line(points = {{22, 2}, {-6, 2}, {-6, 8}}, color = {255, 0, 0}));
  connect(v4_3cc.portA, doubleActingCylinder.port_a) annotation(
    Line(points = {{-22, 8}, {-44, 8}, {-44, 2}}, color = {255, 0, 0}));
  connect(v4_3cc.portB, doubleActingCylinder.port_b) annotation(
    Line(points = {{-22, 16}, {-44, 16}, {-44, 18}}, color = {255, 0, 0}));
  annotation(
    Diagram,
  experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-06, Interval = 0.002));
end ConstantPressure2;
