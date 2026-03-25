within OpenHydraulics.Developed.Circuits;

model pidTest
  inner Developed.Systems.System system(redeclare package Medium = Developed.Media.GenericOil, m_flow_start = 0.001) annotation(
    Placement(transformation(origin = {-118, 108}, extent = {{-10, -10}, {10, 10}})));
  Developed.Machines.VariableDisplacementPumpMotor variableDisplacementPump(p_init(displayUnit = "bar") = 2.5e7, Dmax = 100e-6, frictionEnable = false, leakageEnable = false, Dmin = -100e-6) annotation(
    Placement(transformation(origin = {16, 24}, extent = {{10, 10}, {-10, -10}})));
  Developed.Sources.VarPressureSource source annotation(
    Placement(transformation(origin = {14, 60}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
  Developed.Sources.ConstPressureSource constPSource annotation(
    Placement(transformation(origin = {14, -28}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Sine sine(amplitude = 5e5, f = 0.1, startTime = 20) annotation(
    Placement(transformation(origin = {-54, 52}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Components.Damper damper(d = 10)  annotation(
    Placement(transformation(origin = {58, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(
    Placement(transformation(origin = {80, 8}, extent = {{-10, -10}, {10, 10}})));
  
  Modelica.Blocks.Math.Feedback feedback annotation(
          Placement(transformation(origin = {132, 76}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  //Modelica.Blocks.Continuous.PID PID annotation(
       //   Placement(transformation(origin = {50, 104}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.Constant const(k = 5.5)  annotation(
    Placement(transformation(origin = {186, 76}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation(
    Placement(transformation(origin = {126, 28}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain gain(k = 20)  annotation(
    Placement(transformation(origin = {340, 68}, extent = {{10, -10}, {-10, 10}})));
  Developed.Machines.VariableDisplacementPumpMotor variableDisplacementPump1(Dmax = 100e-6, Dmin = -100e-6, frictionEnable = false, leakageEnable = false, p_init(displayUnit = "bar") = 2.5e7) annotation(
    Placement(transformation(origin = {-176, 28}, extent = {{10, 10}, {-10, -10}})));
  Developed.Sources.VarPressureSource source1 annotation(
    Placement(transformation(origin = {-178, 64}, extent = {{-10, 10}, {10, -10}})));
  Developed.Sources.ConstPressureSource constPSource1 annotation(
    Placement(transformation(origin = {-178, -24}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Sine sine1(amplitude = 5e5, f = 0.1, startTime = 20) annotation(
    Placement(transformation(origin = {-260, 58}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Components.Damper damper1(d = 10) annotation(
    Placement(transformation(origin = {-134, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.Rotational.Components.Fixed fixed1 annotation(
    Placement(transformation(origin = {-112, 12}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant const1(k = 1) annotation(
    Placement(transformation(origin = {-132, 62}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp(height = 40e5, duration = 0, offset = 2e5)  annotation(
    Placement(transformation(origin = {-52, 82}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 0, height = 40e5, offset = 2e5) annotation(
    Placement(transformation(origin = {-256, 92}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Add add annotation(
    Placement(transformation(origin = {-14, 60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Add add1 annotation(
    Placement(transformation(origin = {-214, 66}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.PI PI(k = 20, T = 0.01)  annotation(
    Placement(transformation(origin = {76, 72}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Developed.Machines.VariableDisplacementPumpMotor variableDisplacementPump2(Dmax = 100e-6, Dmin = -100e-6, frictionEnable = false, leakageEnable = false, p_init(displayUnit = "bar") = 2.5e7) annotation(
    Placement(transformation(origin = {290, 18}, extent = {{10, 10}, {-10, -10}})));
  Developed.Sources.VarPressureSource source2 annotation(
    Placement(transformation(origin = {288, 54}, extent = {{-10, 10}, {10, -10}})));
  Developed.Sources.ConstPressureSource constPSource2 annotation(
    Placement(transformation(origin = {288, -34}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Sine sine2(amplitude = 5e5, f = 0.1, startTime = 20) annotation(
    Placement(transformation(origin = {220, 46}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Components.Damper damper2(d = 10) annotation(
    Placement(transformation(origin = {332, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.Rotational.Components.Fixed fixed2 annotation(
    Placement(transformation(origin = {354, 2}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Feedback feedback1 annotation(
    Placement(transformation(origin = {406, 70}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.Constant const2(k = 5.5) annotation(
    Placement(transformation(origin = {460, 70}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor1 annotation(
    Placement(transformation(origin = {400, 22}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp2(duration = 0, height = 40e5, offset = 2e5) annotation(
    Placement(transformation(origin = {222, 76}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Add add2 annotation(
    Placement(transformation(origin = {260, 54}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(constPSource.port, variableDisplacementPump.portP) annotation(
    Line(points = {{14, -18}, {14, -2}, {16, -2}, {16, 14}}, color = {255, 0, 0}));
  connect(variableDisplacementPump.portT, source.port) annotation(
    Line(points = {{16, 34}, {16, 42}, {14, 42}, {14, 50}}, color = {255, 0, 0}));
  connect(damper.flange_b, variableDisplacementPump.flange_a) annotation(
    Line(points = {{48, 22}, {24, 22}, {24, 24}, {26, 24}}));
  connect(damper.flange_a, fixed.flange) annotation(
    Line(points = {{68, 22}, {80, 22}, {80, 8}}));
  connect(const.y, feedback.u1) annotation(
    Line(points = {{176, 76}, {140, 76}}, color = {0, 0, 127}));
  connect(speedSensor.flange, variableDisplacementPump.flange_a) annotation(
    Line(points = {{116, 28}, {26, 28}, {26, 24}}));
  connect(speedSensor.w, feedback.u2) annotation(
    Line(points = {{137, 28}, {132, 28}, {132, 68}}, color = {0, 0, 127}));
  connect(constPSource1.port, variableDisplacementPump1.portP) annotation(
    Line(points = {{-178, -14}, {-178, 2}, {-176, 2}, {-176, 18}}, color = {255, 0, 0}));
  connect(variableDisplacementPump1.portT, source1.port) annotation(
    Line(points = {{-176, 38}, {-176, 46}, {-178, 46}, {-178, 54}}, color = {255, 0, 0}));
  connect(damper1.flange_b, variableDisplacementPump1.flange_a) annotation(
    Line(points = {{-144, 26}, {-168, 26}, {-168, 28}, {-166, 28}}));
  connect(damper1.flange_a, fixed1.flange) annotation(
    Line(points = {{-124, 26}, {-112, 26}, {-112, 12}}));
  connect(const1.y, variableDisplacementPump1.dispFraction) annotation(
    Line(points = {{-143, 62}, {-169, 62}, {-169, 36}}, color = {0, 0, 127}));
  connect(ramp.y, add.u1) annotation(
    Line(points = {{-40, 82}, {-26, 82}, {-26, 66}}, color = {0, 0, 127}));
  connect(sine.y, add.u2) annotation(
    Line(points = {{-42, 52}, {-26, 52}, {-26, 54}}, color = {0, 0, 127}));
  connect(sine1.y, add1.u2) annotation(
    Line(points = {{-249, 58}, {-227, 58}, {-227, 60}}, color = {0, 0, 127}));
  connect(ramp1.y, add1.u1) annotation(
    Line(points = {{-245, 92}, {-227, 92}, {-227, 72}}, color = {0, 0, 127}));
  connect(add1.y, source1.control) annotation(
    Line(points = {{-203, 66}, {-189, 66}, {-189, 64}}, color = {0, 0, 127}));
  connect(add.y, source.control) annotation(
    Line(points = {{-2, 60}, {4, 60}}, color = {0, 0, 127}));
  connect(PI.y, variableDisplacementPump.dispFraction) annotation(
    Line(points = {{66, 72}, {24, 72}, {24, 32}}, color = {0, 0, 127}));
  connect(PI.u, feedback.y) annotation(
    Line(points = {{88, 72}, {124, 72}, {124, 76}}, color = {0, 0, 127}));
  connect(constPSource2.port, variableDisplacementPump2.portP) annotation(
    Line(points = {{288, -24}, {288, -8}, {290, -8}, {290, 8}}, color = {255, 0, 0}));
  connect(variableDisplacementPump2.portT, source2.port) annotation(
    Line(points = {{290, 28}, {290, 36}, {288, 36}, {288, 44}}, color = {255, 0, 0}));
  connect(damper2.flange_b, variableDisplacementPump2.flange_a) annotation(
    Line(points = {{322, 16}, {298, 16}, {298, 18}, {300, 18}}));
  connect(damper2.flange_a, fixed2.flange) annotation(
    Line(points = {{342, 16}, {354, 16}, {354, 2}}));
  connect(const2.y, feedback1.u1) annotation(
    Line(points = {{449, 70}, {413, 70}}, color = {0, 0, 127}));
  connect(speedSensor1.flange, variableDisplacementPump2.flange_a) annotation(
    Line(points = {{390, 22}, {300, 22}, {300, 18}}));
  connect(speedSensor1.w, feedback1.u2) annotation(
    Line(points = {{411, 22}, {406, 22}, {406, 62}}, color = {0, 0, 127}));
  connect(ramp2.y, add2.u1) annotation(
    Line(points = {{233, 76}, {247, 76}, {247, 60}}, color = {0, 0, 127}));
  connect(sine2.y, add2.u2) annotation(
    Line(points = {{231, 46}, {247, 46}, {247, 48}}, color = {0, 0, 127}));
  connect(add2.y, source2.control) annotation(
    Line(points = {{271, 54}, {277, 54}}, color = {0, 0, 127}));
  connect(feedback1.y, gain.u) annotation(
    Line(points = {{398, 70}, {352, 70}, {352, 68}}, color = {0, 0, 127}));
  connect(gain.y, variableDisplacementPump2.dispFraction) annotation(
    Line(points = {{330, 68}, {298, 68}, {298, 26}}, color = {0, 0, 127}));
  annotation(
    uses(OpenHydraulics(version = "2.0.0"), Modelica(version = "4.0.0")),
  experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.002),
  Diagram(coordinateSystem(extent = {{-280, 140}, {480, -40}})),
  version = "");
end pidTest;
