*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' @equations

*' Labor costs are calculated by multiplying the factor costs of production
*' by the share of labor our of factor costs.

q36_labor_costs(i2,kall) .. v36_labor_costs(i2,kall) =e= vm_cost_prod(i2,kall) * sum(ct,1-p36_capital_cost_share(ct,i2));

*' Employment calculated as labor costs devided by total hourly labor costs and 
*' average hours worked per employed person per year.

q36_employment(i2) .. v36_employment(i2)
                              =e= (sum((ct,kall),v36_labor_costs(i2,kall)) + p36_nonmagpie_labor_costs(ct,i2)) / (sum(ct,f36_weekly_hours(ct,i2)*52.1429*p36_hourly_costs(ct,i2)));