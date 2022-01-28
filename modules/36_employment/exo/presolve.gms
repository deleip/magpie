*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


if (m_year(t)<2015,
	p36_weekly_hours(t,i) = f36_hist_weekly_hours(t,i)
elseif (m_year(t)>=2015),
	p36_weekly_hours(t,i) = f36_hist_weekly_hours("y2015",i)
$endif
);

p36_hourly_costs(t,i) = sum(i_to_iso(i,iso),(im_gdp_pc_mer_iso(t,iso)*f36_reg_parameters(iso,"slope")+f36_reg_parameters(iso,"intercept"))
												*(f36_agg_weight(iso)/sum(i_to_iso(i,iso2),f36_agg_weight(iso2)))