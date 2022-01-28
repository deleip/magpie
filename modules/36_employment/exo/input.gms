*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


table f36_hist_weekly_hours(t_all,i) Historical values of average weekly hours worked per person in agriculture
$ondelim
$include "./modules/36_factor_costs/exo/input/f36_hist_weekly_hours.csv"
$offdelim
;

parameter f36_agg_weight(iso) Total hours worked based on ILO data for 2015 as aggregation weigth for hourly costs
/
$ondelim
$include "./modules/36_factor_costs/exo/input/f36_agg_weight.csv"
$offdelim
/
;

table f36_reg_parameters(iso,reg36) Parameters for regression of hourly labor costs with GDPpcMER
/
$ondelim
$include "./modules/36_employment/exo/input/f36_regression_hourly_labor_costs.csv"
$offdelim
/
;