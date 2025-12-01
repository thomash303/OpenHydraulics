within OpenHydraulics.Developed.Valves;

model CheckValve "Model representing a check valve"
  // Inheriting from the OET
  extends BaseClasses.PartialIncompressibleValve;
equation

  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-88, 44}, {88, -48}}), Line(points = {{-12, 0}, {-100, 0}}), Line(points = {{100, 0}, {29, 0}}), Ellipse(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-11, 16}, {21, -16}}), Line(points = {{-4, 30}, {29, 0}, {-4, -30}}), Text(extent = {{56, 40}, {94, 0}}, textString = "B"), Text(extent = {{-98, 40}, {-50, 0}}, textString = "A"), Text(origin = {-2, -116}, textColor = {0, 0, 255}, extent = {{-100, 80}, {100, 52}}, textString = "%name"), Line(points = {{-42, 10}, {-38, -10}, {-34, 10}, {-30, -10}, {-26, 10}, {-22, -10}, {-18, 10}, {-14, -10}, {-10, 10}})}));
end CheckValve;
