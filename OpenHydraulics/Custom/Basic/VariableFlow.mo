within OpenHydraulics.Custom.Basic;

model VariableFlow "Controllable flow (independent of pressure)"

  extends Valves.BaseClasses.RestrictionInterface;

  // Importinf g from the MSL
  import Modelica.Blocks.Interfaces.RealInput;
  
  
  // the ports
  RealInput q_flow "Specified flow from A to B" annotation(
    Placement(transformation(origin = {0, -80}, extent = {{-20, 20}, {20, -20}}, rotation = 90)));

equation
// impose the desired flow
  port_a.m_flow = q_flow*system.Medium.density(p_a);
// mass balance
  0 = port_a.m_flow + port_b.m_flow "Mass balance";
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-20, -40}, {20, 40}}, color = {0, 0, 0}), Polygon(points = {{20, 40}, {4, 24}, {16, 18}, {20, 40}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid)}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-20, -40}, {20, 40}}, color = {0, 0, 0}), Polygon(points = {{20, 40}, {4, 24}, {16, 18}, {20, 40}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid)}));
end VariableFlow;
