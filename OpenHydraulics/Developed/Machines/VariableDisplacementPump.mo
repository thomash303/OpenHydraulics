within OpenHydraulics.Developed.Machines;

model VariableDisplacementPump 
  "Variable Displacement Pump with losses"
  
  
  // Inheriting from the OET
  extends Interfaces.BaseClasses.PartialFluidComponent;
  
  // Importing from the MSL
  import Modelica.Units.SI;
  import Modelica.Mechanics.Rotational.Interfaces.Flange_a;
  import Modelica.Blocks.Interfaces.RealInput;
  
    // Additional model improvement flags
  parameter Boolean frictionEnable = false "Enable friction model" annotation(
    Dialog(group = "Non-Ideal Models"),
    choices(checkBox = true));
  parameter Boolean leakageEnable = false "Enable fluid leakage model" annotation(
    Dialog(group = "Non-Ideal Models"),
    choices(checkBox = true));
  
  // Sizing parameters
  parameter SI.Volume Dmax = 0.001 "Maximum pump displacement" annotation(
    Dialog(tab = "Sizing"));
  parameter SI.Volume Dmin = 0 "Minimum pump displacement (<0 for over-center)" annotation(
    Dialog(tab = "Sizing"));
  parameter SI.Volume Dlimit = max(abs(Dmax), abs(Dmin)) "Displacement of pump" annotation(
    Dialog(tab = "Sizing"));
  
  // Fluid leakage parameters
   parameter Types.HydraulicLeakage CMotorLeakage = 0 "Motor leakage coefficient" annotation(
    Dialog(group = "Leakage"));  
  
  // Torque loss parameters
  /*
  parameter SI.Torque C_T1 = 0 "Schlosser torque loss parameter" annotation(
    Dialog(group = "Friction"));
  parameter SI.Volume C_T2 = 0 "Schlosser torque loss parameter" annotation(
    Dialog(group = "Friction"));
  parameter Real C_T3(unit="N.m.s") = 0 "Schlosser torque loss parameter" annotation(
    Dialog(group = "Friction"));
  parameter Real C_T4(unit="N.m.s2") = 0 "Schlosser torque loss parameter" annotation(
    Dialog(group = "Friction"));
  */
  
  // Torque loss parameters
  parameter Real Cv = 60000 "Coefficient of viscous drag" annotation(
    Dialog(group = "Friction"));
  parameter Real Cf = 0.007 "Coefficient of Coulomb friction (fraction of full stroke torque)" annotation(
    Dialog(group = "Friction"));

  // Friction
  BaseClasses.MechanicalPumpLosses mechanicalPumpLosses(Cv = Cv, Cf = Cf, Dmax = Dlimit) if frictionEnable annotation(
    Placement(transformation(extent = {{-80, -10}, {-60, 10}})));
  
  // Fluid components
  Machines.FluidPower2MechRotVar fluidPower2MechRot(final Dmax = Dmax, final Dmin = Dmin, final Dlimit = Dlimit) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Interfaces.NJunction j1 annotation(
    Placement(transformation(extent = {{-10, -50}, {10, -30}})));
  Interfaces.NJunction j2 annotation(
    Placement(transformation(extent = {{-10, 30}, {10, 50}})));
  
  // Fluid ports
  Interfaces.FluidPort portP annotation(
    Placement(transformation(extent = {{-10, 90}, {10, 110}})));
  Interfaces.FluidPort portT annotation(
    Placement(transformation(extent = {{-10, -110}, {10, -90}})));
  
  // Rotational flange
  Flange_a flange_a "(left) driving flange (flange axis directed INTO cut plane)" annotation(
    Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
  
  RealInput dispFraction annotation(
    Placement(transformation(extent = {{-100, -96}, {-68, -64}})));
  
  // Motor leakage
  Cylinders.BaseClasses.Leakage motorLeakage(CLeakage = CMotorLeakage) if leakageEnable annotation(
    Placement(transformation(origin = {36, -2}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
protected
  SI.Pressure dp = portP.p - portT.p;
  
equation

  mechanicalPumpLosses.dp = dp;
  connect(fluidPower2MechRot.dispFraction, dispFraction) annotation(
    Line(points = {{-8.5, -7.9}, {-42, -7.9}, {-42, -80}, {-84, -80}}, color = {0, 0, 127}));
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
  connect(motorLeakage.port_a, j2.port[3]) annotation(
    Line(points = {{36, 8}, {34, 8}, {34, 40}, {0, 40}}, color = {255, 0, 0}));
  connect(motorLeakage.port_b, j1.port[3]) annotation(
    Line(points = {{36, -12}, {36, -40}, {0, -40}}, color = {255, 0, 0}));
  
  if not frictionEnable then
    connect(flange_a, fluidPower2MechRot.flange_a) annotation(
    Line(points = {{-10, 0}, {-100, 0}}));
  end if;

  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(extent = {{-54, 54}, {54, -54}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{0, -54}, {0, -100}}, color = {255, 0, 0}), Line(points = {{0, 100}, {0, 54}}, color = {255, 0, 0}), Rectangle(extent = {{-90, 8}, {-54, -8}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{100, -54}, {-100, -90}}, textString = "%name"), Text(extent = {{10, -80}, {40, -120}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "T"), Polygon(points = {{-20, 34}, {0, 54}, {20, 34}, {-20, 34}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-20, -34}, {0, -54}, {20, -34}, {-20, -34}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Text(extent = {{10, 120}, {40, 80}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "P"), Polygon(points = {{80, 80}, {52, 66}, {66, 52}, {80, 80}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {80, 80}}, color = {0, 0, 0})}),
    Diagram(graphics = {Text(extent = {{52, 76}, {52, 64}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, textString = "section for"), Text(extent = {{52, 88}, {52, 76}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, textString = "see equations"), Rectangle(extent = {{12, 88}, {90, 52}}, lineColor = {0, 0, 255}), Text(extent = {{52, 64}, {52, 52}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, textString = "loss relationships")}));
end VariableDisplacementPump;
