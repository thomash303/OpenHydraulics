within OpenHydraulics.Custom.Cylinders;

model DoubleActingCylinder
  import Modelica.Constants.pi;
  // the parameters
  parameter Boolean compressibleEnable = true "Enable fluid compressibility model" annotation(
    Dialog(tab = "Sizing", group = "Non-Ideal Models"), choices(checkBox = true));
  parameter Boolean fluidInertiaEnable = true "Enable fluid inertia model" annotation(
    Dialog(tab = "Sizing", group = "Non-Ideal Models"), choices(checkBox = true));
  parameter Boolean gravityAccelerationEnable = false "Enable acceleration due to gravity model" annotation(
    Dialog(tab = "Sizing", group = "Non-Ideal Models"), choices(checkBox = true));
  parameter Modelica.Units.SI.Length boreDiameter = 0.05 "Bore diameter" annotation(
    Dialog(tab = "Sizing", group = "Dimensions"));
  parameter Modelica.Units.SI.Length rodDiameter = 0.01 "Rod diameter" annotation(
    Dialog(tab = "Sizing", group = "Dimensions"));
  parameter Modelica.Units.SI.Length strokeLength = 0.1 "Stroke length of the cylinder" annotation(
    Dialog(tab = "Sizing", group = "Dimensions"));
  parameter Modelica.Units.SI.Length closedLength = 0.3 "Total length of cylinder fully retracted" annotation(
    Dialog(tab = "Sizing", group = "Dimensions"));
  parameter Modelica.Units.SI.VolumeFlowRate q_nom = 0.01 "Nominal flow rate for in/outlet" annotation(
    Dialog(tab = "Sizing", group = "Hydraulics"));
  parameter Modelica.Units.SI.Pressure dp_nom = 1e4 "Nominal pressure drop for q_nom" annotation(
    Dialog(tab = "Sizing", group = "Hydraulics"));
  parameter Modelica.Units.SI.AbsolutePressure maxPressure = 3e7 "Maximum rated pressure" annotation(
    Dialog(tab = "Sizing", group = "Hydraulics"));
  // dynamics parameters
  parameter Modelica.Units.SI.Mass pistonMass = 0 "Mass of the piston and rod" annotation(
    Dialog(tab = "Dynamics"));
  parameter Modelica.Units.SI.TranslationalDampingConstant damping(final min = 0) = 1e4 "damping between piston and cylinder" annotation(
    Dialog(tab = "Dynamics"));
  parameter Modelica.Units.SI.Distance endOfTravelDistance = 0.01 "Maximum distance beyond the end of travel point" annotation(
    Dialog(tab = "Dynamics", group = "End-of-travel"));
  parameter Real stopStiffness(final unit = "N/m", final min = 0) = 1e9 "stiffness at impact" annotation(
    Dialog(tab = "Dynamics", group = "End-of-travel"));
  parameter Real stopDamping(final unit = "N.s/m", final min = -1000) = 1e12 "damping at impact" annotation(
    Dialog(tab = "Dynamics", group = "End-of-travel"));
  // cushion parameters
  parameter Boolean useCushionHead = true "false = constant restriction with q_nom & dp_nom" annotation(
    Evaluate = true,
    Dialog(tab = "Cushions", group = "Head Cushion"));
  parameter Real cushionTableHead[:, :] = [0, 0.001; 0.001, 0.001; 0.029, 0.01; 0.03, 1] "Cushion flow rate (1st col = s_rel; 2nd col = fraction of q_nom)" annotation(
    Dialog(tab = "Cushions", group = "Head Cushion", enable = useCushionHead));
  parameter Modelica.Blocks.Types.Smoothness smoothnessHead = Modelica.Blocks.Types.Smoothness.LinearSegments "smoothness of table interpolation" annotation(
    Dialog(tab = "Cushions", group = "Head Cushion", enable = useCushionHead));
  parameter Boolean useCushionRod = true "false = constant restriction with q_nom & dp_nom" annotation(
    Evaluate = true,
    Dialog(tab = "Cushions", group = "Rod Cushion"));
  parameter Real cushionTableRod[:, :] = [0, 0.001; 0.001, 0.001; 0.029, 0.01; 0.03, 1] "Cushion flow rate (1st col = s_rel; 2nd col = fraction of q_nom)" annotation(
    Dialog(tab = "Cushions", group = "Rod Cushion", enable = useCushionRod));
  parameter Modelica.Blocks.Types.Smoothness smoothnessRod = Modelica.Blocks.Types.Smoothness.LinearSegments "smoothness of table interpolation" annotation(
    Dialog(tab = "Cushions", group = "Rod Cushion", enable = useCushionRod));
  // sealing parameters
  parameter Modelica.Units.SI.Length L_A2B = 0.01 "Length of seal between chambers A and B" annotation(
    Dialog(tab = "Seals", group = "Piston"));
  parameter Modelica.Units.SI.Diameter D_A2B = 1e-5 "Hydraulic diameter of seal between chambers A and B" annotation(
    Dialog(tab = "Seals", group = "Piston"));
  parameter Modelica.Units.SI.Length L_A2Env = 0.01 "Length of seal between chamber A and Environment" annotation(
    Dialog(tab = "Seals", group = "Piston"));
  parameter Modelica.Units.SI.Diameter D_A2Env = 0 "Hydraulic diameter of seal between chamber A and Environment" annotation(
    Dialog(tab = "Seals", group = "Piston"));
  parameter Modelica.Units.SI.Length L_B2Env = 0.01 "Length of seal between chamber B and Environment" annotation(
    Dialog(tab = "Seals", group = "Piston"));
  parameter Modelica.Units.SI.Diameter D_B2Env = 0 "Hydraulic diameter of seal between chamber B and Environment" annotation(
    Dialog(tab = "Seals", group = "Piston"));
  // initialization parameters
  parameter Types.RevoluteInit initType = Types.RevoluteInit.Free "Type of initialization (defines usage of start values below)" annotation(
    Dialog(tab = "Initialization", group = "Mechanical"));
  parameter Modelica.Units.SI.Distance s_init = 0 "Initial position >0 and <stroke" annotation(
    Dialog(tab = "Initialization", group = "Mechanical"));
  parameter Modelica.Units.SI.Velocity v_init = 0 "Initial velocity" annotation(
    Dialog(tab = "Initialization", group = "Mechanical"));
  parameter Modelica.Units.SI.Acceleration a_init = 0 "Initial acceleration" annotation(
    Dialog(tab = "Initialization", group = "Mechanical"));
  parameter Boolean fixHeadPressure = false "Initialize the pressure at the head side" annotation(
    Dialog(tab = "Initialization", group = "Fluid"));
  parameter Boolean fixRodPressure = false "Initialize the pressure at the rod side" annotation(
    Dialog(tab = "Initialization", group = "Fluid"));
  // the connectors
  Interfaces.FluidPort port_a annotation(
    Placement(transformation(extent = {{-90, -90}, {-70, -70}})));
  Interfaces.FluidPort port_b annotation(
    Placement(transformation(extent = {{90, -90}, {70, -70}})));
  // the components
  Basic.FluidPower2MechTrans cylinderChamberHead(compressibleEnable = compressibleEnable, A = pi/4*boreDiameter^2, stopStiffness = stopStiffness, stopDamping = stopDamping, n_ports = 3, p_init = p_init, maxPressure = maxPressure*10) annotation(
    Placement(transformation(extent = {{-50, -10}, {-30, 10}})));
  Basic.FluidPower2MechTrans cylinderChamberRod(compressibleEnable = compressibleEnable, A = pi/4*(boreDiameter^2 - rodDiameter^2), stopStiffness = stopStiffness, stopDamping = stopDamping, n_ports = 3, p_init = p_init, maxPressure = maxPressure*10) annotation(
    Placement(transformation(extent = {{30, -10}, {50, 10}})));
  
  
  Modelica.Mechanics.Translational.Components.Mass piston(m = pistonMass) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Components.Rod cylinder(L = strokeLength) annotation(
    Placement(transformation(extent = {{-10, 70}, {10, 90}})));
  Modelica.Mechanics.Translational.Components.Rod rod(L = closedLength) annotation(
    Placement(transformation(extent = {{70, -10}, {90, 10}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a "(left) driving flange (flange axis directed INTO cut plane, e. g. from left to right)" annotation(
    Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b "(right) driven flange (flange axis directed OUT OF cut plane, i. e. from right to left)" annotation(
    Placement(transformation(extent = {{90, -10}, {110, 10}})));
  Modelica.Mechanics.Translational.Components.Damper damper(d = damping) annotation(
    Placement(transformation(extent = {{-48, 58}, {-28, 78}})));
  Lines.NJunction jA(n_ports = 2) annotation(
    Placement(transformation(extent = {{-50, -90}, {-30, -70}})));
  Lines.NJunction jB(n_ports = 2) annotation(
    Placement(transformation(extent = {{30, -90}, {50, -70}})));
  extends Interfaces.BaseClasses.PartialFluidComponent;
  Modelica.Mechanics.Translational.Sources.Force gravityForce if gravityAccelerationEnable annotation(
    Placement(transformation(origin = {34, 50}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Blocks.Sources.Constant gravityForceSource(k = -piston.m*system.g) if gravityAccelerationEnable annotation(
    Placement(transformation(origin = {84, 50}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
protected
  outer Circuits.Systems system;
initial equation
  assert(cylinderChamberHead.s_rel >= 0, "Initial position is smaller than zero");
  assert(cylinderChamberRod.s_rel >= 0, "Initial position is larger than strokeLength");
// state initialization
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
// nothing
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
  connect(flange_a, damper.flange_a) annotation(
    Line(points = {{-100, 0}, {-80, 0}, {-80, 68}, {-62, 68}, {-62, 70}, {-58, 70}, {-58, 68}, {-48, 68}}, color = {0, 127, 0}));
  connect(damper.flange_b, cylinderChamberHead.flange_b) annotation(
    Line(points = {{-28, 68}, {-14, 68}, {-14, 0}, {-30, 0}}, color = {0, 127, 0}));
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
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-90, 80}, {90, -90}}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-90, 40}, {90, -40}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{100, 10}, {0, -10}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-18, 39}, {0, -39}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-80, -40}, {-80, -40}, {-80, -40}, {-80, -80}}, color = {255, 0, 0}), Line(points = {{80, -40}, {80, -40}, {80, -40}, {80, -78}}, color = {255, 0, 0}), Polygon(points = {{-88, -40}, {-80, -30}, {-72, -40}, {-88, -40}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{72, -40}, {80, -30}, {88, -40}, {72, -40}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-64, -56}, {-34, -96}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "A"), Text(extent = {{34, -56}, {64, -96}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "B"), Text(extent = {{0, 84}, {0, 60}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "%name"), Rectangle(extent = {{-34, 18}, {16, -18}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-22, -26}, {8, 34}}, color = {0, 0, 0}), Polygon(points = {{8, 34}, {-8, 18}, {4, 12}, {8, 34}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid)}));
end DoubleActingCylinder;
