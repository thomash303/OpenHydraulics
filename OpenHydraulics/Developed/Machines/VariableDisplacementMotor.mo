within OpenHydraulics.Developed.Machines;

model VariableDisplacementMotor "Variable Displacement Pump/motor with losses"
  // Inheriting from the OET
  extends Interfaces.BaseClasses.PartialFluidComponent;
  // Importing from the MSL
  import Modelica.Units.SI;
  import Modelica.Mechanics.Rotational.Interfaces.Flange_a;
  import Modelica.Blocks.Interfaces.RealInput;
  // Additional model improvement flags
  parameter Boolean frictionEnable = true "Enable friction model" annotation(
    Dialog(group = "Non-Ideal Models"),
    choices(checkBox = true));
  parameter Boolean leakageEnable = true "Enable fluid leakage model" annotation(
    Dialog(group = "Non-Ideal Models"),
    choices(checkBox = true));
  // Sizing parameters
  parameter SI.Volume Dmax = 0.001 "Maximum pump displacement" annotation(
    Dialog(tab = "Sizing"));
  parameter SI.Volume Dmin = -0.001 "Minimum pump displacement (<0 for over-center)" annotation(
    Dialog(tab = "Sizing"));
  parameter SI.Volume Dlimit = max(abs(Dmax), abs(Dmin)) "Displacement of pump" annotation(
    Dialog(tab = "Sizing"));
  // McCandlish and Dory motor loss parameters
  parameter Real Cs[:] = {0, 0} "Slips coefficient (hydraulic loss)" annotation(
    Dialog(group = "Losses"));
  parameter Real CsD[:] = {0, 1} "Angular velocity of slip coefficients" annotation(
    Dialog(group = "Losses"));
  parameter Real Cv[:] = {0, 0} "Coefficients of viscous drag (mechanical loss)" annotation(
    Dialog(group = "Losses"));
  parameter Real CvD[:] = {0, 1} "Displacement fraction of slip coefficients" annotation(
    Dialog(group = "Losses"));
  parameter Real Cf[:] = {0, 0} "Coefficients of Coulomb friction (mechanical loss)" annotation(
    Dialog(group = "Losses"));
  parameter Real CfD[:] = {0, 1} "Displacement fraction of slip coefficients" annotation(
    Dialog(group = "Losses"));
  // Friction
  BaseClasses.MechanicalPumpLosses mechanicalPumpLosses(Cv = Modelica.Units.Cv, CvD = CvD, Cf = Cf, CfD = CfD, dpMot = dp, Dmax = Dlimit, D = fluidPower2MechRot.D, mu = system.mu) if frictionEnable annotation(
    Placement(transformation(extent = {{-80, -10}, {-60, 10}})));
  // Fluid components
  Machines.FluidPower2MechRotVar fluidPower2MechRot(final Dmax = Dmax, final Dmin = Dmin, final Dlimit = Dlimit, p_init_a = p_init_T, p_init_b = p_init_P) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Interfaces.NJunction j1(p_init = p_init_T) annotation(
    Placement(transformation(extent = {{-10, -50}, {10, -30}})));
  Interfaces.NJunction j2(p_init = p_init_P) annotation(
    Placement(transformation(extent = {{-10, 30}, {10, 50}})));
  // Fluid ports
  parameter SI.Pressure p_init_P = p_init "Initial fluid pressure at port P" annotation(
    Dialog(tab = "Initialization", group = "Fluid"));
  parameter SI.Pressure p_init_T = p_init "Initial fluid pressure at port T" annotation(
    Dialog(tab = "Initialization", group = "Fluid"));
  Interfaces.FluidPort portP(p(start = p_init_P)) annotation(
    Placement(transformation(extent = {{-10, 90}, {10, 110}})));
  Interfaces.FluidPort portT(p(start = p_init_T)) annotation(
    Placement(transformation(extent = {{-10, -110}, {10, -90}})));
  // Rotational flange
  Flange_a flange_a "(left) driving flange (flange axis directed INTO cut plane)" annotation(
    Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
  RealInput dispFraction annotation(
    Placement(transformation(extent = {{-100, -96}, {-68, -64}})));
  // Motor leakage
  BaseClasses.FluidLeakage motorLeakage(p_init_a = p_init_P, p_init_b = p_init_T, Cs = Cs, CsD = CsD, dpMot = dp, Dmax = Dlimit, D = fluidPower2MechRot.D, mu = system.mu, portSelect = Developed.Types.HydraulicPort.port_P) if leakageEnable annotation(
    Placement(transformation(origin = {36, 10}, extent = {{-10, -10}, {10, 10}})));
  Volumes.OpenTank tank if leakageEnable annotation(
    Placement(transformation(origin = {68, 20}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
  Developed.Machines.BaseClasses.FluidLeakage motorLeakage1(Cs = Cs, CsD = CsD, Dmax = Dlimit, D = fluidPower2MechRot.D, dpMot = dp, mu = system.mu, p_init_a = p_init_P, p_init_b = p_init_T, portSelect = Developed.Types.HydraulicPort.port_T) if leakageEnable annotation(
    Placement(transformation(origin = {36, -10}, extent = {{-10, -10}, {10, 10}})));
  Developed.Volumes.OpenTank tank1 if leakageEnable annotation(
    Placement(transformation(origin = {68, -20}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  // Power, energy, and efficiency
  SI.Power Pmot_hyd "Hydraulic pump/motor power";
  SI.Power Pmot_mech = flange_a.tau*der(flange_a.phi) "Mechanical pump/motor power";
  //SI.Energy Emot_hyd "Hydraulic pump/motor energy";
  SI.Energy Emot_mech "Mechanical pump/motor energy";
  Real motEff = min(abs(Pmot_hyd), abs(Pmot_mech))/(max(abs(Pmot_hyd), abs(Pmot_mech))) "Pump/motor efficiency";
  SI.Pressure dp = portP.p - portT.p;
equation
// Power
  Pmot_hyd = smooth(1, noEvent(dp*(if portP.m_flow >= 0 then -portT.m_flow else -portP.m_flow)/system.rho_ambient));
// Energy
//der(Emot_hyd) = Pmot_hyd;
  der(Emot_mech) = Pmot_mech;
  connect(fluidPower2MechRot.dispFraction, dispFraction) annotation(
    Line(points = {{-8.5, -8}, {-42, -8}, {-42, -80}, {-84, -80}}, color = {0, 0, 127}));
  connect(portT, j1.port[1]) annotation(
    Line(points = {{0, -100}, {0, -40.6667}}, color = {255, 0, 0}));
  connect(portP, j2.port[1]) annotation(
    Line(points = {{0, 100}, {0, 39.3333}}, color = {255, 0, 0}));
  connect(fluidPower2MechRot.port_b, j2.port[2]) annotation(
    Line(points = {{0, 10}, {0, 40}}, color = {255, 0, 0}));
  connect(fluidPower2MechRot.port_a, j1.port[2]) annotation(
    Line(points = {{0, -10}, {0, -40}}, color = {255, 0, 0}));
  connect(flange_a, mechanicalPumpLosses.flange_a) annotation(
    Line(points = {{-100, 0}, {-80, 0}}, color = {0, 0, 0}));
  connect(mechanicalPumpLosses.flange_b, fluidPower2MechRot.flange_a) annotation(
    Line(points = {{-60, 0}, {-10, 0}}));
  if not frictionEnable then
    connect(flange_a, fluidPower2MechRot.flange_a) annotation(
      Line(points = {{-10, 0}, {-100, 0}}));
  end if;
  connect(motorLeakage.port_b, tank.port) annotation(
    Line(points = {{46, 10}, {68, 10}}, color = {255, 0, 0}));
  connect(fluidPower2MechRot.port_b, motorLeakage.port_a) annotation(
    Line(points = {{0, 10}, {26, 10}}, color = {255, 0, 0}));
  connect(motorLeakage1.port_b, tank1.port) annotation(
    Line(points = {{46, -10}, {68, -10}}, color = {255, 0, 0}));
  connect(motorLeakage1.port_a, fluidPower2MechRot.port_a) annotation(
    Line(points = {{26, -10}, {0, -10}}, color = {255, 0, 0}));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-120, 120}, {140, -120}}), graphics = {Ellipse(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-54, 54}, {54, -54}}), Line(points = {{0, -54}, {0, -100}}, color = {255, 0, 0}), Line(points = {{0, 100}, {0, 54}}, color = {255, 0, 0}), Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-90, 8}, {-54, -8}}), Text(extent = {{10, -80}, {40, -120}}, textString = "T"), Text(extent = {{10, 120}, {40, 80}}, textString = "P"), Polygon(fillPattern = FillPattern.Solid, points = {{80, 80}, {52, 66}, {66, 52}, {80, 80}}), Line(points = {{-80, -80}, {80, 80}}), Polygon(origin = {0, 84}, fillPattern = FillPattern.Solid, points = {{-20, -34}, {0, -54}, {20, -34}, {-20, -34}}), Text(origin = {-64, 10}, textColor = {0, 0, 255}, extent = {{200, 0}, {110, -20}}, textString = "%name")}),
    Diagram(graphics));
end VariableDisplacementMotor;
