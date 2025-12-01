within OpenHydraulics.Developed.Valves.BaseClasses;

partial model PartialValve "Partial model representing a partial valve"
  // Need to ensure all filter blocks are conditonal delcraration and relief valve mode is activated
  // Inheriting from the OET
  extends Interfaces.HorizontalTwoPort;
  // Importing from the MSL
  import Modelica.Fluid.Types.CvTypes;
  import Modelica.Units.SI;
  import Modelica.Blocks;
  // Relief valveCharacteristic
  parameter Boolean reliefValveEnable = false "Enable relief valve" annotation(
    choices(checkBox = true));
  // Valve characteristic parameters
  parameter SI.Pressure p_crack = 5 "Valve cracking/relief pressure";
  parameter SI.Pressure p_open = 5.1 "Valve fully open pressure";
  parameter CvTypes CvData = Modelica.Fluid.Types.CvTypes.OpPoint "Selection of flow coefficient" annotation(
    Dialog(group = "Flow coefficient"));
  // Av (default)
  parameter SI.Area Av(fixed = CvData == CvTypes.Av, start = system.m_flow_nominal/(sqrt(system.rho_ambient*system.dp_small))*valveCharacteristic(opening_nominal)) "Av (metric) flow coefficient" annotation(
    Dialog(group = "Flow coefficient", enable = (CvData == Modelica.Fluid.Types.CvTypes.Av)));
  // Kv (metric)
  parameter Real Kv = 0 "Kv (metric) flow coefficient [m3/h]" annotation(
    Dialog(group = "Flow coefficient", enable = (CvData == Modelica.Fluid.Types.CvTypes.Kv)));
  // Cv (imperial)
  parameter Real Cv = 0 "Cv (US) flow coefficient [USG/min]" annotation(
    Dialog(group = "Flow coefficient", enable = (CvData == Modelica.Fluid.Types.CvTypes.Cv)));
  // Nominal
  parameter Real opening_nominal(min = 0, max = 1) = 1 "Nominal opening" annotation(
    Dialog(group = "Nominal operating point", enable = (CvData == Modelica.Fluid.Types.CvTypes.OpPoint)));
  // Filtered opening parameters
  parameter Boolean filteredOpening = false "= true, if opening is filtered with a 2nd order CriticalDamping filter" annotation(
    Dialog(group = "Filtered opening"),
    choices(checkBox = true));
  parameter SI.Time riseTime = 1 "Rise time of the filter (time to reach 99.6 % of an opening step)" annotation(
    Dialog(group = "Filtered opening", enable = filteredOpening));
  parameter Real leakageOpening(min = 0, max = 1) = 1e-3 "The opening signal is limited by leakageOpening (to improve the numerics)" annotation(
    Dialog(group = "Filtered opening", enable = filteredOpening));
  parameter Boolean checkValve = false "Reverse flow stopped" annotation(
    Dialog(tab = "Assumptions"));
  replaceable function valveCharacteristic = ValveCharacteristics.linear constrainedby ValveCharacteristics.baseFun "Valve flow characteristic" annotation(
     choicesAllMatching = true);
  // Conversion factors to Av
  constant SI.Area Kv2Av = 27.7e-6 "Conversion factor";
  constant SI.Area Cv2Av = 24.0e-6 "Conversion factor";
  // Filtered opening models
  Blocks.Interfaces.RealInput opening(min = 0, max = 1) if not reliefValveEnable "Valve position in the range 0..1" annotation(
    Placement(transformation(origin = {0, 90}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {0, 80})));
  Blocks.Interfaces.RealOutput opening_filtered if filteredOpening "Filtered valve position in the range 0..1" annotation(
    Placement(transformation(extent = {{60, 40}, {80, 60}}), iconTransformation(extent = {{60, 50}, {80, 70}})));
  Blocks.Continuous.Filter filter(order = 2, f_cut = 5/(2*Modelica.Constants.pi*riseTime)) if filteredOpening annotation(
    Placement(transformation(extent = {{34, 44}, {48, 58}})));
  PressureOpening pressureOpening(dp = dp, p_crack = p_crack, p_open = p_open, reliefValveEnable = reliefValveEnable) if reliefValveEnable annotation(
    Placement(transformation(origin = {14, -14}, extent = {{-10, -10}, {10, 10}})));
protected
  Blocks.Interfaces.RealOutput opening_actual annotation(
    Placement(transformation(extent = {{60, 10}, {80, 30}})));
  MinLimiter minLimiter(uMin = leakageOpening) if filteredOpening annotation(
    Placement(transformation(extent = {{10, 44}, {24, 58}})));
initial equation
  if CvData == CvTypes.Kv then
    Av = Kv*Kv2Av "Unit conversion";
  elseif CvData == CvTypes.Cv then
    Av = Cv*Cv2Av "Unit conversion";
  end if;
equation
// Mass balance
  0 = port_a.m_flow + port_b.m_flow "Mass balance";
  connect(filter.y, opening_filtered) annotation(
    Line(points = {{48.7, 51}, {60, 51}, {60, 50}, {70, 50}}, color = {0, 0, 127}));
// Relief valve
  if reliefValveEnable then
    connect(pressureOpening.y, opening_actual);
// Manually controlled valve opening (including check valve) w/ filter
  elseif filteredOpening then
    connect(filter.y, opening_actual);
// Manually controlled valve opening (including check valve)
  else
    connect(opening, opening_actual);
  end if;
  connect(minLimiter.y, filter.u) annotation(
    Line(points = {{24.7, 51}, {32.6, 51}}, color = {0, 0, 127}));
  connect(minLimiter.u, opening) annotation(
    Line(points = {{8.6, 51}, {0, 51}, {0, 90}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{0, 52}, {0, 0}}), Rectangle(fillPattern = FillPattern.Solid, extent = {{-20, 60}, {20, 52}}), Polygon(lineColor = {255, 255, 255}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, points = DynamicSelect({{-100, 0}, {100, 0}, {100, 0}, {0, 0}, {-100, 0}, {-100, 0}}, {{-100, (50*opening_actual)}, {-100, (50*opening_actual)}, {100, -(50*opening)}, {100, (50*opening_actual)}, {0, 0}, {-100, -(50*opening_actual)}, {-100, (50*opening)}})), Ellipse(visible = filteredOpening, lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-40, 94}, {40, 14}}), Line(visible = filteredOpening, points = {{-20, 25}, {-20, 63}, {0, 41}, {20, 63}, {20, 25}}, thickness = 0.5), Line(visible = filteredOpening, points = {{40, 60}, {60, 60}}, color = {0, 0, 127})}),
    Documentation(info = "<html>
<p>This is the base model for the <code>ValveIncompressible</code>, <code>ValveVaporizing</code>, and <code>ValveCompressible</code> valve models. The model is based on the IEC 534 / ISA S.75 standards for valve sizing.</p>
<p>The model optionally supports reverse flow conditions (assuming symmetrical behaviour) or check valve operation, and has been suitably regularized, compared to the equations in the standard, in order to avoid numerical singularities around zero pressure drop operating conditions.</p>
<p>The model assumes adiabatic operation (no heat losses to the ambient); changes in kinetic energy
from inlet to outlet are neglected in the energy balance.</p>
<p><strong>Modelling options</strong></p>
<p>The following options are available to specify the valve flow coefficient in fully open conditions:</p>
<ul><li><code>CvData = Modelica.Fluid.Types.CvTypes.Av</code>: the flow coefficient is given by the metric <code>Av</code> coefficient (m^2).</li>
<li><code>CvData = Modelica.Fluid.Types.CvTypes.Kv</code>: the flow coefficient is given by the metric <code>Kv</code> coefficient (m^3/h).</li>
<li><code>CvData = Modelica.Fluid.Types.CvTypes.Cv</code>: the flow coefficient is given by the US <code>Cv</code> coefficient (USG/min).</li>
<li><code>CvData = Modelica.Fluid.Types.CvTypes.OpPoint</code>: the flow is computed from the nominal operating point specified by <code>p_nominal</code>, <code>dp_nominal</code>, <code>m_flow_nominal</code>, <code>rho_nominal</code>, <code>opening_nominal</code>.</li>
</ul>
<p>The nominal pressure drop <code>dp_nominal</code> must always be specified; to avoid numerical singularities, the flow characteristic is modified for pressure drops less than <code>b*dp_nominal</code> (the default value is 1% of the nominal pressure drop). Increase this parameter if numerical problems occur in valves with very low pressure drops.</p>
<p>If <code>checkValve</code> is true, then the flow is stopped when the outlet pressure is higher than the inlet pressure; otherwise, reverse flow takes place. Use this option only when needed, as it increases the numerical complexity of the problem.</p>
<p>The valve opening characteristic <code>valveCharacteristic</code>, linear by default, can be replaced by any user-defined function. Quadratic and equal percentage with customizable rangeability are already provided by the library. The characteristics for constant port_a.p and port_b.p pressures with continuously changing opening are shown in the next two figures:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Valves/BaseClasses/ValveCharacteristics1a.png\"
 alt=\"ValveCharacteristics1a.png\"><br>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Valves/BaseClasses/ValveCharacteristics1b.png\"
 alt=\"Components/ValveCharacteristics1b.png\">
</blockquote>

<p>
The treatment of parameters <strong>Kv</strong> and <strong>Cv</strong> is
explained in detail in the
<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.ValveCharacteristics\">User's Guide</a>.
</p>

<p>
With the optional parameter \"filteredOpening\", the opening can be filtered with a
<strong>second order, criticalDamping</strong> filter so that the
opening demand is delayed by parameter \"riseTime\". The filtered opening is then available
via the output signal \"opening_filtered\" and is used to control the valve equations.
This approach approximates the driving device of a valve. The \"riseTime\" parameter
is used to compute the cut-off frequency of the filter by the equation: f_cut = 5/(2*pi*riseTime).
It defines the time that is needed until opening_filtered reaches 99.6 % of
a step input of opening. The icon of a valve changes in the following way
(left image: filteredOpening=false, right image: filteredOpening=true):
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Valves/BaseClasses/FilteredValveIcon.png\"
 alt=\"FilteredValveIcon.png\">
</blockquote>

<p>
If \"filteredOpening = <strong>true</strong>\", the input signal \"opening\" is limited
by parameter <strong>leakageOpening</strong>, i.e., if \"opening\" becomes smaller as
\"leakageOpening\", then \"leakageOpening\" is used instead of \"opening\" as input
for the filter. The reason is that \"opening=0\" might structurally change the equations of the
fluid network leading to a singularity. If a small leakage flow is introduced
(which is often anyway present in reality), the singularity might be avoided.
</p>

<p>
In the next figure, \"opening\" and \"filtered_opening\" are shown in the case that
filteredOpening = <strong>true</strong>, riseTime = 1 s, and leakageOpening = 0.02.
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Valves/BaseClasses/ValveFilteredOpening.png\"
 alt=\"ValveFilteredOpening.png\">
</blockquote>

</html>", revisions = "<html>
<ul>
<li><em>Sept. 5, 2010</em>
by <a href=\"mailto:martin.otter@dlr.de\">Martin Otter</a>:<br>
Optional filtering of opening introduced, based on a proposal
from Mike Barth (Universitaet der Bundeswehr Hamburg) +
Documentation improved.</li>
<li><em>2 Nov 2005</em>
by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
   Adapted from the ThermoPower library.</li>
</ul>
</html>"));
end PartialValve;
