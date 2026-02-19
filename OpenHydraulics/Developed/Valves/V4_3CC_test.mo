within OpenHydraulics.Developed.Valves;

model V4_3CC_test
  extends BaseClasses.V4_3CC_Interface;
  parameter Modelica.Units.SI.Pressure p_crack = 5 "Valve cracking/relief pressure";
  parameter Modelica.Units.SI.Pressure p_open = 5.1 "Valve fully open pressure";
  CheckValve vPA(p_crack = p_crack, p_open = p_open) annotation(
    Placement(transformation(origin = {-68, 0}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
  CheckValve vBT(p_crack = p_crack, p_open = p_open) annotation(
    Placement(transformation(origin = {64, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  CheckValve vTA(p_crack = p_crack, p_open = p_open) annotation(
    Placement(transformation(origin = {-22, 0}, extent = {{-10, -10}, {10, 10}})));
  CheckValve vBP(p_crack = p_crack, p_open = p_open) annotation(
    Placement(transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.NJunction jB annotation(
    Placement(transformation(origin = {40, 60}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.NJunction jP annotation(
    Placement(transformation(origin = {-40, -60}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.NJunction jA annotation(
    Placement(transformation(origin = {-40, 60}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.NJunction jT annotation(
    Placement(transformation(origin = {40, -60}, extent = {{-10, -10}, {10, 10}})));
  Sensors.PressureSensor pressureSensorPA(pressureType = Developed.Types.PressureTypes.Relative) annotation(
    Placement(transformation(origin = {-124, 34}, extent = {{-10, -10}, {10, 10}})));
  Sensors.PressureSensor pressureSensorTA(pressureType = Developed.Types.PressureTypes.Relative) annotation(
    Placement(transformation(origin = {122, -38}, extent = {{10, -10}, {-10, 10}})));
  BaseClasses.PressureOpening pressureOpeningPA(p_crack = p_crack, p_open = p_open)  annotation(
    Placement(transformation(origin = {-83, 33}, extent = {{-9, -9}, {9, 9}})));
  BaseClasses.PressureOpening pressureOpeningTA(p_crack = p_crack, p_open = p_open)  annotation(
    Placement(transformation(origin = {87, -39}, extent = {{9, -9}, {-9, 9}}, rotation = -0)));
equation
  connect(jA.port[1], portA) annotation(
    Line(points = {{-40, 60}, {-40, 80}}, color = {255, 0, 0}));
  connect(jP.port[1], portP) annotation(
    Line(points = {{-40, -60}, {-40, -80}}, color = {255, 0, 0}));
  connect(jB.port[1], portB) annotation(
    Line(points = {{40, 60}, {40, 80}}, color = {255, 0, 0}));
  connect(jT.port[1], portT) annotation(
    Line(points = {{40, -60}, {40, -80}}, color = {255, 0, 0}));
  connect(vPA.port_b, jP.port[2]) annotation(
    Line(points = {{-68, -10}, {-68, -60}, {-40, -60}}, color = {255, 0, 0}));
  connect(vPA.port_a, jA.port[2]) annotation(
    Line(points = {{-68, 10}, {-68, 60}, {-40, 60}}, color = {255, 0, 0}));
  connect(vBT.port_a, jT.port[2]) annotation(
    Line(points = {{64, -10}, {64, -60}, {40, -60}}, color = {255, 0, 0}));
  connect(vBT.port_b, jB.port[2]) annotation(
    Line(points = {{64, 10}, {64, 60}, {40, 60}}, color = {255, 0, 0}));
  connect(jT.port[3], vTA.port_b) annotation(
    Line(points = {{40, -60}, {-14, -60}, {-14, 0}, {-12, 0}}, color = {255, 0, 0}));
  connect(vTA.port_a, jA.port[3]) annotation(
    Line(points = {{-32, 0}, {-40, 0}, {-40, 60}}, color = {255, 0, 0}));
  connect(vBP.port_b, jB.port[3]) annotation(
    Line(points = {{30, 0}, {40, 0}, {40, 60}}, color = {255, 0, 0}));
  connect(vBP.port_a, jP.port[3]) annotation(
    Line(points = {{10, 0}, {8, 0}, {8, -60}, {-40, -60}}, color = {255, 0, 0}));
  connect(pressureSensorPA.port_b, jA.port[4]) annotation(
    Line(points = {{-121, 24}, {-18, 24}, {-18, 60}, {-40, 60}}, color = {255, 0, 0}));
  connect(pressureSensorTA.port_b, jT.port[4]) annotation(
    Line(points = {{119, -48}, {41, -48}, {41, -60}, {40, -60}}, color = {255, 0, 0}));
  connect(pressureSensorTA.port_a, jA.port[5]) annotation(
    Line(points = {{125, -48}, {125, 70}, {-40, 70}, {-40, 60}}, color = {255, 0, 0}));
  connect(pressureSensorPA.port_a, jP.port[4]) annotation(
    Line(points = {{-127, 24}, {-127, -52}, {-40, -52}, {-40, -60}}, color = {255, 0, 0}));
  connect(pressureOpeningPA.y, vBT.opening) annotation(
    Line(points = {{-73, 33}, {80, 33}, {80, 0}, {72, 0}}, color = {0, 0, 127}));
  connect(pressureOpeningPA.y, vPA.opening) annotation(
    Line(points = {{-73, 33}, {-52, 33}, {-52, 0}, {-60, 0}}, color = {0, 0, 127}));
  connect(pressureSensorPA.y, pressureOpeningPA.u) annotation(
    Line(points = {{-117, 34}, {-94, 34}}, color = {0, 0, 127}));
  connect(pressureOpeningTA.y, vTA.opening) annotation(
    Line(points = {{78, -38}, {-42, -38}, {-42, 14}, {-22, 14}, {-22, 8}}, color = {0, 0, 127}));
  connect(pressureOpeningTA.y, vBP.opening) annotation(
    Line(points = {{78, -38}, {46, -38}, {46, 14}, {20, 14}, {20, 8}}, color = {0, 0, 127}));
  connect(pressureSensorTA.y, pressureOpeningTA.u) annotation(
    Line(points = {{116, -38}, {98, -38}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-74, -30}, {-74, 30}}, color = {0, 0, 0}), Line(points = {{-46, -30}, {-46, 30}}, color = {0, 0, 0}), Polygon(points = {{-74, 30}, {-80, 10}, {-68, 10}, {-74, 30}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-46, -30}, {-52, -10}, {-40, -10}, {-46, -30}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Line(points = {{74, -30}, {46, 30}}, color = {0, 0, 0}), Line(points = {{46, -30}, {74, 30}}, color = {0, 0, 0}), Polygon(points = {{74, -30}, {58, -14}, {70, -8}, {74, -30}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{74, 30}, {70, 6}, {58, 12}, {74, 30}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Line(points = {{-14, -30}, {-14, -12}}, color = {0, 0, 0}), Line(points = {{-20, -12}, {-8, -12}}, color = {0, 0, 0}), Line(points = {{-20, 12}, {-8, 12}}, color = {0, 0, 0}), Line(points = {{8, 12}, {20, 12}}, color = {0, 0, 0}), Line(points = {{8, -12}, {20, -12}}, color = {0, 0, 0}), Line(points = {{-14, 12}, {-14, 30}}, color = {0, 0, 0}), Line(points = {{14, 12}, {14, 30}}, color = {0, 0, 0}), Line(points = {{14, -30}, {14, -12}}, color = {0, 0, 0}), Line(points = {{-14, 30}, {-14, 60}, {-40, 60}, {-40, 80}}, color = {255, 0, 0}), Line(points = {{14, 30}, {14, 60}, {40, 60}, {40, 80}}, color = {255, 0, 0}), Line(points = {{-14, -30}, {-14, -60}, {-40, -60}, {-40, -80}}, color = {255, 0, 0}), Line(points = {{14, -30}, {14, -60}, {40, -60}, {40, -80}}, color = {255, 0, 0})}),
    Diagram(coordinateSystem(extent = {{-140, 100}, {140, -100}})));
end V4_3CC_test;
