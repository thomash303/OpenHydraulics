within OpenHydraulics.Custom.Media.BaseClasses;

partial model PartialMedium "Partial medium model"
  
  // Importing from the MSL
  import Modelica.Units.SI; 
  import Modelica.Icons.Function;
  
  constant String mediumName = "unusablePartialMedium" "Name of the medium";
  constant SI.Temperature Toperating = 293.15 "Operating temperature of the medium";
  constant SI.Temperature T_ambient = 298.15 "Reference temperature of Medium: default 25 deg Celsius";
  constant SI.AbsolutePressure p_ambient = 101325 "Reference pressure of the medium";
  constant SI.Density rho_nom "nominal medium density" annotation(Dialog(group = "Medium")); 

  replaceable function density "Return density as a function of p and T"
    extends Function;
    input SI.AbsolutePressure p;
    output SI.Density rho;
  end density;

  replaceable function dynamicViscosity
    extends Function;
    input SI.AbsolutePressure p;
    output SI.DynamicViscosity eta;
  end dynamicViscosity;

  replaceable function approxBulkModulus "Bulk modulus to be used in approximate calculation; otherwise use density"
    extends Function;
    input SI.AbsolutePressure p;
    output SI.BulkModulus B;
  algorithm
    B := if (density(p + 1000) == density(p)) then 1e9 else 1000/(density(p + 1000)/density(p) - 1);
  end approxBulkModulus;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(extent = {{-74, 20}, {6, -60}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-34, 80}, {-70, -2}, {2, -2}, {-34, 80}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid), Line(points = {{2, -2}, {-34, 80}, {-70, -2}}, color = {0, 0, 0}), Ellipse(extent = {{-6, 34}, {74, -46}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{34, 94}, {-2, 12}, {70, 12}, {34, 94}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid), Line(points = {{70, 12}, {34, 94}, {-2, 12}}, color = {0, 0, 0}), Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}), Text(extent = {{0, -60}, {0, -100}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.VerticalCylinder, textString = "%name")}));
end PartialMedium;
