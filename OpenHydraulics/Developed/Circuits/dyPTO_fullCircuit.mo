within OpenHydraulics.Developed.Circuits;

model dyPTO_fullCircuit
  OceanEngineeringToolbox.Hydro.HydrodynamicBody float(I_11 = 20907301, I_22 = 21306091, I_33 = 37085481, animationEnable = true, bodyColour = {255, 255, 0}, bodyIndex = 1, enableDampingDragForce = true, enableExcitationForce = true, enableHydrostaticForce = true, enableRadiationForce = false, geometryFile = "file://C:/Users/thogan1/Documents/GitHub/OceanEngineeringToolbox/applications/Validation/RM3/geometry/float.stl", ra_CM = {0, 0, 0.5}, CD = {0, 0, 100, 0, 0, 0}, Ad = {0, 0, 5, 0, 0, 0}) annotation(
    Placement(transformation(origin = {79, -79}, extent = {{-15, -15}, {15, 15}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic(n = {0, 0, 1}, useAxisFlange = true) annotation(
    Placement(transformation(origin = {-6, -42}, extent = {{-10, -10}, {10, 10}})));
  Developed.Cylinders.DoubleActingCylinder doubleActingCylinder(boreDiameter = 0.15, compressibleEnable = true, strokeLength = 2, pistonRodMass = 5, maxPressure = 1e8, initType = Developed.Types.RevoluteInit.Position, s_init = 1, leakageEnable = true, Cv = 10000, f_c = 200, Cst = 10, f_st = 15000, CHeadExLeakage = 0.000000002, CRodExLeakage = 0.000000002, CInLeakage = 0.000000005, damping = 0) annotation(
    Placement(transformation(origin = {-44, 22}, extent = {{-10, -10}, {10, 10}})));
  inner OceanEngineeringToolbox.Multibody.Worlds.World world annotation(
    Placement(transformation(origin = {-82, 4}, extent = {{-10, -10}, {10, 10}})));
  inner OceanEngineeringToolbox.DataImport.FileDirectory fileDirectory(file = "C:/Users/thogan1/Documents/GitHub/OceanEngineeringToolbox/applications/Validation/RM3/RM3HydroCoeff.mat") annotation(
    Placement(transformation(origin = {10, -84}, extent = {{-9, -7.25}, {9, 7.25}})));
  inner OceanEngineeringToolbox.Environmental.Environment environment annotation(
    Placement(transformation(origin = {-66, -72}, extent = {{-10, -8}, {10, 8}})));
  inner Developed.Systems.System system annotation(
    Placement(transformation(origin = {-64, 72}, extent = {{-10, -10}, {10, 10}})));
  OceanEngineeringToolbox.Multibody.Joints.Fixed fixed(r = {0, 0, -2.5}) annotation(
    Placement(transformation(origin = {-90, -34}, extent = {{-10, -10}, {10, 10}})));
  Developed.Machines.ConstantDisplacementPump constantDisplacementPump(CMotorLeakage = 0.00025, Dconst = -0.00032, p_init(displayUnit = "bar") = 7e6) annotation(
    Placement(transformation(origin = {58, 14}, extent = {{10, 10}, {-10, -10}})));
  Developed.Volumes.Accumulator hpAccumulator(gasVolume = 1, initType = Developed.Types.AccInit.Volume, liquidVolume = 0.8, p_init(displayUnit = "bar") = 7e6, p_precharge(displayUnit = "MPa") = 3e7, V_precharge = 0.4, V_init = 0.4, p_max = 5e7) annotation(
    Placement(transformation(origin = {38, 38}, extent = {{-10, -10}, {10, 10}})));
  Developed.Volumes.Accumulator lpAccumulator(gasVolume = 5.25e0, initType = Developed.Types.AccInit.Pressure, liquidVolume = 3.75e0, p_init(displayUnit = "bar") = 1e6, p_precharge(displayUnit = "bar") = 5e5, p_max = 5e7) annotation(
    Placement(transformation(origin = {32, -22}, extent = {{-10, 10}, {10, -10}})));
  Developed.Valves.V4_3CC v4_3cc(p_crack(displayUnit = "bar") = 1e5, p_init(displayUnit = "bar") = 7e6, p_open(displayUnit = "bar") = 125000, CvData = Modelica.Fluid.Types.CvTypes.Av, Av = 0.0005) annotation(
    Placement(transformation(origin = {-34, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.Rotational.Components.Damper damper(d = 11.5) annotation(
    Placement(transformation(origin = {98, 14}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed1 annotation(
    Placement(transformation(origin = {126, -12}, extent = {{-10, -10}, {10, 10}})));
  Custom.Basic.LaminarRestriction laminarRestriction(D = 1, L = 0.01, p_init(displayUnit = "bar") = 1e6) annotation(
    Placement(transformation(origin = {56, -24}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(prismatic.frame_b, float.frame_a) annotation(
    Line(points = {{4, -42}, {64, -42}, {64, -79}}, color = {95, 95, 95}));
  connect(doubleActingCylinder.flange_a, prismatic.support) annotation(
    Line(points = {{-54, 22}, {-54, 8}, {-10, 8}, {-10, -36}}, color = {0, 127, 0}));
  connect(doubleActingCylinder.flange_b, prismatic.axis) annotation(
    Line(points = {{-34, 22}, {-34, -11}, {2, -11}, {2, -36}}, color = {0, 127, 0}));
  connect(fixed.frame_b, prismatic.frame_a) annotation(
    Line(points = {{-80, -34}, {-16, -34}, {-16, -42}}, color = {95, 95, 95}));
  connect(v4_3cc.portB, doubleActingCylinder.port_b) annotation(
    Line(points = {{-42, -16}, {-36, -16}, {-36, 14}}, color = {255, 0, 0}));
  connect(v4_3cc.portA, doubleActingCylinder.port_a) annotation(
    Line(points = {{-42, -24}, {-52, -24}, {-52, 14}}, color = {255, 0, 0}));
  connect(constantDisplacementPump.portT, hpAccumulator.port_a) annotation(
    Line(points = {{58, 24}, {38, 24}, {38, 28}}, color = {255, 0, 0}));
  connect(v4_3cc.portP, lpAccumulator.port_a) annotation(
    Line(points = {{-26, -24}, {32, -24}, {32, -12}}, color = {255, 0, 0}));
  connect(v4_3cc.portT, hpAccumulator.port_a) annotation(
    Line(points = {{-26, -16}, {-2, -16}, {-2, 28}, {38, 28}}, color = {255, 0, 0}));
  connect(fixed1.flange, damper.flange_a) annotation(
    Line(points = {{126, -12}, {108, -12}, {108, 14}}));
  connect(damper.flange_b, constantDisplacementPump.flange_a) annotation(
    Line(points = {{88, 14}, {68, 14}}));
  connect(laminarRestriction.port_b, constantDisplacementPump.portP) annotation(
    Line(points = {{66, -24}, {58, -24}, {58, 4}}, color = {255, 0, 0}));
  connect(laminarRestriction.port_a, lpAccumulator.port_a) annotation(
    Line(points = {{46, -24}, {32, -24}, {32, -12}}, color = {255, 0, 0}));
  annotation(
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-06, Interval = 0.002),
    uses(OceanEngineeringToolbox(version = "v0.3"), OpenHydraulics(version = "2.0.0")),
    Diagram);
end dyPTO_fullCircuit;
