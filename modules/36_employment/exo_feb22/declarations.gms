*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


equations
 q36_employment(i)            Regional agricultural emplyoment (mio people)
 q36_labor_costs(i,kall)      Regional agricultural labor costs per commodity (mio USDMER05)   
;

positive variables
 v36_labor_costs(i,kall)         Labor costs (mio USDMER05  per yr)
 v36_employment(i,kall)          Number of people employed in agriculture (mio people)
;

parameters
 p36_weekly_hours(t,i)           Average weekly hours worked per person in agriculture (hours per week)
 p36_hourly_costs(t,i)			 Hourly labor costs in agriculture (USDMER05 per hour)
 p36_capital_cost_share(t,i)     Capital share of factor costs (1)
 p36_share_calibration(i)        Additive calibration term for capital shares (1)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov36_employment(t,i,kall,type) Number of people employed in agriculture (mio people)
 oq36_employment(t,i,kall,type) Regional agricultural emplyoment per crop and livestock type (mio people)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

