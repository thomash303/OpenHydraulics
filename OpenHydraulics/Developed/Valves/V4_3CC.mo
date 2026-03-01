within OpenHydraulics.Developed.Valves;

model V4_3CC

  // Inheriting from the OET
  extends BaseClasses.V4_3CC_Interface;
  
  // Importing from the MSL
  import Modelica.Fluid.Types.CvTypes;
  import Modelica.Units.SI;

  // Valve characteristic parameters
  parameter SI.Pressure p_crack = 5 "Valve cracking pressure" annotation(
    Dialog(group = "Valve Characteristics", enable = not manualValveControl));
  parameter SI.Pressure p_open = 5.1 "Valve fully open pressure" annotation(
    Dialog(group = "Valve Characteristics", enable = not manualValveControl));
  
  //parameter Real Av = 0.000012;
 
    
  // Enabling parameters
  parameter Boolean filterEnable = true "Enable min/max filtering of the input signal (0-1). Strongly recommend to enable." annotation(Dialog(group = "Valve Characteristics"),
    choices(checkBox = true));  
  parameter Boolean responseEnable = false "Enable dynamic (second-order) response" annotation(Dialog(tab="Dynamic Response", enable = manualValveControl),
    choices(checkBox = true));
  
  // Dynamic response parameters
  parameter SI.Frequency bandwidth = 10 "Bandwidth of 2nd order response"
    annotation(Dialog(tab="Dynamic Response", enable = responseEnable));
  parameter Real dampingCoeff = 1 "Damping coefficient of 2nd order response"
    annotation(Dialog(tab="Dynamic Response", enable = responseEnable));
  
  // Flow coefficient
  parameter Real Cd = 1 "Discharge coefficient" annotation(
    Dialog(group = "Flow coefficient"));
  parameter CvTypes CvData = CvTypes.OpPoint "Selection of flow coefficient" annotation(
    Dialog(group = "Flow coefficient"));
  // Av (default)
  parameter SI.Area Av(fixed = CvData == CvTypes.Av) "Av (metric) flow coefficient" annotation(
    Dialog(group = "Flow coefficient", enable = (CvData == Modelica.Fluid.Types.CvTypes.Av)));
  // Kv (metric)
  parameter Real Kv = 0 "Kv (metric) flow coefficient [m3/h]" annotation(
    Dialog(group = "Flow coefficient", enable = (CvData == Modelica.Fluid.Types.CvTypes.Kv)));
  // Cv (imperial)
  parameter Real Cv = 0 "Cv (US) flow coefficient [USG/min]" annotation(
    Dialog(group = "Flow coefficient", enable = (CvData == Modelica.Fluid.Types.CvTypes.Cv)));

  replaceable function valveCharacteristic = BaseClasses.ValveCharacteristics.linear constrainedby BaseClasses.ValveCharacteristics.baseFun "Valve flow characteristic" annotation(Dialog(group = "Valve Characteristics"),
     choicesAllMatching = true);

  CheckValve vPA(p_crack = p_crack, p_open = p_open, CvData = CvData, Av = Av, manualValveControl = manualValveControl, Kv = Kv, Cv = Cv, redeclare replaceable function valveCharacteristic = valveCharacteristic, responseEnable = responseEnable, bandwidth = bandwidth, dampingCoeff = dampingCoeff, p_init = p_init, Cd = Cd) annotation(
    Placement(transformation(origin = {-68, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  CheckValve vBT(p_crack = p_crack, p_open = p_open, CvData = CvData, Av = Av, manualValveControl = manualValveControl, Kv = Kv, Cv = Cv, redeclare replaceable function valveCharacteristic = valveCharacteristic, responseEnable = responseEnable, bandwidth = bandwidth, dampingCoeff = dampingCoeff, p_init = p_init, Cd = Cd) annotation(
    Placement(transformation(origin = {64, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  CheckValve vAT(p_crack = p_crack, p_open = p_open, CvData = CvData, Av = Av, manualValveControl = manualValveControl, Kv = Kv, Cv = Cv, redeclare replaceable function valveCharacteristic = valveCharacteristic, responseEnable = responseEnable, bandwidth = bandwidth, dampingCoeff = dampingCoeff, p_init = p_init, Cd = Cd) annotation(
    Placement(transformation(origin = {-22, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  CheckValve vPB(p_crack = p_crack, p_open = p_open, CvData = CvData, Av = Av, manualValveControl = false, Kv = Kv, Cv = Cv, redeclare replaceable function valveCharacteristic = valveCharacteristic, responseEnable = responseEnable, bandwidth = bandwidth, dampingCoeff = dampingCoeff, p_init = p_init, Cd = Cd) annotation(
    Placement(transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.NJunction jB annotation(
    Placement(transformation(origin = {40, 60}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.NJunction jP annotation(
    Placement(transformation(origin = {-40, -60}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.NJunction jA annotation(
    Placement(transformation(origin = {-40, 60}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.NJunction jT annotation(
    Placement(transformation(origin = {40, -60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain gain(k = -1) if manualValveControl annotation(
    Placement(transformation(origin = {2, 50}, extent = {{8, -8}, {-8, 8}}, rotation = -0)));
equation
  connect(jA.port[1], portA) annotation(
    Line(points = {{-40, 60}, {-40, 80}}, color = {255, 0, 0}));
  connect(jP.port[1], portP) annotation(
    Line(points = {{-40, -60}, {-40, -80}}, color = {255, 0, 0}));
  connect(jB.port[1], portB) annotation(
    Line(points = {{40, 60}, {40, 80}}, color = {255, 0, 0}));
  connect(jT.port[1], portT) annotation(
    Line(points = {{40, -60}, {40, -80}}, color = {255, 0, 0}));
  connect(vPA.port_a, jP.port[2]) annotation(
    Line(points = {{-68, -10}, {-68, -60}, {-40, -60}}, color = {255, 0, 0}));
  connect(vPA.port_b, jA.port[2]) annotation(
    Line(points = {{-68, 10}, {-68, 60}, {-40, 60}}, color = {255, 0, 0}));
  connect(vBT.port_b, jT.port[2]) annotation(
    Line(points = {{64, -10}, {64, -60}, {40, -60}}, color = {255, 0, 0}));
  connect(vBT.port_a, jB.port[2]) annotation(
    Line(points = {{64, 10}, {64, 60}, {40, 60}}, color = {255, 0, 0}));
  connect(jT.port[3], vAT.port_b) annotation(
    Line(points = {{40, -60}, {-14, -60}, {-14, 0}, {-12, 0}}, color = {255, 0, 0}));
  connect(vAT.port_a, jA.port[3]) annotation(
    Line(points = {{-32, 0}, {-40, 0}, {-40, 60}}, color = {255, 0, 0}));
  connect(vPB.port_b, jB.port[3]) annotation(
    Line(points = {{30, 0}, {40, 0}, {40, 60}}, color = {255, 0, 0}));
  connect(vPB.port_a, jP.port[3]) annotation(
    Line(points = {{10, 0}, {8, 0}, {8, -60}, {-40, -60}}, color = {255, 0, 0}));
  connect(control, vBT.opening_input) annotation(
    Line(points = {{110, 0}, {72, 0}}, color = {0, 0, 127}));
  connect(control, vPA.opening_input) annotation(
    Line(points = {{110, 0}, {84, 0}, {84, 34}, {-52, 34}, {-52, 0}, {-60, 0}}, color = {0, 0, 127}));
  connect(control, gain.u) annotation(
    Line(points = {{110, 0}, {84, 0}, {84, 50}, {12, 50}}, color = {0, 0, 127}));
  connect(gain.y, vAT.opening_input) annotation(
    Line(points = {{-6, 50}, {-22, 50}, {-22, 8}}, color = {0, 0, 127}));
  connect(gain.y, vPB.opening_input) annotation(
    Line(points = {{-6, 50}, {-6, 22}, {20, 22}, {20, 8}}, color = {0, 0, 127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-74, -30}, {-74, 30}}, color = {0, 0, 0}), Line(points = {{-46, -30}, {-46, 30}}, color = {0, 0, 0}), Polygon(points = {{-74, 30}, {-80, 10}, {-68, 10}, {-74, 30}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-46, -30}, {-52, -10}, {-40, -10}, {-46, -30}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Line(points = {{74, -30}, {46, 30}}, color = {0, 0, 0}), Line(points = {{46, -30}, {74, 30}}, color = {0, 0, 0}), Polygon(points = {{74, -30}, {58, -14}, {70, -8}, {74, -30}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{74, 30}, {70, 6}, {58, 12}, {74, 30}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Line(points = {{-14, -30}, {-14, -12}}, color = {0, 0, 0}), Line(points = {{-20, -12}, {-8, -12}}, color = {0, 0, 0}), Line(points = {{-20, 12}, {-8, 12}}, color = {0, 0, 0}), Line(points = {{8, 12}, {20, 12}}, color = {0, 0, 0}), Line(points = {{8, -12}, {20, -12}}, color = {0, 0, 0}), Line(points = {{-14, 12}, {-14, 30}}, color = {0, 0, 0}), Line(points = {{14, 12}, {14, 30}}, color = {0, 0, 0}), Line(points = {{14, -30}, {14, -12}}, color = {0, 0, 0}), Line(points = {{-14, 30}, {-14, 60}, {-40, 60}, {-40, 80}}, color = {255, 0, 0}), Line(points = {{14, 30}, {14, 60}, {40, 60}, {40, 80}}, color = {255, 0, 0}), Line(points = {{-14, -30}, {-14, -60}, {-40, -60}, {-40, -80}}, color = {255, 0, 0}), Line(points = {{14, -30}, {14, -60}, {40, -60}, {40, -80}}, color = {255, 0, 0})}),
  Diagram(coordinateSystem(extent = {{-80, 100}, {140, -100}})));

end V4_3CC;
