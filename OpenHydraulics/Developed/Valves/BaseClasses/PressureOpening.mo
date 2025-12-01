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
  parameter Boolean reliefValveEnable = false "Enable relief valve" annotation(Dialog(group = "Valve Characteristics"));
  
  SI.Pressure dp "Valve pressure differential"; 
  
  Real pressureOpening "Valve opening due to the pressure (to be input to the valve opening characteristic)";
  
  Interfaces.RealInput u if not reliefValveEnable "Input pressure differential" annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  
protected
  final parameter Real uMin = 0 "Lower limit of input signal";
  final parameter Real uMax = 1 "Upper limit of input signal";
  
  Real y_int;
  
equation
  if not reliefValveEnable then
    dp = u;
  end if;

  pressureOpening = (dp - p_crack) / (p_open - p_crack);
  
  // Enforcing upper threshold at zero (dp <= p_crack)
  y_int = smooth(1, noEvent(if pressureOpening <= p_crack then uMin else dp));  
  
  // Enforcing upper threshold at one (dp >= p_open)
  y = smooth(1, noEvent(if pressureOpening >= p_open then uMax else y_int));  
  
  
  

end PressureOpening;
