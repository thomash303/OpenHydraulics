within OpenHydraulics.Developed.Cylinders.BaseClasses;

model StribeckFriction "Stribeck friction"
  // Importing and inheriting from the MSL
  import Modelica.Units.SI;
  extends Modelica.Mechanics.Translational.Interfaces.PartialCompliantWithRelativeStates;
  extends Modelica.Mechanics.Translational.Interfaces.PartialFriction;
  // Relative kinematics
  SI.Acceleration a_rel(start = 0) "Relative acceleration";
  // Friction forces
  parameter SI.TranslationalDampingConstant Cv = 1 "Viscous damping coefficient" annotation(
    Dialog(group = "Friction"));
  //SI.Force f_v(start = 0) "Viscous friction force";
  parameter SI.Force f_c(start = 5) "Coulomb friction force" annotation(
    Dialog(group = "Friction"));
  parameter SI.Velocity Cst(start = 0.5) "Stribeck characteristic velocity" annotation(
    Dialog(group = "Friction"));
  parameter SI.Force f_st(start = 10) "Stribeck friction force" annotation(
    Dialog(group = "Friction"));

equation
// Relative acceleration
  a_rel = der(v_rel);
  v_relfric = v_rel;
  a_relfric = a_rel;
  
  f0 = (f_c + f_st); // Variables defined in partial friction, defined similar to MassWithStopAndFriction
  f0_max = f0*1.001; // Variables defined in partial friction, defined similar to MassWithStopAndFriction
  free = f0 <= 0 and Cv <= 0; // Variables defined in partial friction, defined similar to MassWithStopAndFriction
  
  // Total friction force (handled "cleanly" by state events)
  f = if locked then sa*unitForce else if free then 0 else (if startForward
     then Cv*v_rel + f_c + f_st else if startBackward then
    Cv*v_rel - f_c - f_st else if pre(mode) == Forward then
    Cv*v_rel + f_c + f_st*exp(-abs(v_rel)/Cst) else Cv*v_rel -
    f_c - f_st*exp(-abs(v_rel)/Cst));

  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-90, 0}, {-60, 0}}, color = {0, 127, 0}), Line(points = {{60, 0}, {90, 0}}, color = {0, 127, 0}), Rectangle(fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-60, 60}, {60, -60}}), Line(points = {{-40, 0}, {40, 0}}, thickness = 0.5), Line(points = {{-40, -40}, {-40, 40}}, thickness = 0.5), Polygon(fillPattern = FillPattern.Solid, points = {{-40, 45}, {-43, 38}, {-37, 38}, {-40, 45}}), Polygon(fillPattern = FillPattern.Solid, points = {{45, 0}, {38, -3}, {38, 3}, {45, 0}}), Line(origin = {-0.143368, 1.05137}, points = {{-40, 34}, {-38, 32}, {-35, 30}, {-30, 22}, {-20, 15}, {-10, 13}, {0, 12}, {10, 13}, {20, 16}, {30, 20}, {40, 25}}, color = {255, 0, 0}, thickness = 2, smooth = Smooth.Bezier), Line(origin = {1.41813, 0.53}, points = {{-40, 0}, {-40, 30}}, color = {128, 128, 128}, pattern = LinePattern.Dash, thickness = 0.5, arrow = {Arrow.Filled, Arrow.Filled}), Text(extent = {{35, -5}, {48, -12}}, textString = "v", fontSize = 8), Text(extent = {{-48, 42}, {-35, 35}}, textString = "F", fontSize = 8), Text(origin = {0, -2}, extent = {{-38, 20}, {-25, 15}}, textString = "Fst", fontSize = 28), Text(origin = {-17, -2}, extent = {{-10, 14}, {17, 5}}, textString = "Fc", fontSize = 28), Text(origin = {0, 14}, textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name"), Line(origin = {32.3728, -0.582374}, points = {{-40, 0}, {-40, 14}}, color = {128, 128, 128}, pattern = LinePattern.Dash, thickness = 0.5, arrow = {Arrow.Filled, Arrow.Filled}), Text(origin = {58, 10}, extent = {{-38, 20}, {-25, 15}}, textString = "Fv", fontSize = 28), Line(points = {{-60, -90}, {20, -90}}, color = {95, 127, 95}), Polygon(lineColor = {95, 127, 95}, fillColor = {95, 127, 95}, fillPattern = FillPattern.Solid, points = {{50, -90}, {20, -80}, {20, -100}, {50, -90}}), Text(origin = {4, 8}, extent = {{-150, -45}, {150, -75}}, textString = "Stribeck friction"), Line(origin = {74.0638, 0.834265}, points = {{-40, 0}, {-40, 22}}, color = {128, 128, 128}, pattern = LinePattern.Dash, thickness = 0.5, arrow = {Arrow.Filled, Arrow.Filled})}),
    Documentation(info = "<html>
<p>Stribeck friction model showing characteristic friction vs velocity curve:</p>
<ul>
<li>F_brk (F_s): Static/breakaway friction at v=0</li>
<li>Stribeck region: Exponential decay from static to kinetic</li>
<li>F_c: Coulomb (kinetic) friction minimum</li>
<li>Viscous region: Linear rise with velocity</li>
</ul>
</html>"));
end StribeckFriction;
