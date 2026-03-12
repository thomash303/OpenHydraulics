within OpenHydraulics.Developed.Circuits;

model MP_HIL_checkpoint_sens
  Developed.Cylinders.DoubleActingCylinder doubleActingCylinder(boreDiameter = 0.04, compressibleEnable = true, strokeLength = 0.3, pistonRodMass = 1, maxPressure = 2e8, leakageEnable = true, Cv = 1000, f_c = 200, Cst = 5, f_st = 2000, CHeadExLeakage = 0.000000009, CRodExLeakage = 0.000000009, CInLeakage = 0.000000005, damping = 0, stribeckFrictionEnable = false, rodDiameter(displayUnit = "mm") = 0.029, closedLength = 0.0001, p_init = 1e6) annotation(
    Placement(transformation(origin = {-80, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  inner Developed.Systems.System system annotation(
    Placement(transformation(origin = {-64, 72}, extent = {{-10, -10}, {10, 10}})));
  Developed.Machines.ConstantDisplacementPump constantDisplacementPump(CMotorLeakage = 30e-10, Dconst = 4e-6, p_init(displayUnit = "bar") = 3.5e6, leakageEnable = true) annotation(
    Placement(transformation(origin = {66, 12}, extent = {{10, 10}, {-10, -10}})));
  Developed.Volumes.Accumulator hpAccumulator(gasVolume = 3.8e-3, initType = Developed.Types.AccInit.Volume, liquidVolume = 2.8e-3, p_init(displayUnit = "bar") = 3.5e6, p_precharge(displayUnit = "bar") = 1e6, p_max = 2e8, V_init = 2.29e-3) annotation(
    Placement(transformation(origin = {44, 44}, extent = {{-10, -10}, {10, 10}})));
  Developed.Volumes.Accumulator lpAccumulator(gasVolume = 1e-3+ 1e-2, initType = Developed.Types.AccInit.Volume, liquidVolume = 0.7e-3+ 1e-2, p_init(displayUnit = "bar") = 2e5, p_precharge(displayUnit = "bar") = 2e5, p_max = 5e7, V_init = 0.4e-3) annotation(
    Placement(transformation(origin = {32, -22}, extent = {{-10, 10}, {10, -10}})));
  Custom.Basic.LaminarRestriction laminarRestriction(D = 1, L = 0.01, p_init(displayUnit = "bar") = 2e5) annotation(
    Placement(transformation(origin = {56, -24}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed annotation(
    Placement(transformation(origin = {106, 14}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Blocks.Sources.Sine sine(amplitude = 14*2*3.14/60, f = 1/2.5, offset = 198*2*3.14/60) annotation(
    Placement(transformation(origin = {158, 12}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.Translational.Sources.Position position(exact = true) annotation(
    Placement(transformation(origin = {-8, 54}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.Translational.Components.Fixed fixed annotation(
    Placement(transformation(origin = {-82, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Sine sine1(amplitude = 0.1, f = 1/1.58, offset = 0.15) annotation(
    Placement(transformation(origin = {40, 76}, extent = {{10, -10}, {-10, 10}})));
  Developed.Machines.ConstantDisplacementPump constantDisplacementPump1(CMotorLeakage = 0.00025, Dconst = -4e-6, p_init(displayUnit = "bar")) annotation(
    Placement(transformation(origin = {-50, -68}, extent = {{10, -10}, {-10, 10}})));
  Developed.Volumes.OpenTank tank annotation(
    Placement(transformation(origin = {96, -24}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed1(exact = true) annotation(
    Placement(transformation(origin = {30, -56}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp(height = -1700*2*3.14/60, duration = 0) annotation(
    Placement(transformation(origin = {64, -56}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Units.SI.Force Fpto = doubleActingCylinder.rodDiameter^2/4*3.14*(hpAccumulator.port_a.p - lpAccumulator.port_a.p)*sign(doubleActingCylinder.piston.v);
  // Valve parameter
  parameter Modelica.Units.SI.Pressure p_init = 10e5;
  parameter Modelica.Units.SI.Pressure p_crack = 0.35e5;
  parameter Modelica.Units.SI.Pressure p_open = 0.4e5;
  parameter Modelica.Units.SI.Area Av = 5e-5;
  parameter Real Cd = 1;
  Developed.Valves.CheckValve checkValve1(p_init = 1e6, manualValveControl = false, p_crack = p_crack, p_open = p_open, Cd = Cd, CvData = Modelica.Fluid.Types.CvTypes.Av, Av = Av) annotation(
    Placement(transformation(origin = {-52, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Developed.Valves.CheckValve checkValve11(Av = Av, Cd = Cd, CvData = Modelica.Fluid.Types.CvTypes.Av, manualValveControl = false, p_crack = p_crack, p_init = 1e6, p_open = p_open) annotation(
    Placement(transformation(origin = {-30, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Developed.Valves.CheckValve checkValve111(Av = Av, Cd = Cd, CvData = Modelica.Fluid.Types.CvTypes.Av, manualValveControl = false, p_crack = p_crack, p_init = 1e6, p_open = p_open) annotation(
    Placement(transformation(origin = {-10, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Developed.Valves.CheckValve checkValve112(Av = Av, Cd = Cd, CvData = Modelica.Fluid.Types.CvTypes.Av, manualValveControl = false, p_crack = p_crack, p_open = p_open, p_init = 1e6) annotation(
    Placement(transformation(origin = {-4, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Developed.Interfaces.NJunction jB(p_init = 1e6) annotation(
    Placement(transformation(origin = {-42, 42}, extent = {{-10, -10}, {10, 10}})));
  Developed.Interfaces.NJunction jA(p_init = 1e6) annotation(
    Placement(transformation(origin = {-54, -12}, extent = {{-10, -10}, {10, 10}})));
  Developed.Interfaces.NJunction jHP(p_init = 1e6) annotation(
    Placement(transformation(origin = {10, 36}, extent = {{-10, -10}, {10, 10}})));
  Developed.Interfaces.NJunction jLP(p_init = 2e5) annotation(
    Placement(transformation(origin = {12, -4}, extent = {{-10, -10}, {10, 10}})));
  Developed.Valves.ReliefValve reliefValve(p_relief = 1e7, p_open = 1.01e7, Cd = 1, CvData = Modelica.Fluid.Types.CvTypes.Av, Av = 0.001) annotation(
    Placement(transformation(origin = {46, 0}, extent = {{-10, -10}, {10, 10}})));
  Developed.Valves.ReliefValve reliefValve1(Av = 0.001, Cd = 1, CvData = Modelica.Fluid.Types.CvTypes.Av, p_open = 1.01e7, p_relief = 1e7) annotation(
    Placement(transformation(origin = {-20, -64}, extent = {{-10, -10}, {10, 10}})));
  Developed.Volumes.CircuitTank circuitTank(V_max = 1000, V_init = 100) annotation(
    Placement(transformation(origin = {-32, -90}, extent = {{-10, -10}, {10, 10}})));
  Sensors.PressureSensor P1(pressureType = OpenHydraulics.Developed.Types.PressureTypes.Gauge, p_init = 1e6)  annotation(
    Placement(transformation(origin = {-34, 68}, extent = {{-10, -10}, {10, 10}})));
  OpenHydraulics.Developed.Sensors.PressureSensor P2(p_init = 1e6, pressureType = OpenHydraulics.Developed.Types.PressureTypes.Gauge) annotation(
    Placement(transformation(origin = {-92, -34}, extent = {{-10, -10}, {10, 10}})));
  OpenHydraulics.Developed.Sensors.PressureSensor P3(p_init = 1e6, pressureType = OpenHydraulics.Developed.Types.PressureTypes.Gauge) annotation(
    Placement(transformation(origin = {20, 56}, extent = {{-10, -10}, {10, 10}})));
  OpenHydraulics.Developed.Sensors.PressureSensor P4(p_init = 3.5e6, pressureType = OpenHydraulics.Developed.Types.PressureTypes.Gauge) annotation(
    Placement(transformation(origin = {80, 50}, extent = {{-10, -10}, {10, 10}})));
  OpenHydraulics.Developed.Sensors.PressureSensor P5(p_init = 3.5e6, pressureType = OpenHydraulics.Developed.Types.PressureTypes.Gauge) annotation(
    Placement(transformation(origin = {114, 54}, extent = {{-10, -10}, {10, 10}})));
  OpenHydraulics.Developed.Sensors.PressureSensor P6(p_init = 2e5, pressureType = OpenHydraulics.Developed.Types.PressureTypes.Gauge) annotation(
    Placement(transformation(origin = {-112, -66}, extent = {{-10, -10}, {10, 10}})));
  Sensors.FlowSensor F1(p_init = 3.5e6)  annotation(
    Placement(transformation(origin = {24, 22}, extent = {{-10, -10}, {10, 10}})));
  OpenHydraulics.Developed.Sensors.FlowSensor F2(p_init = 3.5e6) annotation(
    Placement(transformation(origin = {60, 30}, extent = {{-10, -10}, {10, 10}})));
  DAQ daq annotation(
    Placement(transformation(origin = {124, -56}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(laminarRestriction.port_b, constantDisplacementPump.portP) annotation(
    Line(points = {{66, -24}, {58, -24}, {58, 2}, {66, 2}}, color = {255, 0, 0}));
  connect(laminarRestriction.port_a, lpAccumulator.port_a) annotation(
    Line(points = {{46, -24}, {32, -24}, {32, -12}}, color = {255, 0, 0}));
  connect(speed.flange, constantDisplacementPump.flange_a) annotation(
    Line(points = {{96, 14}, {83, 14}, {83, 12}, {76, 12}}));
  connect(sine.y, speed.w_ref) annotation(
    Line(points = {{148, 12}, {118, 12}, {118, 14}}, color = {0, 0, 127}));
  connect(doubleActingCylinder.flange_a, fixed.flange) annotation(
    Line(points = {{-80, 18}, {-82, 18}, {-82, -10}}, color = {0, 127, 0}));
  connect(sine1.y, position.s_ref) annotation(
    Line(points = {{30, 76}, {4, 76}, {4, 54}}, color = {0, 0, 127}));
  connect(ramp.y, speed1.w_ref) annotation(
    Line(points = {{54, -56}, {42, -56}}, color = {0, 0, 127}));
  connect(speed1.flange, constantDisplacementPump1.flange_a) annotation(
    Line(points = {{20, -56}, {-40, -56}, {-40, -68}}));
  connect(position.flange, doubleActingCylinder.flange_b) annotation(
    Line(points = {{-18, 54}, {-78, 54}, {-78, 38}, {-80, 38}}, color = {0, 127, 0}));
  connect(lpAccumulator.port_a, jLP.port[1]) annotation(
    Line(points = {{32, -12}, {12, -12}, {12, -4}}, color = {255, 0, 0}));
  connect(checkValve112.port_b, jHP.port[2]) annotation(
    Line(points = {{-4, -4}, {10, -4}, {10, 36}}, color = {255, 0, 0}));
  connect(checkValve111.port_b, jHP.port[3]) annotation(
    Line(points = {{-10, 18}, {10, 18}, {10, 36}}, color = {255, 0, 0}));
  connect(checkValve112.port_a, jA.port[2]) annotation(
    Line(points = {{-4, -24}, {-54, -24}, {-54, -12}}, color = {255, 0, 0}));
  connect(jB.port[2], checkValve111.port_a) annotation(
    Line(points = {{-42, 42}, {-10, 42}, {-10, 38}}, color = {255, 0, 0}));
  connect(checkValve1.port_a, jLP.port[2]) annotation(
    Line(points = {{-52, 4}, {12, 4}, {12, -4}}, color = {255, 0, 0}));
  connect(checkValve1.port_b, jB.port[3]) annotation(
    Line(points = {{-52, 24}, {-44, 24}, {-44, 42}, {-42, 42}}, color = {255, 0, 0}));
  connect(checkValve11.port_b, jA.port[3]) annotation(
    Line(points = {{-30, 12}, {-41, 12}, {-41, -12}, {-54, -12}}, color = {255, 0, 0}));
  connect(checkValve11.port_a, jB.port[4]) annotation(
    Line(points = {{-30, 32}, {-42, 32}, {-42, 42}}, color = {255, 0, 0}));
  connect(reliefValve.port_a, hpAccumulator.port_a) annotation(
    Line(points = {{36, 0}, {36, 34}, {44, 34}}, color = {255, 0, 0}));
  connect(reliefValve.port_b, tank.port) annotation(
    Line(points = {{56, 0}, {56, -14}, {96, -14}}, color = {255, 0, 0}));
  connect(reliefValve1.port_a, constantDisplacementPump1.portP) annotation(
    Line(points = {{-30, -64}, {-36, -64}, {-36, -58}, {-50, -58}}, color = {255, 0, 0}));
  connect(constantDisplacementPump1.portT, circuitTank.port_a) annotation(
    Line(points = {{-50, -78}, {-52, -78}, {-52, -90}, {-42, -90}}, color = {255, 0, 0}));
  connect(circuitTank.port_b, reliefValve1.port_b) annotation(
    Line(points = {{-22, -90}, {-10, -90}, {-10, -64}}, color = {255, 0, 0}));
  connect(P2.port_a, jA.port[5]) annotation(
    Line(points = {{-94, -44}, {-54, -44}, {-54, -12}}, color = {255, 0, 0}));
  connect(P1.port_a, jB.port[5]) annotation(
    Line(points = {{-36, 58}, {-42, 58}, {-42, 42}}, color = {255, 0, 0}));
  connect(P3.port_a, jHP.port[5]) annotation(
    Line(points = {{18, 46}, {10, 46}, {10, 36}}, color = {255, 0, 0}));
  connect(P4.port_a, hpAccumulator.port_a) annotation(
    Line(points = {{78, 40}, {44, 40}, {44, 34}}, color = {255, 0, 0}));
  connect(P5.port_a, constantDisplacementPump.portT) annotation(
    Line(points = {{112, 44}, {88, 44}, {88, 22}, {66, 22}}, color = {255, 0, 0}));
  connect(P6.port_a, jLP.port[5]) annotation(
    Line(points = {{-114, -76}, {12, -76}, {12, -4}}, color = {255, 0, 0}));
  connect(F1.port_a, jHP.port[1]) annotation(
    Line(points = {{14, 22}, {10, 22}, {10, 36}}, color = {255, 0, 0}));
  connect(F1.port_b, hpAccumulator.port_a) annotation(
    Line(points = {{34, 22}, {44, 22}, {44, 34}}, color = {255, 0, 0}));
  connect(hpAccumulator.port_a, F2.port_a) annotation(
    Line(points = {{44, 34}, {50, 34}, {50, 30}}, color = {255, 0, 0}));
  connect(F2.port_b, constantDisplacementPump.portT) annotation(
    Line(points = {{70, 30}, {66, 30}, {66, 22}}, color = {255, 0, 0}));
  connect(P1.y, daq.P1);
  connect(P2.y, daq.P2);
  connect(P3.y, daq.P3);
  connect(P4.y, daq.P4);
  connect(P5.y, daq.P5);
  connect(P6.y, daq.P6);
  connect(F1.y, daq.F1);
  connect(F2.y, daq.F2);
  connect(constantDisplacementPump1.portP, lpAccumulator.port_a) annotation(
    Line(points = {{-50, -58}, {20, -58}, {20, -12}, {32, -12}}, color = {255, 0, 0}));
  connect(doubleActingCylinder.port_a, jB.port[1]) annotation(
    Line(points = {{-72, 20}, {-60, 20}, {-60, 42}, {-42, 42}}, color = {255, 0, 0}));
  connect(doubleActingCylinder.port_b, jA.port[1]) annotation(
    Line(points = {{-72, 36}, {-66, 36}, {-66, -12}, {-54, -12}}, color = {255, 0, 0}));
  annotation(
    experiment(StartTime = 0, StopTime = 400, Tolerance = 1e-06, Interval = 0.002),
    uses(OceanEngineeringToolbox(version = "v0.3"), OpenHydraulics(version = "2.0.0")),
    Diagram);
end MP_HIL_checkpoint_sens;
