within OpenHydraulics.Developed.Interfaces.BaseClasses;

partial model PartialFluidComponent 
  "Base model for any component involving fluid"

  // Importing from the MSL
  import Modelica.Units.SI;
  import Modelica.Constants.inf;
  
  // Calling from the top-level model
  outer Systems.System system "System wide properties";
    outer OpenHydraulics.Circuits.Environment environment;
    
      outer OpenHydraulics.Fluids.BaseClasses.PartialFluid oil
    "This model must be defined in each circuit; the type must be a subtype of PartialFluid";
/*
  // Note: value of dp_start shall be refined by derived model, basing on local dp_nominal
  parameter SI.Pressure dp_start(min = -inf) = system.p_start "Guess value of dp = port_a.p - port_b.p" annotation(
    Dialog(tab = "Advanced"));
  parameter SI.MassFlowRate m_flow_start = system.m_flow_start "Guess value of m_flow = port_a.m_flow" annotation(
    Dialog(tab = "Advanced"));
  
  // Note: value of m_flow_small shall be refined by derived model, basing on local m_flow_nominal
  parameter SI.MassFlowRate m_flow_small = if system.use_eps_Re then system.eps_m_flow*system.m_flow_nominal else system.m_flow_small "Small mass flow rate for regularization of zero flow" annotation(
    Dialog(tab = "Advanced"));
  */
  // Fluid properties
  //SI.AbsolutePressure p_a(start = p_init) "Fluid properties at the inlet";
  //SI.AbsolutePressure p_b(start = p_init) "Fluid properties at the inlet";
  
  parameter SI.AbsolutePressure p_init = system.p_ambient "Initial pressure of the component" annotation(
    Dialog(tab = "Initialization", group = "Fluid"));
    
  
end PartialFluidComponent;
