within OpenHydraulics.Developed.Circuits;

model DF
  Developed.Cylinders.DoubleActingCylinder doubleActingCylinder(boreDiameter = 0.1484, compressibleEnable = true, strokeLength = 3, pistonRodMass = 1, maxPressure = 2e8, leakageEnable = true, Cv = 1000, f_c = 200, Cst = 5, f_st = 2000, CHeadExLeakage = 0.000000002, CRodExLeakage = 0.000000002, CInLeakage = 0.0000000005, damping = 0, stribeckFrictionEnable = false, rodDiameter(displayUnit = "mm"), closedLength = 0.001, p_init = 1.5e6) annotation(
    Placement(transformation(origin = {-44, 22}, extent = {{-10, -10}, {10, 10}})));
  inner Developed.Systems.System system annotation(
    Placement(transformation(origin = {-64, 72}, extent = {{-10, -10}, {10, 10}})));
  Developed.Machines.ConstantDisplacementPump constantDisplacementPump(CMotorLeakage = 0.00025, Dconst = 312e-6*0.5, p_init(displayUnit = "bar") = 7e6) annotation(
    Placement(transformation(origin = {58, 14}, extent = {{10, 10}, {-10, -10}})));
  Developed.Volumes.Accumulator hpAccumulator(gasVolume = 1, initType = Developed.Types.AccInit.Volume, liquidVolume = 0.95, p_init(displayUnit = "bar") = 7e6, p_precharge(displayUnit = "bar") = 3e6, p_max = 2e8, V_init = 0.5) annotation(
    Placement(transformation(origin = {32, 38}, extent = {{-10, -10}, {10, 10}})));
  Developed.Volumes.Accumulator lpAccumulator(gasVolume = 0.5, initType = Developed.Types.AccInit.Volume, liquidVolume = 0.48, p_init(displayUnit = "bar") = 2e5, p_precharge(displayUnit = "bar") = 1e6, p_max = 5e7, V_init = 0.1) annotation(
    Placement(transformation(origin = {32, -22}, extent = {{-10, 10}, {10, -10}})));
  Developed.Valves.V4_3CC v4_3cc(p_crack(displayUnit = "bar") = 35000, p_init(displayUnit = "bar") = 3e6, p_open(displayUnit = "bar") = 4e4, CvData = Modelica.Fluid.Types.CvTypes.Av, Av = 1e-3, Cd = 1) annotation(
    Placement(transformation(origin = {-36, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Custom.Basic.LaminarRestriction laminarRestriction(D = 1, L = 0.01, p_init(displayUnit = "bar") = 1e6) annotation(
    Placement(transformation(origin = {56, -24}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed annotation(
    Placement(transformation(origin = {106, 14}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.Translational.Sources.Position position(exact = true) annotation(
    Placement(transformation(origin = {-8, 54}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.Translational.Components.Fixed fixed annotation(
    Placement(transformation(origin = {-78, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Sine sine1(amplitude = 1, f = 1/17.7, offset = 1.5) annotation(
    Placement(transformation(origin = {22, 96}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Units.SI.Force Fpto = doubleActingCylinder.boreDiameter^2/4*3.14*(hpAccumulator.port_a.p - lpAccumulator.port_a.p)*sign(doubleActingCylinder.piston.v);
  OpenHydraulics.Developed.Volumes.OpenTank tank annotation(
    Placement(transformation(origin = {82, -20}, extent = {{-10, -10}, {10, 10}})));
  OpenHydraulics.Developed.Valves.ReliefValve reliefValve(Av = 0.001, Cd = 1, CvData = Modelica.Fluid.Types.CvTypes.Av, p_open = 4.01e7, p_relief = 4e7, p_init = 7e6) annotation(
    Placement(transformation(origin = {32, 4}, extent = {{-10, -10}, {10, 10}})));
  OpenHydraulics.Developed.Volumes.OpenTank tank1 annotation(
    Placement(transformation(origin = {68, -74}, extent = {{-10, -10}, {10, 10}})));
  OpenHydraulics.Developed.Valves.ReliefValve reliefValve1(Av = 0.001, Cd = 1, CvData = Modelica.Fluid.Types.CvTypes.Av, p_open = 3.05e6, p_relief = 3e6, p_init = 1e6) annotation(
    Placement(transformation(origin = {18, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp(duration = 0, height = 157) annotation(
    Placement(transformation(origin = {152, 8}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(amplitude = 1, rising = 7, width = 3, falling = 7, period = 18, offset = 1.25)  annotation(
    Placement(transformation(origin = {92, 82}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Add add annotation(
    Placement(transformation(origin = {30, 66}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Blocks.Sources.Trapezoid trapezoid1(amplitude = -2*1, falling = 7, period = 36, rising = 7, width = 3) annotation(
    Placement(transformation(origin = {82, 42}, extent = {{10, -10}, {-10, 10}})));
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
  connect(position.flange, doubleActingCylinder.flange_b) annotation(
    Line(points = {{-18, 54}, {-34, 54}, {-34, 22}}, color = {0, 127, 0}));
  connect(doubleActingCylinder.flange_a, fixed.flange) annotation(
    Line(points = {{-54, 22}, {-78, 22}, {-78, 10}}, color = {0, 127, 0}));
  connect(reliefValve.port_b, tank.port) annotation(
    Line(points = {{42, 4}, {82, 4}, {82, -10}}, color = {255, 0, 0}));
  connect(reliefValve.port_a, hpAccumulator.port_a) annotation(
    Line(points = {{22, 4}, {32, 4}, {32, 28}}, color = {255, 0, 0}));
  connect(reliefValve1.port_a, lpAccumulator.port_a) annotation(
    Line(points = {{8, -50}, {10, -50}, {10, -12}, {32, -12}}, color = {255, 0, 0}));
  connect(reliefValve1.port_b, tank1.port) annotation(
    Line(points = {{28, -50}, {68, -50}, {68, -64}}, color = {255, 0, 0}));
  connect(ramp.y, speed.w_ref) annotation(
    Line(points = {{142, 8}, {118, 8}, {118, 14}}, color = {0, 0, 127}));
  connect(trapezoid.y, add.u1) annotation(
    Line(points = {{81, 82}, {42, 82}, {42, 72}}, color = {0, 0, 127}));
  connect(trapezoid1.y, add.u2) annotation(
    Line(points = {{72, 42}, {42, 42}, {42, 60}}, color = {0, 0, 127}));
  connect(sine1.y, position.s_ref) annotation(
    Line(points = {{12, 96}, {4, 96}, {4, 54}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 400, Tolerance = 1e-06, Interval = 0.002),
    uses(OceanEngineeringToolbox(version = "v0.3"), OpenHydraulics(version = "2.0.0")),
    Diagram);
end DF;
