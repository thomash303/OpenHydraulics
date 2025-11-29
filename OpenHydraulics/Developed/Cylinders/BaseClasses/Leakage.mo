within OpenHydraulics.Developed.Cylinders.BaseClasses;

model Leakage
  "Model representing cylinder Leakage"
  
  // Inheriting from the OET
  extends Interfaces.HorizontalTwoPort;
  
  parameter Types.HydraulicLeakage CLeakage = 0 "Leakage coefficient";
  
equation

  // Mass balance
  0 = port_a.m_flow + port_b.m_flow "Mass balance";

  // Mass flow
  port_a.m_flow = CLeakage * dp;

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
end Leakage;
