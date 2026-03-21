within OpenHydraulics.Developed.Lines;

model laminarPipeLoss "Laminar pipe pressure loss model using D'Arcy's equation and a laminar friction factor"

  // Importing from the MSL
  import Modelica.Units.SI;
  import Modelica.Constants.pi;
  
  // Inheriting from OpenHydraulics
  extends BaseClasses.FlowLossInterface;

  // Pipe sizing
  parameter SI.Diameter D(final min=0) = 0.01 "Pipe inner diameter (for computation of Re)" annotation (Dialog(tab="Sizing"));
  parameter SI.Length L(final min=0) "Length of pipe" annotation(Dialog(tab="Sizing"));
    
  // Diagnostic
  parameter Boolean check_Re = false "Check if flow is laminar (if not, loss model is not valid)" annotation(Evaluate=true, Dialog(tab="Advanced"));
  parameter SI.ReynoldsNumber Re_laminar = 2000 "Boundary of laminar flow regime" annotation (Dialog(tab="Advanced", enable=check_Re));

  // Re is used only for diagnostics, do not generate events --> noEvent
  SI.ReynoldsNumber Re=noEvent(abs(port_a.m_flow))*4/(pi*max(D, 1e-20)*system.mu) "Reynolds number";

  Types.HydraulicConductance Kh "Hydraulic Conductance of restriction";
  
  Real pipeEff "Pipe efficiency";

 
equation
  if check_Re and D>0 then
    assert(Re<=Re_laminar,"Flow is outside laminar region: Re = "+String(Re), AssertionLevel.warning);
  end if;

  // mass balance
  0 = port_a.m_flow + port_b.m_flow "Mass balance";
  
  Kh = pi*D^4*system.rho_ambient/(128*system.mu*L);
    
  if port_a.m_flow >= 0 then
    pipeEff = port_b.p / port_a.p;
  else
    pipeEff = port_a.p / port_b.p;
  end if;
    
algorithm
  port_a.m_flow := Kh*dp;

  annotation (Diagram(graphics={
        Line(points={{-100,0},{100,0}}, color={0,0,0}),
        Line(points={{-60,20},{-44,14},{-30,10},{-20,8},{-6,6},{6,6},{20,
              8},{30,10},{44,14},{60,20}}, color={0,0,0}),
        Line(points={{-60,-20},{-44,-14},{-30,-10},{-20,-8},{-6,-6},{6,-6},
              {20,-8},{30,-10},{44,-14},{60,-20}}, color={0,0,0})}),
                            Icon(coordinateSystem(preserveAspectRatio=false,
                   extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-100,0},{100,0}}, color={0,0,0}),
        Line(points={{-60,20},{-44,14},{-30,10},{-20,8},{-6,6},{6,6},{20,
              8},{30,10},{44,14},{60,20}}, color={0,0,0}),
        Line(points={{-60,-20},{-44,-14},{-30,-10},{-20,-8},{-6,-6},{6,-6},
              {20,-8},{30,-10},{44,-14},{60,-20}}, color={0,0,0})}));
end laminarPipeLoss;
