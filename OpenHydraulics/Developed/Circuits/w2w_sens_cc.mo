within OpenHydraulics.Developed.Circuits;

model w2w_sens_cc
  import Modelica.Units.SI;
    import OceanEngineeringToolbox.Hydro.*;
  import OceanEngineeringToolbox.Hydro.Forces.SubForces.MorisonForces.CurrentModels.*;
  import OceanEngineeringToolbox.Hydro.Forces.SubForces.MorisonForces.WaveModels.*;
  import OceanEngineeringToolbox.Environmental.Wave.WaveTypes.WaveSpectrumType;
  import OceanEngineeringToolbox.Environmental.Wave.WaveFunctions.SpectrumDiscritization.EqualEnergyDiscritization.*;
  import OceanEngineeringToolbox.Environmental.Wave.WaveFunctions.SpectrumDiscritization.RandomDiscritization.*;
  import OceanEngineeringToolbox.Environmental.Wave.WaveFunctions.SpectrumDiscritization.*;
  import OceanEngineeringToolbox.Environmental.Wave.WaveModels.*;
  import OceanEngineeringToolbox.Environmental.Wave.WaveTypes.WaveSpectrumType.*;
  // Parameters
  constant Integer m = 3 "Number of phases";
  parameter Modelica.Units.SI.Voltage VNominal = 100 "Nominal RMS voltage per phase";
  parameter Modelica.Units.SI.Frequency fNominal = 50 "Nominal frequency";
  parameter Modelica.Units.SI.Time tStart1 = 0.1 "Start time";
  parameter Modelica.Units.SI.Torque TLoad = 161.4 "Nominal load torque";
  parameter Modelica.Units.SI.AngularVelocity wLoad(displayUnit = "rev/min") = 1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
  parameter Modelica.Units.SI.Inertia JLoad = 0.29 "Load's moment of inertia";
  OceanEngineeringToolbox.Hydro.HydrodynamicBody float(I_11 = 20907301, I_22 = 21306091, I_33 = 37085481, animationEnable = true, bodyColour = {255, 255, 0}, bodyIndex = 1, enableDampingDragForce = false, enableExcitationForce = true, enableHydrostaticForce = true, enableRadiationForce = true, geometryFile = "file://C:/Users/thogan1/Documents/GitHub/OceanEngineeringToolbox/applications/Validation/RM3/geometry/float.stl", ra_CM = {0, 0, 0.5}, Ad = {0, 0, 5, 0, 0, 0}, Cv = {0, 0, 1e5, 0, 0, 0}, enableMorisonForce = true) annotation(
    Placement(transformation(origin = {-53, 37}, extent = {{-15, -15}, {15, 15}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic(n = {0, 0, 1}, useAxisFlange = true) annotation(
    Placement(transformation(origin = {-68, -24}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  Developed.Cylinders.DoubleActingCylinder doubleActingCylinder(boreDiameter = 0.1484, compressibleEnable = true, strokeLength = 3, pistonRodMass = 5, maxPressure = 2e8, leakageEnable = true, Cv = 15, f_c = 10, Cst = 5, f_st = 10, CHeadExLeakage = 0.000000002, CRodExLeakage = 0.000000002, CInLeakage = 0.0000000005, damping = 0, stribeckFrictionEnable = true, p_init = 7e6, closedLength = 0.001, initType = Developed.Types.RevoluteInit.Position, s_init = 1.5) annotation(
    Placement(transformation(origin = {-32, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  inner OceanEngineeringToolbox.Multibody.Worlds.World world annotation(
    Placement(transformation(origin = {-88, 86}, extent = {{-10, -10}, {10, 10}})));
  inner OceanEngineeringToolbox.DataImport.FileDirectory fileDirectory(file = "C:/Users/thogan1/Documents/GitHub/OceanEngineeringToolbox/applications/Validation/W2W/hydro/Radiation_heave_only/SPHERE_3480phydroCoeff_FOAMM.mat") annotation(
    Placement(transformation(origin = {10, 86}, extent = {{-9, -7.25}, {9, 7.25}})));
  inner OceanEngineeringToolbox.Environmental.Environment environment(redeclare RegularWave wave(file = fileDirectory.file) "Regular wave") annotation(
    Placement(transformation(origin = {-24, 86}, extent = {{-10, -8}, {10, 8}})));
  inner Developed.Systems.System system annotation(
    Placement(transformation(origin = {-56, 86}, extent = {{-10, -10}, {10, 10}})));
  OceanEngineeringToolbox.Multibody.Joints.Fixed fixed(r = {0, 0, -2}) annotation(
    Placement(transformation(origin = {-68, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Developed.Machines.VariableDisplacementMotor variableDisplacementMotor(Dmax = 180e-6, Dmin = -180e-6, p_init(displayUnit = "bar") = 7e6, frictionEnable = false, leakageEnable = false, p_init_P = 7e6, p_init_T = 7e6) annotation(
    Placement(transformation(origin = {62, -22}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Developed.Volumes.Accumulator hpAccumulator(gasVolume = 0.2, initType = Developed.Types.AccInit.Volume, liquidVolume = 0.19, p_init(displayUnit = "bar") = 7e6, p_precharge(displayUnit = "bar") = 3e6, p_max = 2e8, V_init = 0.18) annotation(
    Placement(transformation(origin = {28, 20}, extent = {{-10, -10}, {10, 10}})));
  Developed.Volumes.Accumulator lpAccumulator(gasVolume = 0.2, initType = Developed.Types.AccInit.Volume, liquidVolume = 0.19, p_init(displayUnit = "bar") = 2e5, p_precharge(displayUnit = "bar") = 1e6, p_max = 5e7, V_init = 0.05) annotation(
    Placement(transformation(origin = {26, -72}, extent = {{-10, 10}, {10, -10}})));
  Developed.Valves.V4_3CC v4_3cc(p_crack(displayUnit = "bar") = 25000, p_init(displayUnit = "bar") = 7e6, p_open(displayUnit = "bar") = 5e4, CvData = Modelica.Fluid.Types.CvTypes.Av, Av = 15e-5, Cd = 1, p_init_P = 7e6, p_init_T = 7e6) annotation(
    Placement(transformation(origin = {0, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Custom.Basic.LaminarRestriction laminarRestriction(D = 1, L = 0.01, p_init(displayUnit = "bar") = 1e6) annotation(
    Placement(transformation(origin = {52, -62}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Units.SI.Force Fpto = doubleActingCylinder.boreDiameter^2/4*3.14*(hpAccumulator.port_a.p - lpAccumulator.port_a.p)*sign(float.body.absoluteSensor.v[3]);
  Developed.Volumes.OpenTank tank annotation(
    Placement(transformation(origin = {28, -34}, extent = {{-10, -10}, {10, 10}})));
  Developed.Valves.ReliefValve reliefValve(Av = 0.1, Cd = 1, CvData = Modelica.Fluid.Types.CvTypes.Av, p_init = 7e6, p_open = 3.51e7, p_relief = 3.5e7) annotation(
    Placement(transformation(origin = {28, -6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Machines.BasicMachines.InductionMachines.IM_SquirrelCage aimc(Jr = aimcData.Jr, Js = aimcData.Js, Lm = aimcData.Lm, Lrsigma = aimcData.Lrsigma, Lssigma = aimcData.Lssigma, Lszero = aimcData.Lszero, Rr = aimcData.Rr, Rs = aimcData.Rs, TrOperational = 293.15, TrRef(displayUnit = "K") = 0, TsOperational = 293.15, TsRef(displayUnit = "K") = 0, alpha20r = 0, alpha20s(displayUnit = "1/K") = 0, frictionParameters(PRef = 2.5, wRef(displayUnit = "rad/s") = 1, power_w = 1), fsNominal = aimcData.fsNominal, p = aimcData.p, phiMechanical(fixed = false, start = 0), statorCoreParameters(VRef = 0), strayLoadParameters(IRef = 0, power_w = 0), wMechanical(fixed = false, start = 0)) annotation(
    Placement(transformation(origin = {108, 18}, extent = {{20, -50}, {0, -30}})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(V = fill(sqrt(2/3)*VNominal, m), f = fill(fNominal, m), final m = m) annotation(
    Placement(transformation(origin = {158, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Polyphase.Basic.Star star(final m = m) annotation(
    Placement(transformation(origin = {126, -110}, extent = {{50, 80}, {70, 100}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(origin = {216, -20}, extent = {{10, -10}, {-10, 10}}, rotation = -270)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection = "D") annotation(
    Placement(transformation(origin = {108, 18}, extent = {{20, -34}, {0, -14}})));
  parameter Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SquirrelCageData aimcData(Jr = 2, frictionParameters(PRef = 2.5,wRef(displayUnit = "rad/s") = 1, power_w = 1))  "Induction machine data" annotation(
    Placement(transformation(origin = {50, 122}, extent = {{-20, -80}, {0, -60}})));
  DAQ_w2w_power daq annotation(
    Placement(transformation(origin = {150, 60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor rotSpeedSensor annotation(
    Placement(transformation(origin = {92, 4}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor annotation(
    Placement(transformation(origin = {90, -22}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Sensors.AbsoluteSensor mbAbsoluteSensor(get_r = true, get_v = true) annotation(
    Placement(transformation(origin = {-20, 38}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  Sensors.FlowSensor pistonOutflow(p_init = 7e6) annotation(
    Placement(transformation(origin = {8, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Sensors.FlowSensor motorFlow(p_init = 7e6) annotation(
    Placement(transformation(origin = {52, 10}, extent = {{-10, -10}, {10, 10}})));
  Sensors.FlowSensor pistonInflow(p_init = 3e6) annotation(
    Placement(transformation(origin = {8, -48}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  Sensors.PressureSensor pA(p_init = 7e6, pressureType = Developed.Types.PressureTypes.Gauge) annotation(
    Placement(transformation(origin = {-22, -56}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
  Sensors.PressureSensor pB(p_init = 7e6, pressureType = Developed.Types.PressureTypes.Gauge) annotation(
    Placement(transformation(origin = {-22, 6}, extent = {{-10, -10}, {10, 10}})));
  Sensors.PressureSensor pHP(p_init = 7e6, pressureType = Developed.Types.PressureTypes.Gauge) annotation(
    Placement(transformation(origin = {8, 40}, extent = {{-10, -10}, {10, 10}})));
  Sensors.PressureSensor pLP(p_init = 3e6, pressureType = Developed.Types.PressureTypes.Gauge) annotation(
    Placement(transformation(origin = {46, -86}, extent = {{-10, 10}, {10, -10}})));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentRMSSensor annotation(
    Placement(transformation(origin = {136, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Machines.Sensors.VoltageQuasiRMSSensor voltageRMSSensor annotation(
    Placement(transformation(origin = {158, -48}, extent = {{10, 10}, {-10, -10}})));
  Modelica.Blocks.Sources.Ramp motorDisplacementFraction(duration = 0, height = 1) annotation(
    Placement(transformation(origin = {100, -54}, extent = {{8, -8}, {-8, 8}})));
equation
  connect(prismatic.frame_b, float.frame_a) annotation(
    Line(points = {{-68, -14}, {-68, 37}}, color = {95, 95, 95}));
  connect(doubleActingCylinder.flange_b, prismatic.axis) annotation(
    Line(points = {{-32, -16}, {-62, -16}}, color = {0, 127, 0}));
  connect(fixed.frame_b, prismatic.frame_a) annotation(
    Line(points = {{-68, -78}, {-68, -34}}, color = {95, 95, 95}));
  connect(laminarRestriction.port_a, lpAccumulator.port_a) annotation(
    Line(points = {{42, -62}, {26, -62}}, color = {255, 0, 0}));
  connect(prismatic.support, doubleActingCylinder.flange_a) annotation(
    Line(points = {{-62, -28}, {-50, -28}, {-50, -36}, {-32, -36}}, color = {0, 127, 0}));
  connect(doubleActingCylinder.port_b, v4_3cc.portB) annotation(
    Line(points = {{-24, -18}, {-8, -18}, {-8, -22}}, color = {255, 0, 0}));
  connect(doubleActingCylinder.port_a, v4_3cc.portA) annotation(
    Line(points = {{-24, -34}, {-8, -34}, {-8, -30}}, color = {255, 0, 0}));
  connect(reliefValve.port_a, hpAccumulator.port_a) annotation(
    Line(points = {{28, 4}, {28, 10}}, color = {255, 0, 0}));
  connect(reliefValve.port_b, tank.port) annotation(
    Line(points = {{28, -16}, {28, -24}}, color = {255, 0, 0}));
  connect(star.pin_n, ground.p) annotation(
    Line(points = {{196, -20}, {206, -20}}, color = {0, 0, 255}));
  connect(terminalBox.plug_sn, aimc.plug_sn) annotation(
    Line(points = {{124, -12}, {124, -12}}, color = {0, 0, 255}));
  connect(terminalBox.plug_sp, aimc.plug_sp) annotation(
    Line(points = {{112, -12}, {112, -12}}, color = {0, 0, 255}));
  connect(sineVoltage.plug_n, star.plug_p) annotation(
    Line(points = {{168, -20}, {176, -20}}, color = {0, 0, 255}));
// Sensing bus
//daq.eta = environment.wave.SSE;
//daq.Fexc = float.excitation.excitationForce.F[3];
//daq.Fpto = Fpto;
//daq.D = variableDisplacementMotor.fluidPower2MechRot.D;
// Sensing bus
  daq.eta = environment.wave.SSE;
  daq.Fexc = float.excitation.excitationForce.F[3];
//daq.Fpto = Fpto;
  daq.D = variableDisplacementMotor.fluidPower2MechRot.D;
// Environment
  daq.Pwav = environment.wave.P "Wave power";
  daq.Fpto = doubleActingCylinder.Fpto;
  daq.Finer = doubleActingCylinder.Finer;
  daq.FpistIner = doubleActingCylinder.FpistIner;
  daq.FgravIner = doubleActingCylinder.FgravIner;
  daq.FflIner = doubleActingCylinder.FflIner;
  daq.Ffric = doubleActingCylinder.Ffric;
// Power
  daq.Pcyl_mech = doubleActingCylinder.Pcyl_mech;
  daq.Pcyl_hyd = doubleActingCylinder.Pcyl_hyd;
// Energy
  daq.Ecyl_mech = doubleActingCylinder.Ecyl_mech;
  daq.Ecyl_hyd = doubleActingCylinder.Ecyl_hyd;
  daq.Pmot_mech = variableDisplacementMotor.Pmot_mech;
  daq.E_mech = variableDisplacementMotor.Emot_mech;
  daq.Pelec = aimc.powerBalance.powerStator;
  daq.Pgen_fric = aimc.powerBalance.lossPowerFriction;
  daq.Pgen_cop = aimc.powerBalance.lossPowerStatorWinding + aimc.powerBalance.lossPowerRotorWinding;
  daq.Pgen_mech = aimc.powerBalance.powerMechanical;
  connect(rotSpeedSensor.flange, variableDisplacementMotor.flange_a) annotation(
    Line(points = {{82, 4}, {70, 4}, {70, -22}}));
  connect(rotSpeedSensor.w, daq.sensor_bus.omega);
  connect(variableDisplacementMotor.flange_a, torqueSensor.flange_a) annotation(
    Line(points = {{70, -22}, {80, -22}}));
  connect(torqueSensor.flange_b, aimc.flange) annotation(
    Line(points = {{100, -22}, {108, -22}}));
  connect(torqueSensor.tau, daq.sensor_bus.T);
  connect(mbAbsoluteSensor.r[3], daq.sensor_bus.s);
  connect(mbAbsoluteSensor.v[3], daq.sensor_bus.v);
  connect(v4_3cc.portT, pistonOutflow.port_a) annotation(
    Line(points = {{8, -22}, {8, -12}}, color = {255, 0, 0}));
  connect(pistonOutflow.port_b, hpAccumulator.port_a) annotation(
    Line(points = {{8, 8}, {8, 10}, {28, 10}}, color = {255, 0, 0}));
  connect(hpAccumulator.port_a, motorFlow.port_a) annotation(
    Line(points = {{28, 10}, {42, 10}}, color = {255, 0, 0}));
  connect(lpAccumulator.port_a, pistonInflow.port_a) annotation(
    Line(points = {{26, -62}, {8, -62}, {8, -58}}, color = {255, 0, 0}));
  connect(pistonInflow.port_b, v4_3cc.portP) annotation(
    Line(points = {{8, -38}, {8, -30}}, color = {255, 0, 0}));
  connect(pistonOutflow.m_flow, daq.sensor_bus.mHP);
  connect(motorFlow.m_flow, daq.sensor_bus.mm);
  connect(pistonInflow.m_flow, daq.sensor_bus.mLP);
  connect(pA.port_a, doubleActingCylinder.port_a) annotation(
    Line(points = {{-24, -46}, {-24, -34}}, color = {255, 0, 0}));
  connect(pB.port_a, doubleActingCylinder.port_b) annotation(
    Line(points = {{-24, -4}, {-24, -18}}, color = {255, 0, 0}));
  connect(pHP.port_a, hpAccumulator.port_a) annotation(
    Line(points = {{6, 30}, {6, 10}, {28, 10}}, color = {255, 0, 0}));
  connect(pA.p, daq.sensor_bus.pA);
  connect(pB.p, daq.sensor_bus.pB);
  connect(pHP.p, daq.sensor_bus.pHP);
  connect(pLP.p, daq.sensor_bus.pLP);
  connect(terminalBox.plugSupply, currentRMSSensor.plug_p) annotation(
    Line(points = {{118, -10}, {118, 0}, {126, 0}}, color = {0, 0, 255}));
  connect(currentRMSSensor.plug_n, sineVoltage.plug_p) annotation(
    Line(points = {{146, 0}, {148, 0}, {148, -20}}, color = {0, 0, 255}));
  connect(voltageRMSSensor.plug_p, star.plug_p) annotation(
    Line(points = {{168, -48}, {176, -48}, {176, -20}}, color = {0, 0, 255}));
  connect(voltageRMSSensor.plug_n, sineVoltage.plug_p) annotation(
    Line(points = {{148, -48}, {148, -20}}, color = {0, 0, 255}));
  connect(currentRMSSensor.I, daq.sensor_bus.i);
  connect(voltageRMSSensor.V, daq.sensor_bus.V);
  connect(pLP.port_a, laminarRestriction.port_a) annotation(
    Line(points = {{44, -76}, {42, -76}, {42, -62}}, color = {255, 0, 0}));
  connect(mbAbsoluteSensor.frame_a, float.frame_b) annotation(
    Line(points = {{-30, 38}, {-38, 38}}, color = {95, 95, 95}));
  connect(motorDisplacementFraction.y, variableDisplacementMotor.dispFraction) annotation(
    Line(points = {{91, -54}, {69, -54}, {69, -29}}, color = {0, 0, 127}));
  connect(laminarRestriction.port_b, variableDisplacementMotor.portT) annotation(
    Line(points = {{62, -62}, {62, -30}}, color = {255, 0, 0}));
  connect(motorFlow.port_b, variableDisplacementMotor.portP) annotation(
    Line(points = {{62, 10}, {62, -14}}, color = {255, 0, 0}));
  annotation(
    experiment(StartTime = 0, StopTime = 400, Tolerance = 1e-06, Interval = 0.002),
    uses(OceanEngineeringToolbox(version = "v0.3"), OpenHydraulics(version = "2.0.0")),
    Diagram(coordinateSystem(extent = {{-100, 100}, {220, -100}})));
end w2w_sens_cc;
