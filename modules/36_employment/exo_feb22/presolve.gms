*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* calibration of hourly labor costs regression with GDP pc in MER
p36_calibration_hourly_costs(iso) = f36_hist_hourly_costs("y2015",iso)-(im_gdp_pc_mer_iso("y2015",iso)*f36_regr_hourly_costs(iso,"slope")+f36_regr_hourly_costs(iso,"intercept"));
if (m_year(t)<2015,
	p36_hourly_costs(t,i) = sum(i_to_iso(i,iso),f36_hist_hourly_costs(t,iso)*(f36_agg_weight("y2015",iso)/sum(i_to_iso(i,iso2),f36_agg_weight("y2015",iso2)));
elseif (m_year(t)>=2015),
	p36_hourly_costs(t,i) = sum(i_to_iso(i,iso),max((im_gdp_pc_mer_iso(t,iso)*f36_regr_hourly_costs(iso,"slope")+
													f36_regr_hourly_costs(iso,"intercept")+p36_calibration_hourly_costs(iso)), 
													f36_regr_hourly_costs(iso,"threshold"))
												*(f36_agg_weight("y2015",iso)/sum(i_to_iso(i,iso2),f36_agg_weight("y2015",iso2))));
$endif	
);

* capital cost share to split factor costs into labor and capital
p36_share_calibration(i) = f36_hist_cap_share("y2010",i)-(f36_regr_cap_share("slope")*log10(sum(i_to_iso(i,iso),im_gdp_pc_ppp_iso("y2010",iso)))+f36_regr_cap_share("intercept"));

if (m_year(t)<2010,
p36_capital_cost_share(t,i) = f36_hist_cap_share(t,i);
elseif (m_year(t)>=2010),
p36_capital_cost_share(t,i) = f36_regr_cap_share("slope")*log10(sum(i_to_iso(i,iso),im_gdp_pc_ppp_iso(t,iso)))+f36_regr_cap_share("intercept")+p36_share_calibration(i);
$endif
);

* non-MAgPIE labor costs
p36_nonmagpie_labor_costs(t,i) = (f36_unspecified_subsidies(t,i) + f36_nonmagpie_vop(t,i)) * (1-p36_capital_cost_share(t,i))