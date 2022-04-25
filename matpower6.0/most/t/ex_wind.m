function wind = ex_wind(mpc)
%EX_WIND  Example Wind data file for stochastic OPF.

%   MOST
%   Copyright (c) 2015-2016, Power Systems Engineering Research Center (PSERC)
%   by Ray Zimmerman, PSERC Cornell
%
%   This file is part of MOST.
%   Covered by the 3-clause BSD License (see LICENSE file for details).
%   See http://www.pserc.cornell.edu/matpower/ for more info.

%%-----  wind  -----
%% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
wind.gen = [
	2	0	0	50	-50	1	100	1	100	0	0	0	0	0	0	0	0	200	200	0	0;
];
%% xGenData
wind.xgd_table.colnames = {
	'InitialPg', ...
		'RampWearCostCoeff', ...
			'PositiveActiveReservePrice', ...
				'PositiveActiveReserveQuantity', ...
					'NegativeActiveReservePrice', ...
						'NegativeActiveReserveQuantity', ...
							'PositiveActiveDeltaPrice', ...
								'NegativeActiveDeltaPrice', ...
									'PositiveLoadFollowReservePrice', ...
										'PositiveLoadFollowReserveQuantity', ...
											'NegativeLoadFollowReservePrice', ...
												'NegativeLoadFollowReserveQuantity', ...
};

wind.xgd_table.data = [
	0	0	1e-8	200	2e-8	200	1e-9	1e-9	1e-6	200	1e-6	200;
];
