within OpenHydraulics.Developed.Volumes;

model Accumulator
  "Model representing an accumulator"
  // Inheriting from the OET
  //extends Interfaces.BaseClasses.PartialFluidComponent(p_init = max(system.p_ambient, p_precharge));
  extends Interfaces.BaseClasses.PartialFluidComponent;
  // Importing from the MSL
  import Modelica.Units.SI;
  import Modelica.Mechanics.Translational.Components;
  // Parameters
  parameter Real gamma = 1.4 "Adiabatic index for an ideal gas(default set assuming dry air)" annotation(
    Dialog(tab = "Sizing"));
  parameter SI.Volume liquidVolume = 0.001 "Maximum Liquid Volume (for liquid volume residual. Should be just lower than gasVolume)" annotation(
    Dialog(tab = "Sizing"));
  parameter SI.Volume gasVolume = 0.0011 "Gas Volume (must be larger than liquid volume)" annotation(
    Dialog(tab = "Sizing"));
  parameter SI.Volume V_precharge = gasVolume "initial precharge volume" annotation(
    Dialog(tab = "Sizing"));
  parameter SI.AbsolutePressure p_precharge = 101325 "Gas precharge pressure" annotation(
    Dialog(tab = "Sizing"));
  parameter SI.AbsolutePressure p_max = 3e7 "Maximum rated pressure" annotation(
    Dialog(tab = "Sizing"));
  // Advanced parameters
  // default residual is 2% of the total volume
  parameter SI.Volume residualVolLiquid = liquidVolume*0.02 "Residual volume of liquid when accumulator is empty" annotation(
    Dialog(tab = "Advanced"));
  parameter SI.Volume residualVolGas = gasVolume - liquidVolume "Residual volume of gas when accumulator is full" annotation(
    Dialog(tab = "Advanced"));
  parameter SI.Mass pistonMass = 0.01 "Mass of bladder or piston" annotation(
    Dialog(tab = "Advanced"));
  parameter SI.TranslationalDampingConstant pistonDamping(final min = 0) = 1 "Damping constant for bladder or piston" annotation(
    Dialog(tab = "Advanced"));
  // Initialization parameters
  parameter Types.AccInit initType = Types.AccInit.Pressure "Type of initialization (defines usage of start values below)" annotation(
    Dialog(tab = "Initialization", group = "Fluid"));
  parameter SI.Volume V_init = residualVolLiquid "Initial liquid volume (for gas volume residual. Should be very small)" annotation(
    Dialog(tab = "Initialization", group = "Fluid"));
  // Fluid components
  BaseClasses.FluidPower2MechTrans liquidChamber(A = A, residualVolume = residualVolLiquid, maxPressure = p_max, n_ports = 1, V_init = V_init) annotation(
    Placement(transformation(extent = {{20, -10}, {40, 10}})));
  //  OpenHydraulics.Custom.Basic.FluidPower2MechTrans old directory
  
  BaseClasses.AirChamber gasChamber(gamma = gamma, V_precharge = V_precharge, p_precharge = p_precharge, A = A, residualVolume = residualVolGas, initializePressure = initType == Types.AccInit.Pressure, p_init = p_init, V_init = gasVolume - V_init) annotation(
    Placement(transformation(extent = {{-40, -10}, {-20, 10}})));
  // OpenHydraulics.Custom.Volumes.BaseClasses.AirChamber old directory
  
  // Translational components
  Components.Fixed fixedLeft(s0 = 0.0) annotation(
    Placement(transformation(extent = {{-70, -10}, {-50, 10}})));
  Components.Fixed fixedRight(final s0 = liquidVolume/A) annotation(
    Placement(transformation(extent = {{50, -10}, {70, 10}})));
  Components.Mass slidingMass(m = pistonMass, final L = 0, stateSelect = StateSelect.prefer) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Components.Damper damper(d = pistonDamping, stateSelect = StateSelect.default) annotation(
    Placement(transformation(extent = {{-40, 30}, {-20, 50}})));
  // Fluid ports
  Interfaces.FluidPort port_a(p(start = p_init)) annotation(
    Placement(transformation(extent = {{-10, -110}, {10, -90}})));

  // NOTE: from a behavioral perspective the surface area of the piston
// is not really relevant.  We will therefore assume that it is
  // equal to the liquidVolume resulting in a total travel of the piston of 1m.

  parameter Modelica.Units.SI.Length Lnom = 1 "Dummy nominal length" annotation(
    Placement(visible = false, transformation(extent = {{0, 0}, {0, 0}})));
  parameter Modelica.Units.SI.Area A = liquidVolume/Lnom;
  
initial equation
  assert(gasVolume > liquidVolume, "gasVolume must be larger than liquidVolume");

equation
  assert(gasChamber.p < p_max, "Pressure in accumulator exceeded p_max");
  connect(liquidChamber.flange_b, fixedRight.flange) annotation(
    Line(points = {{40, 0}, {60, 0}}, color = {0, 127, 0}));
  connect(fixedLeft.flange, gasChamber.flange_a) annotation(
    Line(points = {{-60, 0}, {-40, 0}}, color = {0, 127, 0}));
  connect(port_a, liquidChamber.port[1]) annotation(
    Line(points = {{0, -100}, {0, -40}, {30, -40}, {30, -0.05}}, color = {255, 0, 0}));
  connect(gasChamber.flange_b, slidingMass.flange_a) annotation(
    Line(points = {{-20, 0}, {-10, 0}}, color = {0, 127, 0}));
  connect(slidingMass.flange_b, liquidChamber.flange_a) annotation(
    Line(points = {{10, 0}, {20, 0}}, color = {0, 127, 0}));
  connect(damper.flange_b, slidingMass.flange_a) annotation(
    Line(points = {{-20, 40}, {-16, 40}, {-16, 0}, {-10, 0}}, color = {0, 127, 0}));
  connect(damper.flange_a, fixedLeft.flange) annotation(
    Line(points = {{-40, 40}, {-50, 40}, {-50, 0}, {-60, 0}}, color = {0, 127, 0}));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-40, 100}, {40, -80}}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{0, -78}, {0, -98}}, color = {255, 0, 0}), Text(extent = {{0, 100}, {0, 66}}, lineColor = {0, 0, 255}, textString = "%name"), Ellipse(extent = {{-28, -22}, {28, -78}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-28, 60}, {28, 4}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-30, 32}, {30, -48}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-28, 32}, {-28, -52}}, color = {0, 0, 0}), Line(points = {{28, 32}, {28, -52}}, color = {0, 0, 0}), Line(points = {{-28, -14}, {28, -14}}, color = {0, 0, 0}), Polygon(points = {{-6, 0}, {6, 0}, {0, -14}, {-6, 0}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid)}));
end Accumulator;
