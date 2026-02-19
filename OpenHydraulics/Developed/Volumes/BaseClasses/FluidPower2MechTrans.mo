within OpenHydraulics.Developed.Volumes.BaseClasses;

model FluidPower2MechTrans
  "Model representing the interaction between fluid dynamics and translational dynamics"
  
  // Inheriting from the OET
  extends Interfaces.BaseClasses.NPort;

  // Importing and inheriting from the MSL
  import Modelica.Units.SI;
  import Modelica.Utilities.Streams.print;
  //extends Modelica.Mechanics.Translational.Interfaces.PartialCompliantWithRelativeStates;
  // remove
    extends Modelica.Mechanics.Translational.Interfaces.PartialCompliant;
  
  
  // Additional model improvement flags
  parameter Boolean compressibleEnable = false "Enable fluid compressibility model" annotation(
    Dialog(tab = "Sizing"),
    choices(checkBox = true));
  parameter Boolean fluidInertiaEnable = false "Enable fluid inertia model" annotation(
    Dialog(tab = "Sizing"),
    choices(checkBox = true));
  
  // Parameters
  parameter SI.Area A = 0.01 "Area of piston" annotation(
    Dialog(tab = "Sizing"));
  parameter SI.AbsolutePressure maxPressure = 3e7 "Maximum rated pressure" annotation(
    Dialog(tab = "Sizing"));
  parameter SI.Volume residualVolume = 1e-6 "Volume remaining when s_rel<=0" annotation(
    Dialog(tab = "Sizing"));
  parameter SI.TranslationalSpringConstant stopStiffness = maxPressure*A*A/residualVolume "stiffness when chamber becomes empty" annotation(
    Dialog(tab = "Dynamics"));
  parameter SI.TranslationalDampingConstant stopDamping = stopStiffness/10 "damping when chamber becomes empty" annotation(
    Dialog(tab = "Dynamics"));
  
  // note: the default stiffness is such that the residual volume is reduced by
  // at most 10 percent
  SI.Volume V(start = residualVolume) "Volume of oil inside chamber";
  //SI.Mass m(start = residualVolume*system.rho_ambient) "Mass of oil inside chamber";
  SI.Mass m(start = residualVolume*system.rho_ambient);
  
  // Mechanical variables
  SI.Power Wmech "Mechanical work performed onto chamber";
  SI.Acceleration a_rel(start = 0) "Relative acceleration";
  
  // Media properties
  Modelica.Units.SI.AbsolutePressure p_vol(start = p_init) "Oil pressure in the chamber";

  // Compressibility
  Modelica.Units.SI.Density rho "Medium density (only used in compressible fluid models)";
  
  
  
  // remove
    Modelica.Units.SI.Velocity v_rel(start = 0) "relative velocity";
  //Modelica.Units.SI.Acceleration a_rel(start = 0) "relative acceleration";
  
  
protected
  // Empty volume
  parameter SI.Position s_relMin = -0.001 "the s_rel value at which the volume is zero";
  Boolean empty "true when chamber reaches end of travel";
  
  // Force variables
  SI.Force f_inertia "inertial force of the fluid";
  SI.Force f_stop "contact force when chamber is empty";
  SI.Force f_damping "damping force when chamber is empty";
  SI.Force f_contact "contact force when the end of travel is reached";

algorithm
  assert(V > 0, "Volume in fluid chamber is negative or zero.\n" + "Increase the residualVolume or the stopStiffness");
  assert(p_vol < maxPressure or s_rel < 0, "Maxiumum pressure in chamber has been exceeded");
  
  when empty then
    print("\nWARNING: CylinderChamber has reached end of travel.");
    print("         This could cause erratic behavior of the simulation.");
    print("         (time = " + String(time) + ")");
  end when;
  
equation
  // Pressure is the same everywhere
  for i in 1:n_ports loop
    p_vol = p[i];
  end for;
  
  // Volume
  V = max(s_rel, 0)*A + residualVolume;

  // New compressible density
  //rho = system.rho_ambient*(1 + (p_vol - system.p_ambient)/system.beta);
  //rho = system.Medium.density(p_vol)*(1 + (p_vol - system.p_ambient)/system.beta);
  //rho = system.Medium.density(p_vol)*(1 + (p_vol - system.p_ambient)/1e6);
  //rho = (system.rho_ambient + 20) + 5e-7*(p_vol-system.p_ambient);
  rho = system.rho_ambient*(1 + (p_vol - system.p_ambient)/system.beta);

  //rho = 850;
  // Compressible media
  if compressibleEnable then
    m = V*rho;
    
  // Incompressible media
  else
    //m = V*system.rho_ambient;
    m = V*system.Medium.density(p_vol);
  end if;
  
  // Computing mechanical states
  a_rel = der(v_rel);
  //remove
    v_rel = der(s_rel);
  
  // If empty volume
  empty = s_rel < 0;
  
  // Energy flows: work done by fluid
  Wmech = v_rel*(f + f_contact);
  
  // If enable inertial force
  if fluidInertiaEnable then
    f_inertia = -m*a_rel;
  else
    f_inertia = 0;
  end if;
  
  // Force equilibrium
  0 = A*(p_vol - system.p_ambient) + f_contact + f_inertia + f;
  
  // NOTE: the nonlinear spring force is most likely not physically accurate
  // but since impact is such a complex phenomenon, most other models would not be
  // accurate either.  The advantage of this model is that it is stable and smooth.
  if empty then
    f_stop = -stopStiffness*s_rel*(s_relMin/(s_relMin - s_rel));
  // Nonlinear spring force
    f_damping = -stopDamping*v_rel;
  // Damper force
    f_contact = if (f_stop + f_damping <= 0) then 0 else f_stop + f_damping;
    
  else
    f_stop = 0;
  // Spring force
    f_damping = 0;
  // Damper force
    f_contact = 0;
    
  end if;
  // Conservation of mass
  der(m) = sum(port.m_flow);
  annotation(
    Diagram(graphics = {Rectangle(extent = {{-80, 40}, {80, -40}}, lineColor = {0, 0, 0}), Rectangle(extent = {{100, 4}, {40, -4}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Rectangle(extent = {{30, 40}, {40, -40}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-30, 40}, {30, -40}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-40, 40}, {-30, -40}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-40, 4}, {-100, -4}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-16, 16}, {16, -16}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid)}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-80, 40}, {80, -40}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{100, 4}, {44, -4}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Rectangle(extent = {{34, 39}, {44, -39}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-34, 40}, {34, -40}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-44, 39}, {-34, -39}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-44, 4}, {-100, -4}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Text(extent = {{0, 100}, {0, 60}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, textString = "%name"), Ellipse(extent = {{-16, 16}, {16, -16}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid)}));
end FluidPower2MechTrans;
