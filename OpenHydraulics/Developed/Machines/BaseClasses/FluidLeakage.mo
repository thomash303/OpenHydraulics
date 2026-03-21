within OpenHydraulics.Developed.Machines.BaseClasses;

model FluidLeakage
  "McCandlish and Dory motor hydraulic loss model"
  
  // Inheriting from the OET
  extends Interfaces.HorizontalTwoPort;
  
  // Importing from the MSL
  import Modelica.Blocks.Interfaces.RealInput;
  
  parameter Real Cs = 0 "Slip coefficient" annotation(
    Dialog(group = "Friction"));
  
  parameter SI.Volume Dmax = 1e-4 "Maximum pump displacement";
  parameter SI.DynamicViscosity mu = 0.036 "Dynamic Viscosity of liquid";
  
  
  parameter Types.HydraulicPort portSelect = Types.HydraulicPort.port_P "Select port of motor where leakage model is connected";
  
  SI.Pressure dpMot "Pressure across the motor";
  
equation

  // Mass flow
  if (portSelect == Types.HydraulicPort.port_P and dpMot > 0) or (portSelect == Types.HydraulicPort.port_T and dpMot < 0) then
    port_a.m_flow = 0;
  else
    port_a.m_flow = Cs * Dmax / mu * abs(dpMot);
  end if;
  
  // Mass balance
  0 = port_a.m_flow + port_b.m_flow "Mass balance";



  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
            {{-100,-100},{100,100}}), graphics={
        Line(points={{-100,0},{100,0}}, color={0,0,0}),
        Line(points={{-60,20},{-44,14},{-30,10},{-20,8},{-6,6},{6,6},{20,
              8},{30,10},{44,14},{60,20}}, color={0,0,0}),
        Line(points={{-60,-20},{-44,-14},{-30,-10},{-20,-8},{-6,-6},{6,-6},
              {20,-8},{30,-10},{44,-14},{60,-20}}, color={0,0,0})}),
                            Icon(coordinateSystem(preserveAspectRatio=false,
                   extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-80,60},{80,-40}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-100,0},{100,0}}, color={0,0,0}),
        Line(points={{-60,20},{-44,14},{-30,10},{-20,8},{-6,6},{6,6},{20,
              8},{30,10},{44,14},{60,20}}, color={0,0,0}),
        Line(points={{-60,-20},{-44,-14},{-30,-10},{-20,-8},{-6,-6},{6,-6},
              {20,-8},{30,-10},{44,-14},{60,-20}}, color={0,0,0}),
        Text(
          extent={{-106,54},{-64,14}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="A"),
        Text(
          extent={{64,54},{106,14}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="B"),
        Text(
          extent={{100,-20},{-100,-60}},
          lineColor={0,0,255},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          textString="%name")}));

end FluidLeakage;
