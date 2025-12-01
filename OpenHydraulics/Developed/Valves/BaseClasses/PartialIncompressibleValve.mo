within OpenHydraulics.Developed.Valves.BaseClasses;

partial model PartialIncompressibleValve
  "Partial model representing an incompressible valve"
  
  // Make sure the equatioss are correct, and that the automatic relief valve mode is activated

  // Inheriting from the OET
  extends BaseClasses.PartialValve;

  // Importing and inheriting from the MSL
  import Modelica.Fluid.Types.CvTypes;
  import Modelica.Constants.pi;
  import Modelica.Units.SI;
  import Modelica.Fluid.Utilities;

  // Mass flow rate
  SI.MassFlowRate m_flow "Mass flow rate";
 
  // Valve characteristics
  Modelica.Units.SI.Area Aveff "Effective valve area"; 
  Real valveOpening "Valve opening ratio[0-1]";
  
protected
  // Nominal parameters
  parameter SI.Pressure dp_small = system.dp_small "Pressure difference region for enforcing continuous derivatives";
  parameter SI.MassFlowRate m_flow_nominal "Nominal mass flow rate";
  parameter SI.Pressure dp_nominal = 0.1 "Nominal pressure difference";
  
initial equation
  if CvData == CvTypes.OpPoint then
      m_flow_nominal = valveCharacteristic(opening_nominal) * Av * sqrt(system.rho_ambient) * Utilities.regRoot(dp_nominal, dp_small)
    "Determination of Av by the operating point";
  end if;

equation

  // Valve opening characteristic
  valveOpening = valveCharacteristic(opening_actual);
  Aveff = valveOpening * Av;
 
  // Mass flow
  m_flow = homotopy(Aveff * sqrt(system.rho_ambient) * Utilities.regRoot2(dp,dp_small,1.0,0.0,use_yd0=true,yd0=0.0),
                      valveOpening*system.m_flow_nominal*dp/dp_nominal);
  m_flow = port_a.m_flow;
annotation (
Documentation(info="<html>
<p>
Valve model according to the IEC 534/ISA S.75 standards for valve sizing, incompressible fluids.</p>

<p>
The parameters of this model are explained in detail in
<a href=\"modelica://Modelica.Fluid.Valves.BaseClasses.PartialValve\">PartialValve</a>
(the base model for valves).
</p>

<p>
This model assumes that the fluid has a low compressibility, which is always the case for liquids.
It can also be used with gases, provided that the pressure drop is lower than 0.2 times the absolute pressure at the inlet, so that the fluid density does not change much inside the valve.</p>

<p>
If <code>checkValve</code> is false, the valve supports reverse flow, with a symmetric flow characteristic curve. Otherwise, reverse flow is stopped (check valve behaviour).
</p>

<p>
The treatment of parameters <strong>Kv</strong> and <strong>Cv</strong> is
explained in detail in the
<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.ValveCharacteristics\">User's Guide</a>.
</p>

</html>",
  revisions="<html>
<ul>
<li><em>2 Nov 2005</em>
by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
   Adapted from the ThermoPower library.</li>
</ul>
</html>"));
end PartialIncompressibleValve;
