within OpenHydraulics.Developed.Circuits;

model org_pto
  OceanEngineeringToolbox.Hydro.HydrodynamicBody float(I_11 = 20907301, I_22 = 21306091, I_33 = 37085481, animationEnable = true, bodyColour = {255, 255, 0}, bodyIndex = 1, enableDampingDragForce = true, enableExcitationForce = true, enableHydrostaticForce = true, enableRadiationForce = false, geometryFile = "file://C:/Users/thogan1/Documents/GitHub/OceanEngineeringToolbox/applications/Validation/RM3/geometry/float.stl", ra_CM = {0, 0, 0.5}, Ad = {0, 0, 5, 0, 0, 0}, Cv = {0, 0, 1e5, 0, 0, 0}) annotation(
    Placement(transformation(origin = {-53, 29}, extent = {{-15, -15}, {15, 15}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic(n = {0, 0, 1}, useAxisFlange = true) annotation(
    Placement(transformation(origin = {-68, -24}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  Developed.Cylinders.DoubleActingCylinder doubleActingCylinder(boreDiameter = 0.15, compressibleEnable = true, strokeLength = 2, pistonRodMass = 5, maxPressure = 2e8, initType = Developed.Types.RevoluteInit.Position, s_init = 1, leakageEnable = true, Cv = 1000, f_c = 200, Cst = 5, f_st = 2000, CHeadExLeakage = 0.000000002, CRodExLeakage = 0.000000002, CInLeakage = 0.0000000005, damping = 0, stribeckFrictionEnable = true, p_init = 1e7) annotation(
    Placement(transformation(origin = {-32, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  inner OceanEngineeringToolbox.Multibody.Worlds.World world annotation(
    Placement(transformation(origin = {-88, 86}, extent = {{-10, -10}, {10, 10}})));
  inner OceanEngineeringToolbox.DataImport.FileDirectory fileDirectory(file = "C:/Users/thogan1/Documents/GitHub/OceanEngineeringToolbox/applications/Validation/RM3/RM3HydroCoeff.mat") annotation(
    Placement(transformation(origin = {10, 86}, extent = {{-9, -7.25}, {9, 7.25}})));
  inner OceanEngineeringToolbox.Environmental.Environment environment annotation(
    Placement(transformation(origin = {-24, 86}, extent = {{-10, -8}, {10, 8}})));
  inner Developed.Systems.System system annotation(
    Placement(transformation(origin = {-56, 86}, extent = {{-10, -10}, {10, 10}})));
  OceanEngineeringToolbox.Multibody.Joints.Fixed fixed(r = {0, 0, -2.5}) annotation(
    Placement(transformation(origin = {-68, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Developed.Machines.ConstantDisplacementPump constantDisplacementPump(CMotorLeakage = 0.00025, Dconst = 0.0002, p_init(displayUnit = "bar") = 3e7) annotation(
    Placement(transformation(origin = {62, -22}, extent = {{10, 10}, {-10, -10}})));
  Developed.Volumes.Accumulator hpAccumulator(gasVolume = 10, initType = Developed.Types.AccInit.Volume, liquidVolume = 9, p_init(displayUnit = "bar") = 3e7, p_precharge(displayUnit = "bar") = 2.2e7, p_max = 2e8, V_init = 0.5) annotation(
    Placement(transformation(origin = {28, -2}, extent = {{-10, -10}, {10, 10}})));
  Developed.Volumes.Accumulator lpAccumulator(gasVolume = 10, initType = Developed.Types.AccInit.Volume, liquidVolume = 9, p_init(displayUnit = "bar"), p_precharge(displayUnit = "bar") = 1e6, p_max = 5e7, V_init = 1) annotation(
    Placement(transformation(origin = {26, -54}, extent = {{-10, 10}, {10, -10}})));
  Developed.Valves.V4_3CC v4_3cc(p_crack(displayUnit = "bar") = 1e5, p_init(displayUnit = "bar") = 1e6, p_open(displayUnit = "bar") = 2.5e5, CvData = Modelica.Fluid.Types.CvTypes.Av, Av = 0.001, Cd = 1) annotation(
    Placement(transformation(origin = {0, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Custom.Basic.LaminarRestriction laminarRestriction(D = 1, L = 0.01, p_init(displayUnit = "bar") = 1e6) annotation(
    Placement(transformation(origin = {52, -44}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Units.SI.Force Fpto = doubleActingCylinder.boreDiameter^2/4*3.14*(hpAccumulator.port_a.p - lpAccumulator.port_a.p)*sign(float.body.absoluteSensor.v[3]);
  Modelica.Mechanics.Rotational.Sources.Speed speed annotation(
    Placement(transformation(origin = {102, -22}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp(height = 104.7198, duration = 5) annotation(
    Placement(transformation(origin = {164, -22}, extent = {{10, -10}, {-10, 10}})));
equation
  connect(prismatic.frame_b, float.frame_a) annotation(
    Line(points = {{-68, -14}, {-68, 29}}, color = {95, 95, 95}));
  connect(doubleActingCylinder.flange_b, prismatic.axis) annotation(
    Line(points = {{-32, -16}, {-62, -16}}, color = {0, 127, 0}));
  connect(fixed.frame_b, prismatic.frame_a) annotation(
    Line(points = {{-68, -78}, {-68, -34}}, color = {95, 95, 95}));
  connect(constantDisplacementPump.portT, hpAccumulator.port_a) annotation(
    Line(points = {{62, -12}, {28, -12}}, color = {255, 0, 0}));
  connect(v4_3cc.portT, hpAccumulator.port_a) annotation(
    Line(points = {{8, -22}, {8, -12}, {28, -12}}, color = {255, 0, 0}));
  connect(laminarRestriction.port_b, constantDisplacementPump.portP) annotation(
    Line(points = {{62, -44}, {62, -32}}, color = {255, 0, 0}));
  connect(laminarRestriction.port_a, lpAccumulator.port_a) annotation(
    Line(points = {{42, -44}, {26, -44}}, color = {255, 0, 0}));
  connect(speed.flange, constantDisplacementPump.flange_a) annotation(
    Line(points = {{92, -22}, {72, -22}}));
  connect(ramp.y, speed.w_ref) annotation(
    Line(points = {{153, -22}, {114, -22}}, color = {0, 0, 127}));
  connect(prismatic.support, doubleActingCylinder.flange_a) annotation(
    Line(points = {{-62, -28}, {-50, -28}, {-50, -36}, {-32, -36}}, color = {0, 127, 0}));
  connect(doubleActingCylinder.port_b, v4_3cc.portB) annotation(
    Line(points = {{-24, -18}, {-8, -18}, {-8, -22}}, color = {255, 0, 0}));
  connect(doubleActingCylinder.port_a, v4_3cc.portA) annotation(
    Line(points = {{-24, -34}, {-8, -34}, {-8, -30}}, color = {255, 0, 0}));
  connect(v4_3cc.portP, lpAccumulator.port_a) annotation(
    Line(points = {{8, -30}, {8, -44}, {26, -44}}, color = {255, 0, 0}));
  annotation(
    experiment(StartTime = 0, StopTime = 400, Tolerance = 1e-06, Interval = 0.002),
    uses(OceanEngineeringToolbox(version = "v0.3"), OpenHydraulics(version = "2.0.0")),
    Diagram(coordinateSystem(extent = {{-100, 100}, {180, -100}})));
end org_pto;
