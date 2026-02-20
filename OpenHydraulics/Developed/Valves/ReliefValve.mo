within OpenHydraulics.Developed.Valves;

model ReliefValve
  "Model representing a relief valve"
  
    // Valve characteristic parameters
  parameter SI.Pressure p_relief = 1e7 "Valve relief pressure" annotation(
    Dialog(group = "Valve Characteristics"));

  // Inheriting from the OET
  extends BaseClasses.PartialIncompressibleValve(final manualValveControl=false, final p_crack = p_relief);
  
  // Importing from the MSL
  import Modelica.Fluid.Utilities.regRoot2;

equation
  // Valve opening characteristic
  valveOpening = valveCharacteristic(opening);
  Aveff = valveOpening * Av;

  m_flow = homotopy(Aveff * sqrt(system.rho_ambient) * regRoot2(dp,dp_small),Av*m_flow_nominal*dp/dp_nominal);
  
  // Optional inputs to regRoot2 specify what the conditions are for x>0 and x<0, in that order. Both forward and reverse flows are permitted. Could optionally include the pressure dependent densities as the fallback for forward and reverse flows.
  // homotopy can provide an initial guess to a nonlinear equation
    dp = pressureOpening.u;
    opening = pressureOpening.y;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -60}}), Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-40, 40}, {40, -40}}), Line(points = {{-40, 0}, {-100, 0}}), Line(points = {{100, 0}, {40, 0}}), Line(points = {{-40, -20}, {40, -20}}), Polygon(fillPattern = FillPattern.Solid, points = {{40, -20}, {24, -16}, {24, -24}, {40, -20}}), Line(points = {{0, -40}, {0, -60}, {-70, -60}, {-70, 0}}, pattern = LinePattern.Dot), Line(points = {{20, 40}, {-20, 48}, {20, 56}, {-20, 64}, {20, 72}, {-20, 80}, {20, 80}}), Line(points = {{-42, 74}, {36, 48}}), Polygon(fillPattern = FillPattern.Solid, points = {{-42, 74}, {-30, 74}, {-32, 68}, {-42, 74}}), Text(extent = {{60, 40}, {90, 0}}, textString = "B"), Text(extent = {{-98, 40}, {-50, 0}}, textString = "A"), Text(textColor = {0, 0, 255}, extent = {{0, -60}, {0, -90}}, textString = "%name")}));
end ReliefValve;
