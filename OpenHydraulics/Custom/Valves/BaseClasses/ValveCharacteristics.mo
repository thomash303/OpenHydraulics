within OpenHydraulics.Custom.Valves.BaseClasses;

package ValveCharacteristics "Functions for valve characteristics"
  extends Modelica.Icons.VariantsPackage;
  partial function baseFun "Base class for valve characteristics"
    extends Modelica.Icons.Function;
    input Real pos(min=0, max=1)
        "Opening position (0: closed, 1: fully open)";
    output Real rc "Relative flow coefficient (per unit)";
    annotation (Documentation(info="<html>
<p>
This is a partial function that defines the interface of valve
characteristics. The function returns \"rc = valveCharacteristic\" as function of the
opening \"pos\" (in the range 0..1):
</p>

<blockquote><pre>
  dp = (zeta_TOT/2) * rho * velocity^2
m_flow =    sqrt(2/zeta_TOT) * Av * sqrt(rho * dp)
m_flow = valveCharacteristic * Av * sqrt(rho * dp)
m_flow =                  rc * Av * sqrt(rho * dp)
</pre></blockquote>

</html>"));
  end baseFun;

  function linear "Linear characteristic"
    extends baseFun;
  algorithm
    rc := pos;
  end linear;

  function step "Constant characteristic"
    extends baseFun;
  algorithm
    rc := 1;
  end step;

  function quadratic "Quadratic characteristic"
    extends baseFun;
  algorithm
    rc := pos*pos;
  end quadratic;

  function equalPercentage "Equal percentage characteristic"
    extends baseFun;
    input Real rangeability = 20 "Rangeability" annotation(Dialog);
    input Real delta = 0.01 annotation(Dialog);
  algorithm
    rc := if pos > delta then rangeability^(pos-1) else
            pos/delta*rangeability^(delta-1);
    annotation (Documentation(info="<html>
This characteristic is such that the relative change of the flow coefficient is proportional to the change in the opening position:
<p> d(rc)/d(pos) = k d(pos).</p>
<p> The constant k is expressed in terms of the rangeability, i.e., the ratio between the maximum and the minimum useful flow coefficient:</p>
<p> rangeability = exp(k) = rc(1.0)/rc(0.0).</p>
<p> The theoretical characteristic has a non-zero opening when pos = 0; the implemented characteristic is modified so that the valve closes linearly when pos &lt; delta.</p>
</html>"));
  end equalPercentage;

end ValveCharacteristics;
