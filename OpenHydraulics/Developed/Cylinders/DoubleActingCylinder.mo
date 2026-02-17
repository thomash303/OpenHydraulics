within OpenHydraulics.Developed.Cylinders;

model DoubleActingCylinder
  "Double acting hydraulic cylinder model"
  
  // Inheriting from the OET
  extends Interfaces.BaseClasses.PartialFluidComponent;
  extends Modelica.Mechanics.Translational.Interfaces.PartialTwoFlanges;
  
  // Importing and inheriting from the MSL
  import Modelica.Units.SI;
  import Modelica.Constants.pi;
  import Modelica.Mechanics.Translational;
  import Modelica.Mechanics.Translational.{Components, Sources};
  import Modelica.Blocks;
  
  // Additional model improvement flags
  parameter Boolean compressibleEnable = false "Enable fluid compressibility model" annotation(
    Dialog(group = "Non-Ideal Models"),
    choices(checkBox = true));
  parameter Boolean fluidInertiaEnable = false "Enable fluid inertia model" annotation(
    Dialog(group = "Non-Ideal Models"),
    choices(checkBox = true));
  parameter Boolean gravityAccelerationEnable = false "Enable acceleration due to gravity model" annotation(
    Dialog(group = "Non-Ideal Models"),
    choices(checkBox = true));
  parameter Boolean stribeckFrictionEnable = false "Enable Stribeck friction model" annotation(
    Dialog(group = "Non-Ideal Models"),
    choices(checkBox = true));
  parameter Boolean leakageEnable = false "Enable fluid leakage model" annotation(
    Dialog(group = "Non-Ideal Models"),
    choices(checkBox = true));
    
  // Stribeck friction parameters
  parameter SI.TranslationalDampingConstant Cv = 1 "Viscous damping coefficient" annotation(
    Dialog(group = "Stribeck Friction"));
  parameter SI.Force f_c = 5 "Coulomb friction force" annotation(
    Dialog(group = "Stribeck Friction"));
  parameter SI.Velocity Cst = 0.5 "Stribeck characteristic velocity" annotation(
    Dialog(group = "Stribeck Friction"));
  parameter SI.Force f_st = 10 "Stribeck friction force" annotation(
    Dialog(group = "Stribeck Friction"));
  //SI.Force f_fric "Total friction force";
  // Leakage parameters
  parameter Types.HydraulicLeakage CHeadExLeakage = 0 "Cylinder head external leakage coefficient" annotation(
    Dialog(group = "Leakage"));
   parameter Types.HydraulicLeakage CRodExLeakage = 0 "Cylinder rod external leakage coefficient" annotation(
    Dialog(group = "Leakage"));
   parameter Types.HydraulicLeakage CInLeakage = 0 "Cylinder internal leakage coefficient" annotation(
    Dialog(group = "Leakage"));
  
  // Sizing parameters
  parameter SI.Length boreDiameter = 0.05 "Bore diameter" annotation(
    Dialog(tab = "Sizing", group = "Dimensions"));
  parameter SI.Length rodDiameter = 0.01 "Rod diameter" annotation(
    Dialog(tab = "Sizing", group = "Dimensions"));
  parameter SI.Length strokeLength = 0.1 "Stroke length of the cylinder" annotation(
    Dialog(tab = "Sizing", group = "Dimensions"));
  parameter SI.Length closedLength = 0.3 "Total length of cylinder fully retracted" annotation(
    Dialog(tab = "Sizing", group = "Dimensions"));
  
  // Fluid parameters
  parameter SI.VolumeFlowRate q_nom = 0.01 "Nominal flow rate for in/outlet" annotation(
    Dialog(tab = "Sizing", group = "Hydraulics"));
  parameter SI.Pressure dp_nom = 1e4 "Nominal pressure drop for q_nom" annotation(
    Dialog(tab = "Sizing", group = "Hydraulics"));
  parameter SI.AbsolutePressure maxPressure = 3e7 "Maximum rated pressure" annotation(
    Dialog(tab = "Sizing", group = "Hydraulics"));
  
  // Dynamics parameters
  parameter SI.Mass pistonRodMass = 0 "Mass of the piston and rod" annotation(
    Dialog(tab = "Dynamics"));
  parameter SI.TranslationalDampingConstant damping = 1e4 "damping between piston and cylinder" annotation(
    Dialog(tab = "Dynamics"));
  parameter SI.Distance endOfTravelDistance = 0.01 "Maximum distance beyond the end of travel point" annotation(
    Dialog(tab = "Dynamics", group = "End-of-travel"));
  parameter SI.TranslationalSpringConstant stopStiffness = 1e9 "stiffness at impact" annotation(
    Dialog(tab = "Dynamics", group = "End-of-travel"));
  parameter SI.TranslationalDampingConstant stopDamping = 1e12 "damping at impact" annotation(
    Dialog(tab = "Dynamics", group = "End-of-travel"));

  // Initialization parameters
  parameter Types.RevoluteInit initType = Types.RevoluteInit.Free "Type of initialization (defines usage of start values below)" annotation(
    Dialog(tab = "Initialization", group = "Mechanical"));
  parameter SI.Distance s_init = 0 "Initial position >0 and <stroke" annotation(
    Dialog(tab = "Initialization", group = "Mechanical"));
  parameter SI.Velocity v_init = 0 "Initial velocity" annotation(
    Dialog(tab = "Initialization", group = "Mechanical"));
  parameter SI.Acceleration a_init = 0 "Initial acceleration" annotation(
    Dialog(tab = "Initialization", group = "Mechanical"));
  parameter Boolean fixHeadPressure = false "Initialize the pressure at the head side" annotation(
    Dialog(tab = "Initialization", group = "Fluid"));
  parameter Boolean fixRodPressure = false "Initialize the pressure at the rod side" annotation(
    Dialog(tab = "Initialization", group = "Fluid"));
  
  // Fluid ports
  Interfaces.FluidPort port_a annotation(
    Placement(transformation(extent = {{-90, -90}, {-70, -70}})));
  Interfaces.FluidPort port_b annotation(
    Placement(transformation(extent = {{90, -90}, {70, -70}})));
  
  // Fluid components
  Custom.Basic.FluidPower2MechTrans cylinderChamberHead(compressibleEnable = compressibleEnable, A = pi/4*boreDiameter^2, stopStiffness = stopStiffness, stopDamping = stopDamping, n_ports = 3, p_init = p_init, maxPressure = maxPressure*10) annotation(
    Placement(transformation(extent = {{-50, -10}, {-30, 10}})));
  Custom.Basic.FluidPower2MechTrans cylinderChamberRod(compressibleEnable = compressibleEnable, A = pi/4*(boreDiameter^2 - rodDiameter^2), stopStiffness = stopStiffness, stopDamping = stopDamping, n_ports = 3, p_init = p_init, maxPressure = maxPressure*10) annotation(
    Placement(transformation(extent = {{30, -10}, {50, 10}})));
  //Volumes.BaseClasses.FluidPower2MechTrans or Custom.Basic.FluidPower2MechTrans
  
  
  // Translational components
  Components.Mass piston(m = pistonRodMass) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Components.Rod cylinder(L = strokeLength) annotation(
    Placement(transformation(extent = {{-10, 70}, {10, 90}})));
  Components.Rod rod(L = closedLength) annotation(
    Placement(transformation(extent = {{70, -10}, {90, 10}})));
  
  /*
  Translational.Interfaces.Flange_a flange_a "(left) driving flange (flange axis directed INTO cut plane, e. g. from left to right)" annotation(
    Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
  Translational.Interfaces.Flange_b flange_b "(right) driven flange (flange axis directed OUT OF cut plane, i. e. from right to left)" annotation(
    Placement(transformation(extent = {{90, -10}, {110, 10}})));
  */

  // Fluid junctions
  Interfaces.NJunction jA(n_ports = 2) annotation(
    Placement(transformation(extent = {{-50, -90}, {-30, -70}})));
  Interfaces.NJunction jB(n_ports = 2) annotation(
    Placement(transformation(extent = {{30, -90}, {50, -70}})));
  
  // Inertial force
  Sources.Force gravityForce if gravityAccelerationEnable annotation(
    Placement(transformation(origin = {34, 50}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Blocks.Sources.Constant gravityForceSource(k = -piston.m*system.g) if gravityAccelerationEnable annotation(
    Placement(transformation(origin = {84, 50}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  BaseClasses.StribeckFriction stribeckFriction(Cv = Cv, f_c = f_c, Cst = Cst, f_st = f_st)  if stribeckFrictionEnable annotation(
    Placement(transformation(origin = {-44, 58}, extent = {{-10, -10}, {10, 10}})));
  
  // Leakage models
  Volumes.BaseClasses.ConstantPressureSource headEnvSink if leakageEnable annotation(
    Placement(transformation(origin = {-88, -30}, extent = {{-10, -10}, {10, 10}})));
  Volumes.BaseClasses.ConstantPressureSource rodEnvSink if leakageEnable annotation(
    Placement(transformation(origin = {94, -30}, extent = {{-10, -10}, {10, 10}})));
  BaseClasses.Leakage internalLeakage(CLeakage = CInLeakage) if leakageEnable annotation(
    Placement(transformation(origin = {0, -26}, extent = {{-10, -10}, {10, 10}})));
  BaseClasses.Leakage headExternalLeakage(CLeakage = CHeadExLeakage) if leakageEnable annotation(
    Placement(transformation(origin = {-62, -16}, extent = {{-10, -10}, {10, 10}})));
  BaseClasses.Leakage rodExternalLeakage(CLeakage = CRodExLeakage) if leakageEnable annotation(
    Placement(transformation(origin = {66, -18}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Components.Damper damper(d = damping) annotation(
    Placement(transformation(origin = {-22, -44}, extent = {{-48, 58}, {-28, 78}})));
initial equation
  assert(cylinderChamberHead.s_rel >= 0, "Initial position is smaller than zero");
  assert(cylinderChamberRod.s_rel >= 0, "Initial position is larger than strokeLength");

  // State initialization
  if initType == Types.RevoluteInit.Position then
    cylinderChamberHead.s_rel = s_init;
  elseif initType == Types.RevoluteInit.Velocity then
    cylinderChamberHead.v_rel = v_init;
  elseif initType == Types.RevoluteInit.PositionVelocity then
    cylinderChamberHead.s_rel = s_init;
    cylinderChamberHead.v_rel = v_init;
  elseif initType == Types.RevoluteInit.VelocityAcceleration then
    cylinderChamberHead.v_rel = v_init;
    piston.a = a_init;
  elseif initType == Types.RevoluteInit.SteadyState then
    cylinderChamberHead.v_rel = 0;
    piston.a = a_init;
  elseif initType == Types.RevoluteInit.PositionVelocityAcceleration then
    cylinderChamberHead.s_rel = s_init;
    cylinderChamberHead.v_rel = v_init;
    piston.a = a_init;
  elseif initType == Types.RevoluteInit.Free then
  // Nothing
  else
    assert(true, "Invalid initialization type in FluidPower2MechTrans");
  end if;
  if fixHeadPressure then
    cylinderChamberHead.p_vol = p_init;
  end if;
  if fixRodPressure then
    cylinderChamberRod.p_vol = p_init;
  end if;
equation
  connect(cylinderChamberHead.flange_b, piston.flange_a) annotation(
    Line(points = {{-30, 0}, {-10, 0}}, color = {0, 127, 0}));
  connect(rod.flange_a, piston.flange_b) annotation(
    Line(points = {{70, 0}, {70, 20}, {62, 20}, {62, 22}, {58, 22}, {58, 20}, {14, 20}, {14, 0}, {10, 0}}, color = {0, 127, 0}));
  connect(piston.flange_b, cylinderChamberRod.flange_a) annotation(
    Line(points = {{10, 0}, {30, 0}}, color = {0, 127, 0}));
  connect(cylinder.flange_b, cylinderChamberRod.flange_b) annotation(
    Line(points = {{10, 80}, {60, 80}, {60, 0}, {50, 0}}, color = {0, 127, 0}));
  connect(cylinderChamberHead.flange_a, cylinder.flange_a) annotation(
    Line(points = {{-50, 0}, {-60, 0}, {-60, 80}, {-10, 80}}, color = {0, 127, 0}));
  connect(cylinderChamberHead.flange_a, flange_a) annotation(
    Line(points = {{-50, 0}, {-100, 0}}, color = {0, 127, 0}));
  connect(rod.flange_b, flange_b) annotation(
    Line(points = {{90, 0}, {100, 0}}, color = {0, 127, 0}));
  connect(port_a, jA.port[1]) annotation(
    Line(points = {{-80, -80}, {-40, -80}, {-40, -80.5}}, color = {255, 0, 0}));
  connect(port_b, jB.port[1]) annotation(
    Line(points = {{80, -80}, {40, -80}, {40, -80.5}}, color = {255, 0, 0}));
  connect(jA.port[2], cylinderChamberHead.port[1]) annotation(
    Line(points = {{-40, -80}, {-40, 0}}, color = {255, 0, 0}, thickness = 0.5));
  connect(jB.port[2], cylinderChamberRod.port[1]) annotation(
    Line(points = {{40, -80}, {40, 0}}, color = {255, 0, 0}, thickness = 0.5));
  connect(gravityForce.flange, piston.flange_b) annotation(
    Line(points = {{24, 50}, {10, 50}, {10, 0}}, color = {0, 127, 0}));
  connect(gravityForceSource.y, gravityForce.f) annotation(
    Line(points = {{74, 50}, {46, 50}}, color = {0, 0, 127}));
  connect(stribeckFriction.flange_a, flange_a) annotation(
    Line(points = {{-54, 58}, {-76, 58}, {-76, 0}, {-100, 0}}, color = {0, 127, 0}));
  connect(internalLeakage.port_a, cylinderChamberHead.port[2]) annotation(
    Line(points = {{-10, -26}, {-40, -26}, {-40, 0}}, color = {255, 0, 0}));
  connect(internalLeakage.port_b, cylinderChamberRod.port[2]) annotation(
    Line(points = {{10, -26}, {40, -26}, {40, 0}}, color = {255, 0, 0}));
  connect(headEnvSink.port, headExternalLeakage.port_a) annotation(
    Line(points = {{-88, -20}, {-88, -16}, {-72, -16}}, color = {255, 0, 0}));
  connect(headExternalLeakage.port_b, cylinderChamberHead.port[3]) annotation(
    Line(points = {{-52, -16}, {-40, -16}, {-40, 0}}, color = {255, 0, 0}));
  connect(rodExternalLeakage.port_b, rodEnvSink.port) annotation(
    Line(points = {{76, -18}, {94, -18}, {94, -20}}, color = {255, 0, 0}));
  connect(rodExternalLeakage.port_a, cylinderChamberRod.port[3]) annotation(
    Line(points = {{56, -18}, {40, -18}, {40, 0}}, color = {255, 0, 0}));
  connect(damper.flange_a, flange_a) annotation(
    Line(points = {{-70, 24}, {-100, 24}, {-100, 0}}, color = {0, 127, 0}));
  connect(damper.flange_b, cylinderChamberHead.flange_b) annotation(
    Line(points = {{-50, 24}, {-30, 24}, {-30, 0}}, color = {0, 127, 0}));
  connect(stribeckFriction.flange_b, cylinderChamberHead.flange_b) annotation(
    Line(points = {{-34, 58}, {-20, 58}, {-20, 0}, {-30, 0}}, color = {0, 127, 0}));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-90, 80}, {90, -90}}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-90, 40}, {90, -40}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{100, 10}, {0, -10}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-18, 39}, {0, -39}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-80, -40}, {-80, -40}, {-80, -40}, {-80, -80}}, color = {255, 0, 0}), Line(points = {{80, -40}, {80, -40}, {80, -40}, {80, -78}}, color = {255, 0, 0}), Polygon(points = {{-88, -40}, {-80, -30}, {-72, -40}, {-88, -40}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{72, -40}, {80, -30}, {88, -40}, {72, -40}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-64, -56}, {-34, -96}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "A"), Text(extent = {{34, -56}, {64, -96}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "B"), Text(extent = {{0, 84}, {0, 60}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "%name"), Rectangle(extent = {{-34, 18}, {16, -18}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-22, -26}, {8, 34}}, color = {0, 0, 0}), Polygon(points = {{8, 34}, {-8, 18}, {4, 12}, {8, 34}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid)}));
end DoubleActingCylinder;
