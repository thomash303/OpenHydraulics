within OpenHydraulics.Developed.Machines.BaseClasses;

partial model PartialPumpMotor 
  "Partial model for displacement pumps or motors"
  
  // Inheriting from the OET
  extends PumpMotorInterface;
  
  // Importing from the MSL
  import Modelica.Units.{SI,NonSI,Conversions};
  import Modelica.Constants.pi;
  
  // Pump/Motor Variables
  SI.Volume D "Pump displacement";
  
  // Rotational variables
  SI.AngularVelocity omega "Shaft angular velocity";
  NonSI.AngularVelocity_rpm N = Conversions.to_rpm(omega) "Shaft rotational speed";
  SI.Torque tau "Torque needed for pumping fluid";
  SI.Power Wmech "Mechanical power applied to fluid";

equation
  // Rotational equations
  omega = der(phi);
  tau = flange_a.tau + flange_b.tau;
  Wmech = omega*tau "Mechanical work";

  // Relate torque to pressure
  tau = -D*dp/(2*pi);
  
  // Relate flow to rotational velocity
  q_flow_a = D*N/60;

  // Mass balance
  0 = port_a.m_flow + port_b.m_flow "Mass balance";

end PartialPumpMotor;
