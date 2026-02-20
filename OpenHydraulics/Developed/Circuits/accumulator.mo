within OpenHydraulics.Developed.Circuits;

model accumulator
  Sources.VarPressureSource HPvarPSource annotation(
    Placement(transformation(origin = {-46, 48}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Sine sineHP(amplitude = 5e5, f = 0.1, startTime = 3, offset = 13.2e6)  annotation(
    Placement(transformation(origin = {-92, 48}, extent = {{-10, -10}, {10, 10}})));
  Volumes.Accumulator HPaccumulator(liquidVolume = 3.5, gasVolume = 4, p_precharge(displayUnit = "MPa") = 1.32e7, initType = OpenHydraulics.Developed.Types.AccInit.Volume, p_init = 3e5)  annotation(
    Placement(transformation(origin = {-2, 72}, extent = {{-10, -10}, {10, 10}})));
  Volumes.Accumulator LPaccumulator(liquidVolume = 1.25, gasVolume = 1.75, p_precharge(displayUnit = "mPa") = 0.0066, initType = OpenHydraulics.Developed.Types.AccInit.Volume)  annotation(
    Placement(transformation(origin = {2, -24}, extent = {{-10, 10}, {10, -10}})));
  Interfaces.NJunction jHP annotation(
    Placement(transformation(origin = {-2, 54}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.NJunction jLP annotation(
    Placement(transformation(origin = {2, -2}, extent = {{-10, -10}, {10, 10}})));
  Machines.FluidPower2MechRotConst motor(Dconst = 0.00025)  annotation(
    Placement(transformation(origin = {26, 22}, extent = {{-10, -10}, {10, 10}})));
  inner Systems.System system annotation(
    Placement(transformation(origin = {-110, 72}, extent = {{-10, -10}, {10, 10}})));
  Custom.Basic.LaminarRestriction laminarRestriction(L = 10)  annotation(
    Placement(transformation(origin = {22, -4}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(sineHP.y, HPvarPSource.control) annotation(
    Line(points = {{-80, 48}, {-56, 48}}, color = {0, 0, 127}));
  connect(HPvarPSource.port, jHP.port[1]) annotation(
    Line(points = {{-46, 58}, {-2, 58}, {-2, 54}}, color = {255, 0, 0}));
  connect(HPaccumulator.port_a, jHP.port[2]) annotation(
    Line(points = {{-2, 62}, {-2, 54}}, color = {255, 0, 0}));
  connect(LPaccumulator.port_a, jLP.port[2]) annotation(
    Line(points = {{2, -14}, {2, -2}}, color = {255, 0, 0}));
  connect(jHP.port[3], motor.port_b) annotation(
    Line(points = {{-2, 54}, {26, 54}, {26, 32}}, color = {255, 0, 0}));
  connect(motor.port_a, laminarRestriction.port_b) annotation(
    Line(points = {{26, 12}, {32, 12}, {32, -4}}, color = {255, 0, 0}));
  connect(laminarRestriction.port_a, jLP.port[3]) annotation(
    Line(points = {{12, -4}, {2, -4}, {2, -2}}, color = {255, 0, 0}));
  annotation(
    Diagram(coordinateSystem(extent = {{-120, 80}, {40, -40}})));
end accumulator;
