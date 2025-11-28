within OpenHydraulics.Custom.Valves;

model checkValve
extends ValveIncompressible;

equation
 annotation (

    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-88,44},{88,-48}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-12,0},{-100,0}}, color={0,0,0}),
        Line(points={{100,0},{29,0}}, color={0,0,0}),
        Ellipse(
          extent={{-11,16},{21,-16}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-4,30},{29,0},{-4,-30}}, color={0,0,0}),
        Text(
          extent={{56,40},{94,0}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="B"),
        Text(
          extent={{-98,40},{-50,0}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="A"),
        Text(
          extent={{-100,80},{100,52}},
          lineColor={0,0,255},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Line(points={{-42,10},{-38,-10},{-34,10},{-30,-10},{-26,10},{-22,-10},
              {-18,10},{-14,-10},{-10,10}}, color={0,0,0})}));
end checkValve;
