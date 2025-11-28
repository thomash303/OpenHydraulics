within OpenHydraulics.Developed.Interfaces;

model HorizontalTwoPort 
  "Two horizontally oriented fluid ports"
  
  // Include the base characteristics for ANY fluid two-port
  extends BaseClasses.PartialFluidComponent;
  
  // Volumetric flow rate
  SI.VolumeFlowRate q_flow_a = port_a.m_flow/system.rho_ambient;
  SI.VolumeFlowRate q_flow_b = port_b.m_flow/system.rho_ambient;
  
  // Pressure change
  SI.Pressure dp = port_a.p - port_b.p "Pressure drop (negative for pumps)";
  
  // Fluid ports
  FluidPort port_a(p(start = p_init)) annotation(
    Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
  FluidPort port_b(p(start = p_init)) annotation(
    Placement(transformation(extent = {{110, -10}, {90, 10}})));
equation
  // Set fluid properties
  p_a = port_a.p;
  p_b = port_b.p;
end HorizontalTwoPort;
