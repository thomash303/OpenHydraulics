within OpenHydraulics.Developed.Valves;

model ReliefValve
  "Model representing a relief valve"

  // Inheriting from the OET
  extends BaseClasses.PartialIncompressibleValve(reliefValveEnable = true);



equation

  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -60}}), Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-40, 40}, {40, -40}}), Line(points = {{-40, 0}, {-100, 0}}), Line(points = {{100, 0}, {40, 0}}), Line(points = {{-40, -20}, {40, -20}}), Polygon(fillPattern = FillPattern.Solid, points = {{40, -20}, {24, -16}, {24, -24}, {40, -20}}), Line(points = {{0, -40}, {0, -60}, {-70, -60}, {-70, 0}}, pattern = LinePattern.Dot), Line(points = {{20, 40}, {-20, 48}, {20, 56}, {-20, 64}, {20, 72}, {-20, 80}, {20, 80}}), Line(points = {{-42, 74}, {36, 48}}), Polygon(fillPattern = FillPattern.Solid, points = {{-42, 74}, {-30, 74}, {-32, 68}, {-42, 74}}), Text(extent = {{60, 40}, {90, 0}}, textString = "B"), Text(extent = {{-98, 40}, {-50, 0}}, textString = "A"), Text(textColor = {0, 0, 255}, extent = {{0, -60}, {0, -90}}, textString = "%name")}));
end ReliefValve;
