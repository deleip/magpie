*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


table f36_weekly_hours(t_all,i) Historical values of average weekly hours worked per person in agriculture
$ondelim
$include "./modules/36_factor_costs/exo/input/f36_weekly_hours.csv"
$offdelim
;

* calcOutput("HourlyLaborCosts", datasource = "USDA_FAO", fillWithRegression = TRUE, aggregate = FALSE, years = seq(1960,2015,5))
table f36_hist_hourly_costs(t_all,iso) Parameters for regression of hourly labor costs with GDPpcMER
/
$ondelim
$include "./modules/36_employment/exo/input/f36_historic_hourly_labor_costs.csv"
$offdelim
/
;

table f36_regr_hourly_costs(reg36) Parameters for regression of hourly labor costs with GDPpcMER
/
$ondelim
$include "./modules/36_employment/exo/input/f36_regression_hourly_labor_costs.csv"
$offdelim
/
;

parameter f36_agg_weight(iso) Total hours worked based on ILO data for 2015 as aggregation weigth for hourly costs
/
$ondelim
$include "./modules/36_factor_costs/exo/input/f36_agg_weight.csv"
$offdelim
/
;

parameter f36_unspecified_subsidies(t_all,i) Factor cost share of unspecified subsidies not included in MAgPIE labor costs
/
$ondelim
$include "./modules/36_factor_costs/exo/input/f36_unspecified_subsidies.csv"
$offdelim
/
;

parameter f36_nonmagpie_vop(t_all,i) Factor cost share of VoP from ag commodities not mapped to MAgPIE
/
$ondelim
$include "./modules/36_factor_costs/exo/input/f36_nonmagpie_vop.csv"
$offdelim
/
;

parameter f36_regr_cap_share(reg36) Parameters for dynamic regression
/
$ondelim
$include "./modules/36_employment/exo/input/f38_regression_cap_share.csv"
$offdelim
/
;

table f36_hist_cap_share(t_all,i) Historical capital share
$ondelim
$include "./modules/36_employment/exo/input/f38_historical_share.csv"
$offdelim
;