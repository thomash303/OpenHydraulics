within OpenHydraulics.Developed.Machines;

model ConstantDisplacementPumpMotor "Variable Displacement Pump/Motor with losses"
  // Inheriting from the OET
  extends Interfaces.BaseClasses.PartialFluidComponent;
  // Importing from the MSL
  import Modelica.Units.SI;
  import Modelica.Mechanics.Rotational.Interfaces.Flange_a;
  // Additional model improvement flags
  parameter Boolean frictionEnable = false "Enable friction model" annotation(
    Dialog(group = "Non-Ideal Models"),
    choices(checkBox = true));
  parameter Boolean leakageEnable = false "Enable fluid leakage model" annotation(
    Dialog(group = "Non-Ideal Models"),
    choices(checkBox = true));
  // Sizing parameters
  parameter SI.Volume Dconst = 0.001 "Pump displacement" annotation(
    Dialog(tab = "Sizing"));
  // McCandlish and Dory motor loss parameters
  parameter Real Cs[:] = {0, 0} "Slips coefficient (hydraulic loss)" annotation(
    Dialog(group = "Losses"));
  parameter Real CsD[:] = {0, 1} "Displacement fraction of slip coefficients" annotation(
    Dialog(group = "Losses"));
  parameter Real Cv[:] = {0, 0} "Coefficients of viscous drag (mechanical loss)" annotation(
    Dialog(group = "Losses"));
  parameter Real CvD[:] = {0, 1} "Displacement fraction of slip coefficients" annotation(
    Dialog(group = "Losses"));
  parameter Real Cf[:] = {0, 0} "Coefficients of Coulomb friction (mechanical loss)" annotation(
    Dialog(group = "Losses"));
  parameter Real CfD[:] = {0, 1} "Displacement fraction of slip coefficients" annotation(
    Dialog(group = "Losses"));
  // Friction model
  BaseClasses.MechanicalPumpLosses mechanicalPumpLosses(Cv = Cv, CvD = CvD, Cf = Cf, CfD = CfD, dpMot = dp, Dmax = Dconst, alpha = dispFraction, mu = system.mu) if frictionEnable annotation(
    Placement(transformation(extent = {{-80, -10}, {-60, 10}})));
  // Fluid components
  FluidPower2MechRotConst fluidPower2MechRot(final Dconst = Dconst, p_init_a = p_init_T, p_init_b = p_init_P) annotation(
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
  
  // Motor leakage
  BaseClasses.FluidLeakage motorLeakage(p_init_a = p_init_P, p_init_b = p_init_T, Cs = Cs, CsD = CsD, dpMot = dp, Dmax = Dconst, alpha = dispFraction, mu = system.mu, portSelect = OpenHydraulics.Developed.Types.HydraulicPort.port_P) if leakageEnable annotation(
    Placement(transformation(origin = {40, 10}, extent = {{-10, -10}, {10, 10}})));
  OpenHydraulics.Developed.Volumes.OpenTank tank if leakageEnable annotation(
    Placement(transformation(origin = {72, 20}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
  OpenHydraulics.Developed.Machines.BaseClasses.FluidLeakage motorLeakage1(Cs = Cs, CsD = CsD, Dmax = Dconst, alpha = dispFraction, dpMot = dp, mu = system.mu, p_init_a = p_init_P, p_init_b = p_init_T, portSelect = OpenHydraulics.Developed.Types.HydraulicPort.port_T) if leakageEnable annotation(
    Placement(transformation(origin = {40, -10}, extent = {{-10, -10}, {10, 10}})));
  OpenHydraulics.Developed.Volumes.OpenTank tank1 if leakageEnable annotation(
    Placement(transformation(origin = {72, -20}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));

  // Power, energy, and efficiency
  SI.Power Pmot_hyd "Hydraulic pump/motor power";
  SI.Power Pmot_mech = flange_a.tau * der(flange_a.phi) "Mechanical pump/motor power";
  
 // SI.Energy Emot_hyd "Hydraulic pump/motor energy";
  SI.Energy Emot_mech "Mechanical pump/motor energy";
  
  //Real motEff = min(abs(Pmot_hyd), abs(Pmot_mech)) / (max(abs(Pmot_hyd), abs(Pmot_mech))) "Pump/motor efficiency";
  

  constant Real dispFraction = 1 "introduced as constant to keep equations consistent with other pumps";
  SI.Pressure dp = portP.p - portT.p annotation(
    Placement(visible = false, transformation(extent = {{0, 0}, {0, 0}})));public
  
equation
// Power  
  Pmot_hyd = smooth(1, noEvent(dp * (if portP.m_flow >= 0 then -portT.m_flow else -portP.m_flow) / system.rho_ambient));
// Energy
  //der(Emot_hyd) = smooth(1,Pmot_hyd);
  der(Emot_mech) = smooth(1,Pmot_mech);
// Connect the input of the leakage model and the mechanical loss model
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
    Line(points = {{-60, 0}, {-10, 0}}, color = {0, 0, 0}));
  if not frictionEnable then
    connect(flange_a, fluidPower2MechRot.flange_a) annotation(
      Line(points = {{-10, 0}, {-100, 0}}));
  end if;
  connect(motorLeakage.port_b, tank.port) annotation(
    Line(points = {{50, 10}, {72, 10}}, color = {255, 0, 0}));
  connect(fluidPower2MechRot.port_b, motorLeakage.port_a) annotation(
    Line(points = {{0, 10}, {30, 10}}, color = {255, 0, 0}));
  connect(motorLeakage1.port_b, tank1.port) annotation(
    Line(points = {{50, -10}, {72, -10}}, color = {255, 0, 0}));
  connect(motorLeakage1.port_a, fluidPower2MechRot.port_a) annotation(
    Line(points = {{30, -10}, {0, -10}}, color = {255, 0, 0}));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(extent = {{-54, 54}, {54, -54}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{0, -54}, {0, -100}}, color = {255, 0, 0}), Line(points = {{0, 100}, {0, 54}}, color = {255, 0, 0}), Rectangle(extent = {{-90, 8}, {-54, -8}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{100, -54}, {-100, -90}}, textString = "%name"), Text(extent = {{10, -80}, {40, -120}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "T"), Polygon(points = {{-20, 34}, {0, 54}, {20, 34}, {-20, 34}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-20, -34}, {0, -54}, {20, -34}, {-20, -34}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Text(extent = {{10, 120}, {40, 80}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "P")}),
    Diagram);
end ConstantDisplacementPumpMotor;
