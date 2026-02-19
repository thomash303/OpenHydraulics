within OpenHydraulics.Developed.Valves.BaseClasses;

model PressureOpening
  "Model representing the valve opening given the current pressure"
  
  // Importing and inheriting from the MSL
  import Modelica.Units.SI;
  import Modelica.Blocks.Interfaces;
  extends Modelica.Blocks.Interfaces.SO;
  
  // Valve characteristics
  parameter SI.Pressure p_crack = 5 "Valve cracking/relief pressure" annotation(Dialog(group = "Valve Characteristics"));
  parameter SI.Pressure p_open = 5.1 "Valve fully open pressure" annotation(Dialog(group = "Valve Characteristics"));
  
  // Variables
  SI.Pressure dp = u "Valve pressure differential"; 
  Real pressureOpening "Valve opening due to the pressure (to be input to the valve opening characteristic)";
  
  Interfaces.RealInput u "Input pressure differential" annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  MinMax minMax(uMin = uMin, uMax = uMax) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  
protected
  final parameter Real uMin = 0 "Lower limit of input signal";
  final parameter Real uMax = 1 "Upper limit of input signal";
  
equation
  minMax.u = pressureOpening;
  y = minMax.y;

  pressureOpening = (dp - p_crack)/(p_open - p_crack);

end PressureOpening;
