within OpenHydraulics.Developed.Valves.BaseClasses;

model MinMax
  import Modelica.Units.SI;
  import Modelica.Blocks.Interfaces;
  extends Modelica.Blocks.Interfaces.SISO;
  // Minimum and maximum parameters
  parameter Real uMin = 0 "Lower limit of input signal";
  parameter Real uMax = 1 "Upper limit of input signal";
equation
  y = smooth(2, min(uMax, max(uMin, u)));
// Continuous second derivatives and no events triggered
  annotation(
    Documentation(info = "<html>
<p>
The block passes its input signal as output signal
as long as the input is above uMin and below uMax. If this is not the case,
y=uMin or uMax, respectively, is passed as output.
</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{0, -90}, {0, 68}}, color = {192, 192, 192}), Polygon(lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}), Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), Polygon(lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{90, 0}, {68, -8}, {68, 8}, {90, 0}}), Line(points = {{-80, -70}, {-50, -70}, {50, 70}, {78, 70}}), Text(extent = {{-150, -150}, {150, -110}}, textString = "uMin=%uMin"), Text(textColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{0, -60}, {0, 50}}, color = {192, 192, 192}), Polygon(points = {{0, 60}, {-5, 50}, {5, 50}, {0, 60}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-60, 0}, {50, 0}}, color = {192, 192, 192}), Polygon(points = {{60, 0}, {50, -5}, {50, 5}, {60, 0}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-50, -40}, {-30, -40}, {30, 40}, {50, 40}}), Text(extent = {{46, -6}, {68, -18}}, textColor = {128, 128, 128}, textString = "u"), Text(extent = {{-30, 70}, {-5, 50}}, textColor = {128, 128, 128}, textString = "y"), Text(extent = {{-58, -54}, {-28, -42}}, textColor = {128, 128, 128}, textString = "uMin"), Text(extent = {{26, 40}, {66, 56}}, textColor = {128, 128, 128}, textString = "uMax")}));
end MinMax;
