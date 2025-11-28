within OpenHydraulics.Developed.Systems;

model System
  "System environment for fluid models"
  
  // Importing from the MSL
  import Modelica.Units.SI;
  import Modelica.Constants.g_n;
  
  // Medium model
  replaceable package Medium = Media.GenericOil constrainedby Media.BaseClasses.PartialMedium "Medium model for default start values" annotation(
    choicesAllMatching = true,
    Dialog(group = "Medium"));
    
  // Medium parameters 
  final constant SI.Temperature T_ambient_med = Medium.T_ambient_med "Reference temperature of Medium: default 25 deg Celsius";
  final constant SI.AbsolutePressure p_ambient_med = Medium.T_ambient_med "Reference pressure of the medium";
  final constant SI.Density rho_ambient = Medium.rho_ambient "Reference density of the medium";
  final constant SI.BulkModulus beta = Medium.beta "Effective bulk modulus";
  final constant SI.DynamicViscosity mu = Medium.mu "Dynamic viscosity";
    
  // Ambient environment parameters
  parameter SI.AbsolutePressure p_ambient = 101325 "Default ambient pressure" annotation(
    Dialog(group = "Environment"));
  parameter SI.Temperature T_ambient = 293.15 "Default ambient temperature" annotation(
    Dialog(group = "Environment"));
  constant SI.Acceleration g = g_n "Constant gravity acceleration";
  
  // Initialization
  parameter SI.MassFlowRate m_flow_start = 0 "Default start value for mass flow rates" annotation(
    Dialog(tab = "Initialization"));
  parameter SI.AbsolutePressure p_start = p_ambient "Default start value for pressures" annotation(
    Dialog(tab = "Initialization"));
  parameter SI.Temperature T_start = T_ambient "Default start value for temperatures" annotation(
    Dialog(tab = "Initialization"));
  
  
  // Advanced
  parameter Boolean use_eps_Re = false "= true to determine turbulent region automatically using Reynolds number" annotation(
    Evaluate = true,
    Dialog(tab = "Advanced"));
  parameter SI.MassFlowRate m_flow_nominal = if use_eps_Re then 1 else 1e2*m_flow_small "Default nominal mass flow rate" annotation(
    Dialog(tab = "Advanced", enable = use_eps_Re));
  parameter Real eps_m_flow(min = 0) = 1e-4 "Regularization of zero flow for |m_flow| < eps_m_flow*m_flow_nominal" annotation(
    Dialog(tab = "Advanced", enable = use_eps_Re));
  parameter SI.AbsolutePressure dp_small(min = 0) = 1 "Default small pressure drop for regularization of laminar and zero flow" annotation(
    Dialog(tab = "Advanced", group = "Classic", enable = not use_eps_Re));
  parameter SI.MassFlowRate m_flow_small(min = 0) = 1e-2 "Default small mass flow rate for regularization of laminar and zero flow" annotation(
    Dialog(tab = "Advanced", group = "Classic", enable = not use_eps_Re));
  annotation(
    defaultComponentName = "system",
    defaultComponentPrefixes = "inner",
    missingInnerMessage = "
Your model is using an outer \"system\" component but
an inner \"system\" component is not defined.
For simulation drag Modelica.Fluid.System into your model
to specify system properties.",
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-150, 150}, {150, 110}}, textColor = {0, 0, 255}, textString = "%name"), Line(points = {{-86, -30}, {82, -30}}), Line(points = {{-82, -68}, {-52, -30}}), Line(points = {{-48, -68}, {-18, -30}}), Line(points = {{-14, -68}, {16, -30}}), Line(points = {{22, -68}, {52, -30}}), Line(points = {{74, 84}, {74, 14}}), Polygon(points = {{60, 14}, {88, 14}, {74, -18}, {60, 14}}, fillPattern = FillPattern.Solid), Text(extent = {{16, 20}, {60, -18}}, textString = "g"), Text(extent = {{-90, 82}, {74, 50}}, textString = "defaults"), Line(points = {{-82, 14}, {-42, -20}, {2, 30}}, thickness = 0.5), Ellipse(extent = {{-10, 40}, {12, 18}}, pattern = LinePattern.None, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid)}),
    Documentation(info = "<html>
<p>
 A system component is needed in each fluid model to provide system-wide settings, such as ambient conditions and overall modeling assumptions.
 The system settings are propagated to the fluid models using the inner/outer mechanism.
</p>
<p>
 A model should never directly use system parameters.
 Instead a local parameter should be declared, which uses the global setting as default.
 The only exceptions are:</p>
 <ul>
  <li>the gravity system.g,</li>
  <li>the global system.eps_m_flow, which is used to define a local m_flow_small for the local m_flow_nominal:
      <blockquote><pre>m_flow_small = system.eps_m_flow*m_flow_nominal</pre></blockquote>
  </li>
 </ul>
<p>
 The global system.m_flow_small and system.dp_small are classic parameters.
 They do not distinguish between laminar flow and regularization of zero flow.
 Absolute small values are error prone for models with local nominal values.
 Moreover dp_small can generally be obtained automatically.
 Consider using the new system.use_eps_Re = true (see Advanced tab).
</p>
</html>"));
end System;
