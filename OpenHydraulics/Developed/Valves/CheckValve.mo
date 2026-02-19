within OpenHydraulics.Developed.Valves;

model CheckValve "Model representing a check valve"
  // Inheriting from the OET
  extends BaseClasses.PartialIncompressibleValve;
  
  parameter Boolean manualValveControl = true "Enable manual valve control" annotation(
    choices(checkBox = true));
  parameter Boolean responseEnable = false "Enable dynamic (second-order) response" annotation(
    choices(checkBox = true));
  
  Blocks.Interfaces.RealInput opening(min = 0, max = 1) if manualValveControl "Manually controlled valve position in the range 0..1" annotation(
    Placement(transformation(origin = {0, 90}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {0, 80})));
  Modelica.Blocks.Continuous.SecondOrder secondOrderResponse(w = bandwidth*2*pi, D = dampingCoeff) if responseEnable annotation(
    Placement(transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}})));
    
protected
  Modelica.Blocks.Interfaces.RealOutput opening_response if responseEnable annotation(
    Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {68, 26}, extent = {{-10, -10}, {10, 10}})));
  
equation

  m_flow = homotopy(Aveff * sqrt(system.rho_ambient) * Utilities.regRoot2(dp,dp_small,1.0,0.0,use_yd0=true,yd0=0.0),Av*m_flow_nominal*dp/dp_nominal);
// Optional inputs to regRoot2 specify what the conditions are for x>0 and x<0, in that order. 1 enables normal flow is valve direction, 0 prevents reverse flow (needed for check valve only).
// homotopy can provide an initial guess to a nonlinear equation
  connect(secondOrderResponse.y, opening_response) annotation(
    Line(points = {{32, 0}, {70, 0}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-88, 44}, {88, -48}}), Line(points = {{-12, 0}, {-100, 0}}), Line(points = {{100, 0}, {29, 0}}), Ellipse(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-11, 16}, {21, -16}}), Line(points = {{-4, 30}, {29, 0}, {-4, -30}}), Text(extent = {{56, 40}, {94, 0}}, textString = "B"), Text(extent = {{-98, 40}, {-50, 0}}, textString = "A"), Text(origin = {-2, -116}, textColor = {0, 0, 255}, extent = {{-100, 80}, {100, 52}}, textString = "%name"), Line(points = {{-42, 10}, {-38, -10}, {-34, 10}, {-30, -10}, {-26, 10}, {-22, -10}, {-18, 10}, {-14, -10}, {-10, 10}})}));
end CheckValve;
