within OpenHydraulics.Developed.Circuits;

model w2w_sens_hydro
  import Modelica.Units.SI;
    // Importing from the OET
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
  OceanEngineeringToolbox.Hydro.HydrodynamicBody float(I_11 = 20907301, I_22 = 21306091, I_33 = 37085481, animationEnable = true, bodyColour = {255, 255, 0}, bodyIndex = 1, enableDampingDragForce = false, enableExcitationForce = true, enableHydrostaticForce = true, enableRadiationForce = true, geometryFile = "file://C:/Users/thogan1/Documents/GitHub/OceanEngineeringToolbox/applications/Validation/RM3/geometry/float.stl", ra_CM = {0, 0, 0.5}, Ad = {0, 0, 5, 0, 0, 0}, Cv = {0, 0, 1e5, 0, 0, 0}, morison(morisonForce(redeclare NoCurrent currentModel "No current", redeclare LinearWaveKin waveModel(file = fileDirectory.file) "Linear wave kinematics")), Cd = {{1}, {1}}, Ac = {{19.6350}, {19.6350}}, enableMorisonForce = true) annotation(
    Placement(transformation(origin = {-53, 39}, extent = {{-15, -15}, {15, 15}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic(n = {0, 0, 1}, useAxisFlange = true) annotation(
    Placement(transformation(origin = {-68, -24}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  Developed.Cylinders.DoubleActingCylinder doubleActingCylinder(boreDiameter = 0.1484, compressibleEnable = true, strokeLength = 3, pistonRodMass = 5, maxPressure = 2e8, leakageEnable = true, Cv = 15, f_c = 10, Cst = 5, f_st = 1, CHeadExLeakage = 0.000000002, CRodExLeakage = 0.000000002, CInLeakage = 0.0000000005, damping = 0, stribeckFrictionEnable = true, p_init = 1.5e6, closedLength = 0.001, initType = Developed.Types.RevoluteInit.Position, s_init = 1.5) annotation(
    Placement(transformation(origin = {-32, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  inner OceanEngineeringToolbox.Multibody.Worlds.World world annotation(
    Placement(transformation(origin = {-88, 86}, extent = {{-10, -10}, {10, 10}})));
  inner OceanEngineeringToolbox.DataImport.FileDirectory fileDirectory(file = "C:/Users/thogan1/Documents/GitHub/OceanEngineeringToolbox/applications/Validation/W2W/hydro/Radiation_heave_only/SPHERE_3480phydroCoeff_FOAMM.mat") annotation(
    Placement(transformation(origin = {10, 86}, extent = {{-9, -7.25}, {9, 7.25}})));
  inner OceanEngineeringToolbox.Environmental.Environment environment(redeclare RegularWave wave(file = fileDirectory.file, Tp = 15) "Regular wave") annotation(
    Placement(transformation(origin = {-24, 86}, extent = {{-10, -8}, {10, 8}})));
  inner Developed.Systems.System system annotation(
    Placement(transformation(origin = {-56, 86}, extent = {{-10, -10}, {10, 10}})));
  OceanEngineeringToolbox.Multibody.Joints.Fixed fixed(r = {0, 0, -2}) annotation(
    Placement(transformation(origin = {-68, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  parameter Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SquirrelCageData aimcData "Induction machine data" annotation(
    Placement(transformation(origin = {50, 122}, extent = {{-20, -80}, {0, -60}})));
 // DAQ_w2w_power daq annotation(
  //  Placement(transformation(origin = {150, 60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Sensors.AbsoluteSensor mbAbsoluteSensor(get_r = true, get_v = true) annotation(
    Placement(transformation(origin = {-20, 38}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  Volumes.CircuitTank circuitTank annotation(
    Placement(transformation(origin = {14, -28}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(prismatic.frame_b, float.frame_a) annotation(
    Line(points = {{-68, -14}, {-68, 39}}, color = {95, 95, 95}));
  connect(doubleActingCylinder.flange_b, prismatic.axis) annotation(
    Line(points = {{-32, -16}, {-62, -16}}, color = {0, 127, 0}));
  connect(fixed.frame_b, prismatic.frame_a) annotation(
    Line(points = {{-68, -78}, {-68, -34}}, color = {95, 95, 95}));
  connect(prismatic.support, doubleActingCylinder.flange_a) annotation(
    Line(points = {{-62, -28}, {-50, -28}, {-50, -36}, {-32, -36}}, color = {0, 127, 0}));
// Sensing bus
//daq.eta = environment.wave.SSE;
//daq.Fexc = float.excitation.excitationForce.F[3];
//daq.Fpto = Fpto;
//daq.D = variableDisplacementMotor.fluidPower2MechRot.D;
// Sensing bus

  connect(mbAbsoluteSensor.frame_a, float.frame_b) annotation(
    Line(points = {{-30, 38}, {-34, 38}, {-34, 39}, {-38, 39}}, color = {95, 95, 95}));
  connect(doubleActingCylinder.port_a, circuitTank.port_a) annotation(
    Line(points = {{-24, -34}, {4, -34}, {4, -28}}, color = {255, 0, 0}));
  connect(doubleActingCylinder.port_b, circuitTank.port_b) annotation(
    Line(points = {{-24, -18}, {24, -18}, {24, -28}}, color = {255, 0, 0}));
  annotation(
    experiment(StartTime = 0, StopTime = 400, Tolerance = 1e-06, Interval = 0.002),
    uses(OceanEngineeringToolbox(version = "v0.3"), OpenHydraulics(version = "2.0.0")),
    Diagram(coordinateSystem(extent = {{-100, 100}, {220, -100}})));
end w2w_sens_hydro;
