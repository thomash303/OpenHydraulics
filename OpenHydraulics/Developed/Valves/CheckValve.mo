within OpenHydraulics.Developed.Valves;

model CheckValve "Model representing a check valve"
  // Inheriting from the OET
  extends BaseClasses.PartialIncompressibleValve;
  
  // Importing from the MSL
  import Modelica.Blocks.Interfaces;
  import Modelica.Constants.pi;
  import Modelica.Fluid.Utilities.regRoot2;
  
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
  
  Interfaces.RealInput opening_input(min = 0, max = 1) if manualValveControl "Manually controlled valve position in the range 0..1" annotation(
    Placement(transformation(origin = {0, 90}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {0, 80})));
  Modelica.Blocks.Continuous.SecondOrder secondOrderResponse(w = bandwidth*2*pi, D = dampingCoeff) if responseEnable and manualValveControl annotation(
    Placement(transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}})));
  BaseClasses.MinMax minMax if filterEnable and manualValveControl annotation(
    Placement(transformation(origin = {24, 40}, extent = {{-10, -10}, {10, 10}})));
     
protected
  Interfaces.RealOutput opening_response if responseEnable and manualValveControl annotation(
    Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {68, 26}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealOutput opening_filter if filterEnable and manualValveControl annotation(
    Placement(transformation(origin = {70, 40}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {66, -2}, extent = {{-10, -10}, {10, 10}})));
equation
  // Valve opening characteristic
  valveOpening = valveCharacteristic(opening);
  Aveff = valveOpening * Av;

// For mass flow equation
// Optional inputs to regRoot2 specify what the conditions are for x>0 and x<0, in that order. 1 enables normal flow is valve direction, 0 prevents reverse flow (needed for check valve only).
// homotopy can provide an initial guess to a nonlinear equation
  
  // Declaration cases
  // Case 1.0: Input used directly as valve opening
  if manualValveControl  then
    m_flow = homotopy(Aveff * sqrt(system.rho_ambient) * regRoot2(dp,dp_small,1.0,0.0,use_yd0=true,yd0=0.0),Av*m_flow_nominal*dp/dp_nominal);
    
    if not (responseEnable or filterEnable) then
      opening = opening_input;
    // Case 1.1: Input used with filter only or with filter and response (through connects)
    elseif manualValveControl and filterEnable then
      opening = opening_filter;
    // Case 1.2: Input used with response only
    elseif manualValveControl and responseEnable and not filterEnable then
      opening = opening_response; 
    // Case 1.3: Input used with filter and response
   // elseif manualValveControl and filterEnable and responseEnable then
     // opening = opening_response;
     
    end if;
  // Case 2: Opening calculated from pressureOpening
  else
    dp = pressureOpening.u;
    opening = pressureOpening.y;
    m_flow = homotopy(Aveff * sqrt(system.rho_ambient) * regRoot2(dp,dp_small,1.0,0.0,use_yd0=true,yd0=0.0),Av*m_flow_nominal*dp/dp_nominal);
  end if;
  
  connect(secondOrderResponse.y, opening_response) annotation(
    Line(points = {{32, 0}, {70, 0}}, color = {0, 0, 127}));
  connect(minMax.y, opening_filter) annotation(
    Line(points = {{36, 40}, {70, 40}}, color = {0, 0, 127}));
  connect(opening_input, minMax.u) annotation(
    Line(points = {{0, 90}, {0, 40}, {12, 40}}, color = {0, 0, 127}));
  connect(secondOrderResponse.u, opening_input) annotation(
    Line(points = {{8, 0}, {0, 0}, {0, 90}}, color = {0, 0, 127}));
  connect(opening_filter, secondOrderResponse.u) annotation(
    Line(points = {{70, 40}, {46, 40}, {46, 20}, {8, 20}, {8, 0}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-88, 44}, {88, -48}}), Line(origin = {0.120097, 0.240193}, points = {{-30, 0}, {-100, 0}}), Line(points = {{100, 0}, {9, 0}}), Ellipse(origin = {-10, 0},fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-11, 16}, {21, -16}}), Line(origin = {-0.776849, 0.100295}, rotation = 180, points = {{-4, 30}, {29, 0}, {-4, -30}}), Text(extent = {{56, 40}, {94, 0}}, textString = "B"), Text(extent = {{-98, 40}, {-50, 0}}, textString = "A"), Text(origin = {-2, -116}, textColor = {0, 0, 255}, extent = {{-100, 80}, {100, 52}}, textString = "%name"), Line(origin = {51.5245, 1.75396}, points = {{-42, 10}, {-38, -10}, {-34, 10}, {-30, -10}, {-26, 10}, {-22, -10}, {-18, 10}, {-14, -10}, {-10, 10}})}));
end CheckValve;
