within OpenHydraulics.Developed.Machines.BaseClasses;

model MechanicalPumpLosses_noState 
  "McCandlish and Dory motor mechanical loss model"
  // Inheriting from the OET
  // Importing and inheriting from the MSL
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlangesAndSupport;
  import Modelica.Units.SI;
  import Modelica.Constants.pi;
  import Modelica.Blocks.Interfaces.RealInput;
  import Modelica.Math.Vectors.interpolate;
  // Loss parameters
  parameter Real Cv[:] = {0, 1} "Coefficients of viscous drag" annotation(
    Dialog(group = "Friction"));
  parameter Real CvD[:] = {0, 1} "Displacement fraction of slip coefficients" annotation(
    Dialog(group = "Friction"));
  parameter Real Cf[:] = {0, 1} "Coefficients of Coulomb friction (fraction of full stroke torque)" annotation(
    Dialog(group = "Friction"));
  parameter Real CfD[:] = {0, 1} "Displacement fraction of slip coefficients" annotation(
    Dialog(group = "Friction"));
  parameter SI.Volume Dmax = 1e-4 "Maximum pump displacement";
  parameter SI.DynamicViscosity mu = 0.036 "Dynamic Viscosity of liquid";
  // Variables
  SI.Torque tau;
  SI.Angle phi;
  SI.AngularVelocity w "Absolute angular velocity of flange_a and flange_b";
  SI.AngularAcceleration a "Absolute angular acceleration of flange_a and flange_b";
  SI.Pressure dpMot "Pressure across the motor";
  Real alpha "Pump displacement fraction";
  Real cv = interpolate(CvD, Cv, alpha) "Interpolated coefficient of viscous drag";
  Real cf = interpolate(CfD, Cf, alpha) "Interpolated coefficient of Coulomb friction";
  SI.RotationalDampingConstant b = cv*Dmax*mu/(2*pi) "Viscous friction constant";
  
  // New variables
  SI.Torque tau0;
  SI.Torque tau0_max;
equation
// Constant auxiliary variables
  tau0 = cf*dpMot*Dmax;
// Coulomb friction
  tau0_max = tau0;

  phi = flange_a.phi;
  phi = flange_b.phi;
// Angular velocity and angular acceleration of flanges
  w = der(phi);
  a = der(w);
// Torque equilibrium
  0 = flange_a.tau + flange_b.tau - tau;
// Friction torque
  //tau = cf*dpMot*Dmax*tanh(w/0.01) + b*w;
  tau = cf*dpMot*Dmax*sign(w) + b*w;
  annotation(
    Documentation(info = "<html>
<p>
This element describes <b>frictional losses</b> in a <b>hydraulic pump or motor</b>.
</p>
<p>The model is based on the paper:<br>
<dl>
<dt>McCandlish, D., and Dorey, R. E.,
<dd>'The Mathematical Modelling of Hydrostatic Pumps and Motors,'
<i>Proceedings of the Institution of Mechanical Engineers</i>,
Part B, Vol. 198, No. 10, 1984, pp 165-174.
</dl></p>
<p>
The model implementation is derived from the bearing friction
model in the standard Modelica library.
</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Rectangle(extent = {{-96, 20}, {96, -21}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {192, 192, 192}), Line(points = {{-30, -40}, {30, -40}}, color = {0, 0, 0}), Line(points = {{0, -40}, {0, -90}}, color = {0, 0, 0}), Polygon(points = {{-30, -20}, {60, -20}, {60, -80}, {70, -80}, {50, -100}, {30, -80}, {40, -80}, {40, -30}, {-30, -30}, {-30, -20}, {-30, -20}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid), Line(points = {{30, -50}, {20, -60}}, color = {0, 0, 0}), Line(points = {{30, -40}, {10, -60}}, color = {0, 0, 0}), Line(points = {{20, -40}, {0, -60}}, color = {0, 0, 0}), Line(points = {{10, -40}, {-10, -60}}, color = {0, 0, 0}), Line(points = {{0, -40}, {-20, -60}}, color = {0, 0, 0}), Line(points = {{-10, -40}, {-30, -60}}, color = {0, 0, 0}), Line(points = {{-20, -40}, {-30, -50}}, color = {0, 0, 0}), Text(extent = {{-150, 80}, {150, 40}}, textString = "%name")}),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Rectangle(extent = {{-96, 20}, {96, -21}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {192, 192, 192}), Line(points = {{-30, -40}, {30, -40}}, color = {0, 0, 0}), Line(points = {{0, 60}, {0, 40}}, color = {0, 0, 0}), Line(points = {{-30, 40}, {29, 40}}, color = {0, 0, 0}), Line(points = {{0, -40}, {0, -90}}, color = {0, 0, 0}), Polygon(points = {{-30, -20}, {60, -20}, {60, -80}, {70, -80}, {50, -100}, {30, -80}, {40, -80}, {40, -30}, {-30, -30}, {-30, -20}, {-30, -20}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid), Text(extent = {{16, 83}, {84, 70}}, lineColor = {128, 128, 128}, textString = "rotation axis"), Polygon(points = {{12, 76}, {-8, 81}, {-8, 71}, {12, 76}}, lineColor = {128, 128, 128}, fillColor = {128, 128, 128}, fillPattern = FillPattern.Solid), Line(points = {{-78, 76}, {-7, 76}}, color = {128, 128, 128}), Line(points = {{30, -50}, {20, -60}}, color = {0, 0, 0}), Line(points = {{30, -40}, {10, -60}}, color = {0, 0, 0}), Line(points = {{20, -40}, {0, -60}}, color = {0, 0, 0}), Line(points = {{10, -40}, {-10, -60}}, color = {0, 0, 0}), Line(points = {{0, -40}, {-20, -60}}, color = {0, 0, 0}), Line(points = {{-10, -40}, {-30, -60}}, color = {0, 0, 0}), Line(points = {{-20, -40}, {-30, -50}}, color = {0, 0, 0})}));
end MechanicalPumpLosses_noState;
