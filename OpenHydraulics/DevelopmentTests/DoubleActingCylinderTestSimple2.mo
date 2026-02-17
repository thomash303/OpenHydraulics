within OpenHydraulics.DevelopmentTests;

model DoubleActingCylinderTestSimple2
  extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare OpenHydraulics.Fluids.GenericOilSimple oil);
  Modelica.Mechanics.Translational.Components.Fixed fixed annotation(
    Placement(transformation(extent = {{-22, 40}, {-2, 60}})));
  OpenHydraulics.Components.Cylinders.DoubleActingCylinderNoCushion doubleActingCylinder(initType = OpenHydraulics.Types.RevoluteInit.Free, strokeLength = 0.4, pistonMass = 0.1, s_init = 0.185, q_nom = 1e-4, useCushionHead = false, useCushionRod = false, L_A2B = 0, D_A2B = 0, L_A2Env = 0, D_A2Env = 0, L_B2Env = 0, D_B2Env = 0, cushionTableHead = [0, 0; 0, 0; 0, 0; 0, 0], cushionTableRod = [0, 0; 0, 0; 0, 0; 0, 0]) annotation(
    Placement(transformation(extent = {{22, 40}, {42, 60}})));
  OpenHydraulics.Basic.FluidPower2MechRotConst pump(Dconst = 5e-5) annotation(
    Placement(transformation(extent = {{-24, -46}, {-4, -26}})));
  OpenHydraulics.Components.Volumes.CircuitTank circuitTank annotation(
    Placement(transformation(extent = {{30, -90}, {10, -70}})));
  Modelica.Blocks.Sources.Ramp ramp(height = 1000, duration = 100) annotation(
    Placement(transformation(origin = {-20, 0}, extent = {{-74, -46}, {-54, -26}})));
  Modelica.Mechanics.Rotational.Sources.Position position(f_crit = 1, useSupport = false) annotation(
    Placement(transformation(extent = {{-46, -46}, {-26, -26}})));
  Components.Lines.NJunction j1(n_ports = 3) annotation(
    Placement(transformation(extent = {{0, -26}, {20, -6}})));
  Components.Lines.NJunction j2(n_ports = 3) annotation(
    Placement(transformation(extent = {{30, -66}, {50, -46}})));
  Modelica.Blocks.Sources.Sine sine(amplitude = 1, f = 0.5) annotation(
    Placement(transformation(origin = {-76, 2}, extent = {{-10, -10}, {10, 10}})));
initial equation
//reliefValve.port_a.p = 101325;
equation
  connect(fixed.flange, doubleActingCylinder.flange_a) annotation(
    Line(points = {{-12, 50}, {22, 50}}, color = {0, 127, 0}));
  connect(pump.port_a, circuitTank.port_b) annotation(
    Line(points = {{-14, -46}, {-14, -80}, {10, -80}}, color = {255, 0, 0}));
  connect(position.flange, pump.flange_a) annotation(
    Line(points = {{-26, -36}, {-24, -36}}));
  connect(pump.port_b, j1.port[1]) annotation(
    Line(points = {{-14, -26}, {-14, -16}, {10, -16}, {10, -16.6667}}, color = {255, 0, 0}));
  connect(circuitTank.port_a, j2.port[1]) annotation(
    Line(points = {{30, -80}, {40, -80}, {40, -56.6667}}, color = {255, 0, 0}));
  connect(doubleActingCylinder.port_b, j2.port[3]) annotation(
    Line(points = {{40, 42}, {40, -55.3333}}, color = {255, 0, 0}));
  connect(doubleActingCylinder.port_a, j1.port[3]) annotation(
    Line(points = {{24, 42}, {24, -16}, {10, -16}, {10, -15.3333}}, color = {255, 0, 0}));
  connect(sine.y, position.phi_ref) annotation(
    Line(points = {{-64, 2}, {-48, 2}, {-48, -36}}, color = {0, 0, 127}));
  annotation(
    experiment(StopTime = 9, Tolerance = 1e-08, StartTime = 0, Interval = 0.02),
    Diagram);
end DoubleActingCylinderTestSimple2;
