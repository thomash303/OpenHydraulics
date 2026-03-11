within OpenHydraulics.Developed.Circuits;

model MP_HIL_checkpoint1
  Developed.Cylinders.DoubleActingCylinder doubleActingCylinder(boreDiameter = 0.04, compressibleEnable = true, strokeLength = 0.3, pistonRodMass = 1, maxPressure = 2e8, leakageEnable = true, Cv = 1000, f_c = 200, Cst = 5, f_st = 2000, CHeadExLeakage = 0.000000002, CRodExLeakage = 0.000000002, CInLeakage = 0.0000000005, damping = 0, stribeckFrictionEnable = true, rodDiameter(displayUnit = "mm") = 0.029, closedLength = 0.01) annotation(
    Placement(transformation(origin = {-44, 22}, extent = {{-10, -10}, {10, 10}})));
  inner Developed.Systems.System system annotation(
    Placement(transformation(origin = {-64, 72}, extent = {{-10, -10}, {10, 10}})));
  Developed.Machines.ConstantDisplacementPump constantDisplacementPump(CMotorLeakage = 0.00025, Dconst = 4e-6/(2*3.14), p_init(displayUnit = "bar") = 3.5e6) annotation(
    Placement(transformation(origin = {58, 14}, extent = {{10, 10}, {-10, -10}})));
  Developed.Volumes.Accumulator hpAccumulator(gasVolume = 3.8e-3, initType = Developed.Types.AccInit.Volume, liquidVolume = 2.8e-3, p_init(displayUnit = "bar") = 3.5e6, p_precharge(displayUnit = "bar") = 1e6, p_max = 2e8, V_init = 2.29e-3) annotation(
    Placement(transformation(origin = {32, 38}, extent = {{-10, -10}, {10, 10}})));
  Developed.Volumes.Accumulator lpAccumulator(gasVolume = 1e1, initType = Developed.Types.AccInit.Volume, liquidVolume = 0.8e1, p_init(displayUnit = "bar") = 2e5, p_precharge(displayUnit = "bar") = 2e5, p_max = 5e7) annotation(
    Placement(transformation(origin = {32, -22}, extent = {{-10, 10}, {10, -10}})));
  Developed.Valves.V4_3CC v4_3cc(p_crack(displayUnit = "bar") = 35000, p_init(displayUnit = "bar") = 1e6, p_open(displayUnit = "bar") = 4e4, CvData = Modelica.Fluid.Types.CvTypes.Av, Av = 5.221e-8*6, Cd = 1) annotation(
    Placement(transformation(origin = {-36, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Custom.Basic.LaminarRestriction laminarRestriction(D = 1, L = 0.01, p_init(displayUnit = "bar") = 2e5) annotation(
    Placement(transformation(origin = {56, -24}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed annotation(
    Placement(transformation(origin = {106, 14}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Blocks.Sources.Sine sine(amplitude = 14*2*3.14/60, f = 1/2.5, offset = 198*2*3.14/60) annotation(
    Placement(transformation(origin = {158, 12}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.Translational.Sources.Position position(exact = true) annotation(
    Placement(transformation(origin = {-8, 54}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.Translational.Components.Fixed fixed annotation(
    Placement(transformation(origin = {-78, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Sine sine1(amplitude = 0.1, f = 1/1.58, offset = 0.15) annotation(
    Placement(transformation(origin = {40, 76}, extent = {{10, -10}, {-10, 10}})));
  Developed.Machines.ConstantDisplacementPump constantDisplacementPump1(CMotorLeakage = 0.00025, Dconst = -4e-6*0, p_init(displayUnit = "bar")) annotation(
    Placement(transformation(origin = {-50, -68}, extent = {{10, -10}, {-10, 10}})));
  Developed.Valves.CheckValve checkValve(manualValveControl = false, p_crack = 1000, p_open = 2000, CvData = Modelica.Fluid.Types.CvTypes.Av, Av = 0.001, p_init = 2e5) annotation(
    Placement(transformation(origin = {-72, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Developed.Volumes.OpenTank tank annotation(
    Placement(transformation(origin = {-6, -78}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed1(exact = true) annotation(
    Placement(transformation(origin = {30, -56}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp(height = -3000*2*3.14/60, duration = 0) annotation(
    Placement(transformation(origin = {64, -56}, extent = {{10, -10}, {-10, 10}})));
  Developed.Sources.ConstPressureSource constPSource annotation(
    Placement(transformation(origin = {-34, -98}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Units.SI.Force Fpto = doubleActingCylinder.rodDiameter^2/4*3.14*(hpAccumulator.port_a.p - lpAccumulator.port_a.p)*sign(doubleActingCylinder.piston.v);
equation
  connect(v4_3cc.portB, doubleActingCylinder.port_b) annotation(
    Line(points = {{-44, -18}, {-44, -16}, {-36, -16}, {-36, 14}}, color = {255, 0, 0}));
  connect(v4_3cc.portA, doubleActingCylinder.port_a) annotation(
    Line(points = {{-44, -26}, {-44, -24}, {-52, -24}, {-52, 14}}, color = {255, 0, 0}));
  connect(constantDisplacementPump.portT, hpAccumulator.port_a) annotation(
    Line(points = {{58, 24}, {38, 24}, {38, 28}, {32, 28}}, color = {255, 0, 0}));
  connect(v4_3cc.portP, lpAccumulator.port_a) annotation(
    Line(points = {{-28, -26}, {-28, -24}, {32, -24}, {32, -12}}, color = {255, 0, 0}));
  connect(v4_3cc.portT, hpAccumulator.port_a) annotation(
    Line(points = {{-28, -18}, {-2, -18}, {-2, 28}, {32, 28}}, color = {255, 0, 0}));
  connect(laminarRestriction.port_b, constantDisplacementPump.portP) annotation(
    Line(points = {{66, -24}, {58, -24}, {58, 4}}, color = {255, 0, 0}));
  connect(laminarRestriction.port_a, lpAccumulator.port_a) annotation(
    Line(points = {{46, -24}, {32, -24}, {32, -12}}, color = {255, 0, 0}));
  connect(speed.flange, constantDisplacementPump.flange_a) annotation(
    Line(points = {{96, 14}, {68, 14}}));
  connect(sine.y, speed.w_ref) annotation(
    Line(points = {{148, 12}, {118, 12}, {118, 14}}, color = {0, 0, 127}));
  connect(position.flange, doubleActingCylinder.flange_b) annotation(
    Line(points = {{-18, 54}, {-34, 54}, {-34, 22}}, color = {0, 127, 0}));
  connect(doubleActingCylinder.flange_a, fixed.flange) annotation(
    Line(points = {{-54, 22}, {-78, 22}, {-78, 10}}, color = {0, 127, 0}));
  connect(sine1.y, position.s_ref) annotation(
    Line(points = {{30, 76}, {4, 76}, {4, 54}}, color = {0, 0, 127}));
  connect(ramp.y, speed1.w_ref) annotation(
    Line(points = {{54, -56}, {42, -56}}, color = {0, 0, 127}));
  connect(speed1.flange, constantDisplacementPump1.flange_a) annotation(
    Line(points = {{20, -56}, {-40, -56}, {-40, -68}}));
  connect(checkValve.port_b, lpAccumulator.port_a) annotation(
    Line(points = {{-72, -36}, {32, -36}, {32, -12}}, color = {255, 0, 0}));
  connect(checkValve.port_a, constantDisplacementPump1.portP) annotation(
    Line(points = {{-72, -56}, {-50, -56}, {-50, -58}}, color = {255, 0, 0}));
  connect(constPSource.port, constantDisplacementPump1.portT) annotation(
    Line(points = {{-34, -88}, {-50, -88}, {-50, -78}}, color = {255, 0, 0}));
  annotation(
    experiment(StartTime = 0, StopTime = 400, Tolerance = 1e-06, Interval = 0.002),
    uses(OceanEngineeringToolbox(version = "v0.3"), OpenHydraulics(version = "2.0.0")),
    Diagram);
end MP_HIL_checkpoint1;
