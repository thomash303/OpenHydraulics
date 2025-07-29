within OpenHydraulics.Custom.Valves;

model VariableLaminarRestrictionSeriesValve

  
  // Importing from the MSL
  import Modelica.Constants.pi;
  import Modelica.Fluid.Utilities;
  import Modelica.Fluid.Types.CvTypes;

  extends BaseClasses.PartialLaminarRestriction(rho_avg = rho_nom);
  // Keep
  /*  mass balance eq, ValveCharacteristic, dp_small. Kv2Av, Cv2Av*/
  // Remove
  /* think conductance can go*/
  // Add
  /* rho_nominal, dp_nominal, m_flow_nominal, Av, Kv, Cv, filteredOpening, riseTime */
  
  // Complete
  /* eta (viscosity) -  make mu_avg, d (density) - make rho_avg, m_flow removed into top-level class, */

parameter String valveEquation = "Orifice" 
  "Equation to describe flow through the valve"
  annotation(
    choices(
      choice="Linear" "Use a simple linear equation",
      choice="Orifice" "Use the orifice equation"
    ),
    choicesAllMatching = true
  );
  constant SI.ReynoldsNumber Re_turbulent = 4000
  "cf. straight pipe for fully open valve -- dp_turbulent increases for closing valve";
  parameter Boolean use_Re = system.use_eps_Re
  "= true, if turbulent region is defined by Re, otherwise by m_flow_small"
    annotation(Dialog(tab="Advanced"), Evaluate=true);
  SI.AbsolutePressure dp_turbulent = if not use_Re then dp_small else
    max(dp_small, (system.Medium.dynamicViscosity(p_a) + system.Medium.dynamicViscosity(p_b))^2*pi/8*Re_turbulent^2
                  /(max(relativeFlowCoefficient,0.001)*Av*(system.Medium.dynamicViscosity(p_a) + system.Medium.dynamicViscosity(p_b))));   
                   
protected
  Real relativeFlowCoefficient = valveCharacteristic(opening_actual);
initial equation
  if CvData == CvTypes.OpPoint then
      m_flow_nom = valveCharacteristic(opening_nom)*Av*sqrt(rho_nom)*Utilities.regRoot(dp_nom, dp_small)
    "Determination of Av by the operating point";
  end if;

equation
  if valveEquation == "Linear" then
    port_a.m_flow = if dp>0 then m_flow_nom/dp_nom*dp else 0;
  else
   port_a.m_flow = homotopy(relativeFlowCoefficient*Av*sqrt(rho_avg)*
                           Utilities.regRoot2(dp,dp_turbulent,1.0,0.0,use_yd0=true,yd0=0.0),
                      relativeFlowCoefficient*m_flow_nom*dp/dp_nom);
  end if;
                      
   
  annotation(
    Diagram(graphics = {Polygon(fillPattern = FillPattern.Solid, points = {{20, 40}, {4, 24}, {16, 18}, {20, 40}}), Line(points = {{-20, -40}, {20, 40}})}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points = {{20, 40}, {4, 24}, {16, 18}, {20, 40}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Line(points = {{-20, -40}, {20, 40}}, color = {0, 0, 0})}));
end VariableLaminarRestrictionSeriesValve;
