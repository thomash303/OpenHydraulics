within OpenHydraulics.Developed.Circuits;

model accumulator
  Sources.VarPressureSource HPvarPSource annotation(
    Placement(transformation(origin = {-46, 48}, extent = {{-10, -10}, {10, 10}})));
  Sources.VarPressureSource LPvarPSource annotation(
    Placement(transformation(origin = {-44, -18}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Sine sineHP(amplitude = 5e5, f = 0.1, offset = 13.2e6)  annotation(
    Placement(transformation(origin = {-92, 48}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Sine sineLP(amplitude = 2.5e5, f = 0.1, offset = 6.6e6)  annotation(
    Placement(transformation(origin = {-92, -18}, extent = {{-10, -10}, {10, 10}})));
  Volumes.Accumulator HPaccumulator(liquidVolume = 7.5, gasVolume = 8, p_precharge(displayUnit = "MPa") = 1.32e7, initType = OpenHydraulics.Developed.Types.AccInit.Volume)  annotation(
    Placement(transformation(origin = {-2, 72}, extent = {{-10, -10}, {10, 10}})));
  Volumes.Accumulator LPaccumulator(liquidVolume = 3, gasVolume = 3.25, p_precharge(displayUnit = "mPa") = 0.0066, initType = OpenHydraulics.Developed.Types.AccInit.Volume)  annotation(
    Placement(transformation(origin = {2, -24}, extent = {{-10, 10}, {10, -10}})));
  Interfaces.NJunction jHP annotation(
    Placement(transformation(origin = {-2, 54}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.NJunction jLP annotation(
    Placement(transformation(origin = {2, -2}, extent = {{-10, -10}, {10, 10}})));
  Machines.FluidPower2MechRotConst motor(Dconst = 0.00025)  annotation(
    Placement(transformation(origin = {26, 22}, extent = {{-10, -10}, {10, 10}})));
  inner Systems.System system annotation(
    Placement(transformation(origin = {-110, 72}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(sineHP.y, HPvarPSource.control) annotation(
    Line(points = {{-80, 48}, {-56, 48}}, color = {0, 0, 127}));
  connect(sineLP.y, LPvarPSource.control) annotation(
    Line(points = {{-81, -18}, {-54, -18}}, color = {0, 0, 127}));
  connect(HPvarPSource.port, jHP.port[1]) annotation(
    Line(points = {{-46, 58}, {-2, 58}, {-2, 54}}, color = {255, 0, 0}));
  connect(HPaccumulator.port_a, jHP.port[2]) annotation(
    Line(points = {{-2, 62}, {-2, 54}}, color = {255, 0, 0}));
  connect(LPvarPSource.port, jLP.port[1]) annotation(
    Line(points = {{-44, -8}, {-44, -2}, {2, -2}}, color = {255, 0, 0}));
  connect(LPaccumulator.port_a, jLP.port[2]) annotation(
    Line(points = {{2, -14}, {2, -2}}, color = {255, 0, 0}));
  connect(jHP.port[3], motor.port_b) annotation(
    Line(points = {{-2, 54}, {26, 54}, {26, 32}}, color = {255, 0, 0}));
  connect(jLP.port[3], motor.port_a) annotation(
    Line(points = {{2, -2}, {26, -2}, {26, 12}}, color = {255, 0, 0}));

annotation(
    Diagram(coordinateSystem(extent = {{-120, 80}, {40, -40}})));
end accumulator;
