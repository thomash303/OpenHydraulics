within OpenHydraulics.Developed.Testing;

model cylinder_driving
  Modelica.Mechanics.Translational.Components.Fixed fixed annotation(
    Placement(transformation(extent = {{-22, 40}, {-2, 60}})));
  Modelica.Blocks.Sources.Ramp ramp(duration = 100, height = 1000) annotation(
    Placement(transformation(origin = {-26, -4}, extent = {{-74, -46}, {-54, -26}})));
  Modelica.Mechanics.Rotational.Sources.Position position(f_crit = 1, useSupport = false) annotation(
    Placement(transformation(extent = {{-46, -46}, {-26, -26}})));
  Interfaces.NJunction j1 annotation(
    Placement(transformation(origin = {28, 0}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.NJunction j2 annotation(
    Placement(transformation(origin = {90, -54}, extent = {{-10, -10}, {10, 10}})));
  Volumes.CircuitTank circuitTank annotation(
    Placement(transformation(origin = {40, -82}, extent = {{-10, -10}, {10, 10}})));
  Machines.FluidPower2MechRotConst fluidPower2MechRotConst(Dconst = 5e-5)  annotation(
    Placement(transformation(origin = {6, -34}, extent = {{-10, -10}, {10, 10}})));
  Cylinders.DoubleActingCylinder doubleActingCylinder(strokeLength = 0.4, q_nom = 1e-4, pistonRodMass = 0.1, s_init = 0.185, leakageEnable = false, stribeckFrictionEnable = false, Cv = 0, f_st = 1, f_c = 0, compressibleEnable = true, CRodExLeakage = 0.1)  annotation(
    Placement(transformation(origin = {66, 48}, extent = {{-10, -10}, {10, 10}})));  
  /*Custom.Cylinders.DoubleActingCylinder doubleActingCylinder(strokeLength = 0.4, q_nom = 1e-4, pistonMass = 0.1, s_init = 0.185)  annotation(
    Placement(transformation(origin = {66, 48}, extent = {{-10, -10}, {10, 10}})));  */
  
    /*OpenHydraulics.Components.Cylinders.DoubleActingCylinderNoCushion doubleActingCylinder(initType = OpenHydraulics.Types.RevoluteInit.Free, strokeLength = 0.4, pistonMass = 0.1, s_init = 0.185, q_nom = 1e-4, useCushionHead = false, useCushionRod = false, L_A2B = 0, D_A2B = 0, L_A2Env = 0, D_A2Env = 0, L_B2Env = 0, D_B2Env = 0, cushionTableHead = [0, 0; 0, 0; 0, 0; 0, 0], cushionTableRod = [0, 0; 0, 0; 0, 0; 0, 0]) annotation(
    Placement(transformation(extent = {{22, 40}, {42, 60}})));*/
  
  extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare OpenHydraulics.Fluids.GenericOilSimple oil);
  inner Systems.System system annotation(
    Placement(transformation(origin = {-74, 78}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Sine sine(amplitude = 1, f = 0.5) annotation(
    Placement(transformation(origin = {-76, 2}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(position.flange, fluidPower2MechRotConst.flange_a) annotation(
    Line(points = {{-26, -36}, {-4, -36}, {-4, -34}}));
  connect(fluidPower2MechRotConst.port_b, j1.port[1]) annotation(
    Line(points = {{6, -24}, {6, 0}, {28, 0}}, color = {255, 0, 0}));
  connect(fluidPower2MechRotConst.port_a, circuitTank.port_a) annotation(
    Line(points = {{6, -44}, {6, -82}, {30, -82}}, color = {255, 0, 0}));
  connect(circuitTank.port_b, j2.port[1]) annotation(
    Line(points = {{50, -82}, {88, -82}, {88, -54}, {90, -54}}, color = {255, 0, 0}));
  connect(fixed.flange, doubleActingCylinder.flange_a) annotation(
    Line(points = {{-12, 50}, {56, 50}, {56, 48}}, color = {0, 127, 0}));
  connect(j1.port[2], doubleActingCylinder.port_a) annotation(
    Line(points = {{28, 0}, {56, 0}, {56, 40}, {58, 40}}, color = {255, 0, 0}));
  connect(doubleActingCylinder.port_b, j2.port[2]) annotation(
    Line(points = {{74, 40}, {90, 40}, {90, -54}}, color = {255, 0, 0}));
  connect(sine.y, position.phi_ref) annotation(
    Line(points = {{-64, 2}, {-48, 2}, {-48, -36}}, color = {0, 0, 127}));
annotation(
    experiment(StartTime = 0, StopTime = 25, Tolerance = 1e-08, Interval = 0.002));
end cylinder_driving;
