within OpenHydraulics.Developed.Circuits;

model hydraulic_validation
  Developed.Cylinders.DoubleActingCylinder doubleActingCylinder(boreDiameter = 0.04, compressibleEnable = true, strokeLength = 0.3, pistonRodMass = 4, maxPressure = 2e8, leakageEnable = true, Cv = 100, f_c = 75, Cst = 0.05, f_st = 50, CHeadExLeakage = 0.00000000055, CRodExLeakage = 0.00000000055, CInLeakage = 0.0000000005, damping = 0, stribeckFrictionEnable = true, rodDiameter(displayUnit = "mm") = 0.029, closedLength = 0.0001, p_init = 1e6, fluidInertiaEnable = true, gravityAccelerationEnable = true) annotation(
    Placement(transformation(origin = {-82, 10}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  inner Developed.Systems.System system annotation(
    Placement(transformation(origin = {-138, 60}, extent = {{-10, -10}, {10, 10}})));
  Developed.Machines.VariableDisplacementMotor variableDisplacementMotor(p_init(displayUnit = "bar") = 3.5e6, CsD = {0, 25, 50, 75, 100}, CvD = {0, 25, 50, 75, 100}, CfD = {0, 25, 50, 75, 100}, Cs = {0, 3.2576e-9, 2.7658e-9, 2.1634e-9, 2.8241e-9}, Cv = {0, 207433, 249350, 286122, 313991}, frictionEnable = true, leakageEnable = true, Dmax = 4e-6, Dmin = -4e-6, Cf = {0, -0.0012, -0.0017, -0.0017, -0.0003}) annotation(
    Placement(transformation(origin = {68, -16}, extent = {{10, -10}, {-10, 10}})));
  Developed.Volumes.Accumulator hpAccumulator(gasVolume = 3.8e-3, initType = Developed.Types.AccInit.Volume, liquidVolume = 2.8e-3, p_init(displayUnit = "bar") = 3.5e6, p_precharge(displayUnit = "bar") = 1e6, p_max = 2e8, V_init = 2.1e-3) annotation(
    Placement(transformation(origin = {38, 20}, extent = {{-10, -10}, {10, 10}})));
  Developed.Volumes.Accumulator lpAccumulator(gasVolume = 1e-3, initType = Developed.Types.AccInit.Volume, liquidVolume = 0.8e-3, p_init(displayUnit = "bar") = 2e5, p_precharge(displayUnit = "bar") = 2e5, p_max = 5e7, V_init = 0.75e-3) annotation(
    Placement(transformation(origin = {54, -46}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  Modelica.Mechanics.Translational.Sources.Position position(exact = true) annotation(
    Placement(transformation(origin = {-110, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Components.Fixed fixed annotation(
    Placement(transformation(origin = {-82, 60}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
  Modelica.Blocks.Sources.Sine inputDisplacement(amplitude = 0.125, f = 0.33, offset = 0.15, phase = 2*3.14*0.33*0.1) annotation(
    Placement(transformation(origin = {-144, -10}, extent = {{-10, -10}, {10, 10}})));
  Developed.Machines.VariableDisplacementPump variableDisplacementPump(Dmax = 4e-6, Dmin = -4e-6, p_init(displayUnit = "bar"), frictionEnable = false, leakageEnable = false) annotation(
    Placement(transformation(origin = {-8, -88}, extent = {{10, -10}, {-10, 10}})));
  Developed.Volumes.OpenTank tank annotation(
    Placement(transformation(origin = {38, -26}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed(exact = true) annotation(
    Placement(transformation(origin = {46, -88}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.Ramp pumpSpeed(height = 47*2*3.14/60, duration = 0) annotation(
    Placement(transformation(origin = {79, -89}, extent = {{7, -7}, {-7, 7}})));
  Modelica.Units.SI.Force Fpto = doubleActingCylinder.Fpto;
  // Valve parameter
  parameter Modelica.Units.SI.Pressure p_init = 10e5;
  parameter Modelica.Units.SI.Pressure p_crack = 0.35e5;
  parameter Modelica.Units.SI.Pressure p_open = 0.4e5;
  parameter Modelica.Units.SI.Area Av = 1.4e-5;
  parameter Real Cd = 0.6;
  Developed.Valves.CheckValve checkValve1(p_init = 1e6, manualValveControl = false, p_crack = p_crack, p_open = p_open, Cd = Cd, CvData = Modelica.Fluid.Types.CvTypes.Av, Av = Av) annotation(
    Placement(transformation(origin = {-50, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Developed.Valves.CheckValve checkValve11(Av = Av, Cd = Cd, CvData = Modelica.Fluid.Types.CvTypes.Av, manualValveControl = false, p_crack = p_crack, p_init = 1e6, p_open = p_open) annotation(
    Placement(transformation(origin = {-26, 12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Developed.Valves.CheckValve checkValve111(Av = Av, Cd = Cd, CvData = Modelica.Fluid.Types.CvTypes.Av, manualValveControl = false, p_crack = p_crack, p_init = 1e6, p_open = p_open) annotation(
    Placement(transformation(origin = {-10, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Developed.Valves.CheckValve checkValve112(Av = Av, Cd = Cd, CvData = Modelica.Fluid.Types.CvTypes.Av, manualValveControl = false, p_crack = p_crack, p_open = p_open, p_init = 1e6) annotation(
    Placement(transformation(origin = {-10, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Developed.Interfaces.NJunction jA(p_init = 1e6) annotation(
    Placement(transformation(origin = {-26, 42}, extent = {{-10, -10}, {10, 10}})));
  Developed.Interfaces.NJunction jB(p_init = 1e6) annotation(
    Placement(transformation(origin = {-26, -34}, extent = {{-10, -10}, {10, 10}})));
  Developed.Interfaces.NJunction jHP(p_init = 1e6) annotation(
    Placement(transformation(origin = {-10, 10}, extent = {{-10, -10}, {10, 10}})));
  Developed.Interfaces.NJunction jLP(p_init = 2e5) annotation(
    Placement(transformation(origin = {-30, -56}, extent = {{-10, -10}, {10, 10}})));
  Developed.Valves.ReliefValve reliefValve(p_relief = 1e7, p_open = 1.01e7, Cd = 1, CvData = Modelica.Fluid.Types.CvTypes.Av, Av = 0.001) annotation(
    Placement(transformation(origin = {38, -6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Developed.Valves.ReliefValve reliefValve1(Av = 1e-4, Cd = 1, CvData = Modelica.Fluid.Types.CvTypes.Av, p_open = 9.5e5, p_relief = 9e5) annotation(
    Placement(transformation(origin = {14, -72}, extent = {{-10, -10}, {10, 10}})));
  Developed.Volumes.CircuitTank circuitTank(V_max = 1000, V_init = 100) annotation(
    Placement(transformation(origin = {2, -110}, extent = {{-10, -10}, {10, 10}})));
  Developed.Sensors.PressureSensor P1(pressureType = Developed.Types.PressureTypes.Gauge, p_init = 1e6) annotation(
    Placement(transformation(origin = {-58, 56}, extent = {{-10, -10}, {10, 10}})));
  Developed.Sensors.PressureSensor P2(p_init = 1e6, pressureType = Developed.Types.PressureTypes.Gauge) annotation(
    Placement(transformation(origin = {-61, -47}, extent = {{-9, 11}, {9, -11}})));
  Developed.Sensors.PressureSensor P3(p_init = 1e6, pressureType = Developed.Types.PressureTypes.Gauge) annotation(
    Placement(transformation(origin = {6, 28}, extent = {{-10, -10}, {10, 10}})));
  Developed.Sensors.PressureSensor P4(p_init = 3.5e6, pressureType = Developed.Types.PressureTypes.Gauge) annotation(
    Placement(transformation(origin = {68, 28}, extent = {{-10, -10}, {10, 10}})));
  Developed.Sensors.PressureSensor P5(p_init = 3.5e6, pressureType = Developed.Types.PressureTypes.Gauge) annotation(
    Placement(transformation(origin = {80, 2}, extent = {{-10, -10}, {10, 10}})));
  Developed.Sensors.PressureSensor P6(p_init = 2e5, pressureType = Developed.Types.PressureTypes.Gauge) annotation(
    Placement(transformation(origin = {-40, -66}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
  Developed.Sensors.FlowSensor F1(p_init = 3.5e6) annotation(
    Placement(transformation(origin = {16, 10}, extent = {{-10, -10}, {10, 10}})));
  Developed.Sensors.FlowSensor F2(p_init = 3.5e6) annotation(
    Placement(transformation(origin = {54, 10}, extent = {{-10, -10}, {10, 10}})));
  Developed.Circuits.DAQ daq annotation(
    Placement(transformation(origin = {-138, 34}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Components.Damper damper(d = 0.0105, w_rel(start = -157.07963267948966, fixed = true, displayUnit = "rpm"))  annotation(
    Placement(transformation(origin = {128, -16}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 0.125, w(start = 157.07963267948966, displayUnit = "rpm"))  annotation(
    Placement(transformation(origin = {98, -16}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed1 annotation(
    Placement(transformation(origin = {150, -24}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp motorDisplacementFraction(height = 1, duration = 0) annotation(
    Placement(transformation(origin = {94, -42}, extent = {{8, -8}, {-8, 8}})));
  Modelica.Blocks.Sources.Ramp pumpDisplacementFraction(duration = 0, height = 1) annotation(
    Placement(transformation(origin = {33, -107}, extent = {{5, -5}, {-5, 5}})));
equation
  connect(speed.flange, variableDisplacementPump.flange_a) annotation(
    Line(points = {{36, -88}, {0, -88}}));
  connect(lpAccumulator.port_a, jLP.port[1]) annotation(
    Line(points = {{54, -56}, {-30, -56}}, color = {255, 0, 0}));
  connect(checkValve112.port_b, jHP.port[2]) annotation(
    Line(points = {{-10, -6}, {-10, 10}}, color = {255, 0, 0}));
  connect(jB.port[2], checkValve111.port_a) annotation(
    Line(points = {{-26, 42}, {-8, 42}, {-8, 38}, {-10, 38}}, color = {255, 0, 0}));
  connect(checkValve11.port_a, jB.port[4]) annotation(
    Line(points = {{-26, 22}, {-26, 42}}, color = {255, 0, 0}));
  connect(reliefValve.port_a, hpAccumulator.port_a) annotation(
    Line(points = {{38, 4}, {38, 10}}, color = {255, 0, 0}));
  connect(reliefValve.port_b, tank.port) annotation(
    Line(points = {{38, -16}, {38, -16}}, color = {255, 0, 0}));
  connect(P1.port_a, jB.port[5]) annotation(
    Line(points = {{-61, 46}, {-61, 42}, {-26, 42}}, color = {255, 0, 0}));
  connect(F1.port_a, jHP.port[1]) annotation(
    Line(points = {{6, 10}, {-10, 10}}, color = {255, 0, 0}));
  connect(P1.p, daq.P1);
  connect(P2.p, daq.P2);
  connect(P3.p, daq.P3);
  connect(P4.p, daq.P4);
  connect(P5.p, daq.P5);
  connect(P6.p, daq.P6);
  connect(F1.m_flow, daq.F1);
  connect(F2.m_flow, daq.F2);
  connect(jB.port[1], doubleActingCylinder.port_a) annotation(
    Line(points = {{-26, 42}, {-68, 42}, {-68, 18}, {-74, 18}}, color = {255, 0, 0}));
  connect(jA.port[1], doubleActingCylinder.port_b) annotation(
    Line(points = {{-26, -34}, {-70, -34}, {-70, 2}, {-74, 2}}, color = {255, 0, 0}));
  connect(damper.flange_b, fixed1.flange) annotation(
    Line(points = {{138, -16}, {150, -16}, {150, -24}}));
  connect(inertia.flange_b, damper.flange_a) annotation(
    Line(points = {{108, -16}, {118, -16}}));
  connect(inertia.flange_a, variableDisplacementMotor.flange_a) annotation(
    Line(points = {{88, -16}, {76, -16}}));
  connect(F2.port_b, variableDisplacementMotor.portP) annotation(
    Line(points = {{64, 10}, {68.5, 10}, {68.5, -8}, {69, -8}}, color = {255, 0, 0}));
  connect(P5.port_a, variableDisplacementMotor.portP) annotation(
    Line(points = {{77, -8}, {69, -8}}, color = {255, 0, 0}));
  connect(variableDisplacementMotor.portT, lpAccumulator.port_a) annotation(
    Line(points = {{69, -24}, {68, -24}, {68, -56}, {54, -56}}, color = {255, 0, 0}));
  connect(inputDisplacement.y, position.s_ref) annotation(
    Line(points = {{-133, -10}, {-122, -10}}, color = {0, 0, 127}));
  connect(fixed.flange, doubleActingCylinder.flange_a) annotation(
    Line(points = {{-82, 60}, {-82, 20}}, color = {0, 127, 0}));
  connect(position.flange, doubleActingCylinder.flange_b) annotation(
    Line(points = {{-100, -10}, {-82, -10}, {-82, 0}}, color = {0, 127, 0}));
  connect(checkValve111.port_b, jHP.port[3]) annotation(
    Line(points = {{-10, 18}, {-10, 10}}, color = {255, 0, 0}));
  connect(P3.port_a, jHP.port[5]) annotation(
    Line(points = {{3, 18}, {3, 10}, {-10, 10}}, color = {255, 0, 0}));
  connect(F1.port_b, hpAccumulator.port_a) annotation(
    Line(points = {{26, 10}, {38, 10}}, color = {255, 0, 0}));
  connect(hpAccumulator.port_a, F2.port_a) annotation(
    Line(points = {{38, 10}, {44, 10}}, color = {255, 0, 0}));
  connect(P4.port_a, F2.port_b) annotation(
    Line(points = {{65, 18}, {64, 18}, {64, 10}}, color = {255, 0, 0}));
  connect(motorDisplacementFraction.y, variableDisplacementMotor.dispFraction) annotation(
    Line(points = {{85, -42}, {80, -42}, {80, -22}, {76, -22}}, color = {0, 0, 127}));
  connect(lpAccumulator.port_a, variableDisplacementPump.portP) annotation(
    Line(points = {{54, -56}, {-8, -56}, {-8, -80}}, color = {255, 0, 0}));
  connect(reliefValve1.port_a, variableDisplacementPump.portP) annotation(
    Line(points = {{4, -72}, {-8, -72}, {-8, -80}}, color = {255, 0, 0}));
  connect(variableDisplacementPump.portT, circuitTank.port_a) annotation(
    Line(points = {{-8, -96}, {-8, -110}}, color = {255, 0, 0}));
  connect(reliefValve1.port_b, circuitTank.port_b) annotation(
    Line(points = {{24, -72}, {24, -110}, {12, -110}}, color = {255, 0, 0}));
  connect(pumpDisplacementFraction.y, variableDisplacementPump.dispFraction) annotation(
    Line(points = {{27.5, -107}, {27.5, -94}, {0, -94}}, color = {0, 0, 127}));
  connect(jA.port[2], checkValve112.port_a) annotation(
    Line(points = {{-26, -34}, {-10, -34}, {-10, -26}}, color = {255, 0, 0}));
  connect(checkValve11.port_b, jA.port[3]) annotation(
    Line(points = {{-26, 2}, {-26, -34}}, color = {255, 0, 0}));
  connect(checkValve1.port_b, jB.port[3]) annotation(
    Line(points = {{-50, 22}, {-50, 42}, {-26, 42}}, color = {255, 0, 0}));
  connect(P2.port_a, jA.port[5]) annotation(
    Line(points = {{-64, -36}, {-64, -34}, {-26, -34}}, color = {255, 0, 0}));
  connect(checkValve1.port_a, jLP.port[2]) annotation(
    Line(points = {{-50, 2}, {-50, -56}, {-30, -56}}, color = {255, 0, 0}));
  connect(P6.port_a, jLP.port[5]) annotation(
    Line(points = {{-42, -56}, {-30, -56}}, color = {255, 0, 0}));
  connect(pumpSpeed.y, speed.w_ref) annotation(
    Line(points = {{72, -88}, {58, -88}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 400, Tolerance = 1e-06, Interval = 0.002),
    uses(OceanEngineeringToolbox(version = "v0.3"), OpenHydraulics(version = "2.0.0")),
    Diagram(coordinateSystem(extent = {{-160, 80}, {160, -120}})));
end hydraulic_validation;
