File {
	Grid= 			"@tdr@"
	Parameter= 		"@parameter@"
	
	Current= 		"@plot@"
	Plot= 			"@tdrdat@"
	Output=			"@log@"
} 

Electrode {
	{Name= source	Voltage= 0.0 Schottky Workfunction= 3.8 Resist= 100}	* Rsd in Ohm-mm
	{Name= drain	Voltage= 0.0 Schottky Workfunction= 3.8 Resist= 100}	* Rsd in Ohm-mm
	{Name= gate  	Voltage= 0.0 Schottky Workfunction= 4}
	{Name= bulk		Voltage= 0.0}
}




Thermode {
        { Name="thermal" Temperature= 300 SurfaceResistance= 0.0004 }
}


Physics { 
	AreaFactor= 1000
	Temperature= 300
	DefaultParametersFromFile
	
	#if "@tool_label@" == "IdVd"
		Thermodynamic
		AnalyticTEP
	#endif
	
	EffectiveIntrinsicDensity (NoBandGapNarrowing)
	Fermi Thermionic
	Mobility ( DopingDependence HighFieldSaturation)
	Recombination (
		SRH 
		Radiative
		* Auger
		#if "@tool_label@" == "BV"
			Avalanche
		#endif
	)
	Aniso (
		Poisson
	    direction(SimulationSystem)= xAxis
	)

		
	Piezoelectric_Polarization(strain)
	#if "@tool_label@" == "BV"
	** No hBarrierTunneling
	#else
	hBarrierTunneling "NLM_Gate"
	#endif
	
	eBarrierTunneling "NLM_Bot"
	eBarrierTunneling "NLM_Top"
	
	
	#if @II@
	* Significant incomplete ionization of Mg in GaN
	IncompleteIonization(Dopants= "pMagnesiumActiveConcentration")
	#endif
	
}

** P-gate FULL
Physics (Region="Barrier") {
	Traps (
		(Acceptor Level Conc= 1e18 EnergyMid= 1.6 fromValBand )
	)
	
}


Physics (Region="Channel") {
	Traps (
		(Acceptor Level Conc= 1e18 EnergyMid= 0.9 FromValenceBand Add2TotalDoping Name= "t1")
	)
}



Physics (Region="Nucleation") {
	Traps (
  		# Assume C doping imposes a level ~0.9 eV from Ev (~-0.8 from mid bandgap)
		(Acceptor Level Conc= 1e19 EnergyMid= -0.8 FromMidbandgap SFactor="DeepLevels")
	)
	
	# Turn off polarization effects around nucleation. Lack of available info
	Piezoelectric_Polarization(Activation= 0)
}
Physics (MaterialInterface="AlGaN/Si3N4") {
	Piezoelectric_Polarization(Activation= 0.1)
	Traps(Donor Level EnergyMid= 1.0 FromMidbandgap Conc= 1e13)
}

Physics (MaterialInterface="AlN/GaN") {
	Piezoelectric_Polarization(Activation= 0.1)
	Traps(Donor Level EnergyMid= 1.0 FromMidbandgap Conc= 1e13)
}

Physics (MaterialInterface="AlN/AlGaN") {
	Piezoelectric_Polarization(Activation= 0.1)
	Traps(Donor Level EnergyMid= 1.0 FromMidbandgap Conc= 1e13)
}

Physics (MaterialInterface="GaN/Si3N4") {
	Piezoelectric_Polarization(Activation= 0.0)
	# Traps(Donor Level EnergyMid= 1.0 FromMidbandgap Conc= 1e13)
}





Physics (Region= "Subs") {
  Recombination (-Radiative)
}

Plot { 
	ElectricField/Vector 
	eMobility hMobility
	eCurrent/Vector hCurrent/Vector TotalCurrent/Vector CurrentPotential
	
	DopingConcentration DonorConcentration AcceptorConcentration
	TotalTrapConcentration eTrappedCharge hTrappedCharge
	TotalInterfaceTrapConcentration eInterfaceTrappedCharge hInterfaceTrappedCharge
	nSiliconActiveConcentration
	pMagnesiumActiveConcentration pMagnesiumConcentration pMagnesiumMinusConcentration
	PMIUserField0 PMIUserField1
	
	SpaceCharge
	ConductionBandEnergy ValenceBandEnergy eQuasiFermiEnergy hQuasiFermiEnergy
	EffectiveBandgap Affinity
	
	PE_Polarization/Vector PE_Charge
	
	xMoleFraction

	eBarrierTunneling hBarrierTunneling eGapStatesRecombination hGapStatesRecombination
	SRH Radiative
	
	StressXX StressXY StressXZ StressYY StressYZ StressZZ
	
	lHeatFlux TotalHeat eJouleHeat hJouleHeat PeltierHeat ThomsonHeat 
	RecombinationHeat netRecombinationHeat
	
	NonLocal
	Avalanche eAvalanche hAvalanche 
}

Math {
	Extrapolate
	ExtendedPrecision(80)
	TensorGridAniso(Aniso)
	lT_range= (1e-3 1e10)
	Method= ILS(set= 11)
	ILSrc="
		set(11){
			iterative(gmres(150), tolrel=1e-10, tolunprec=1e-6, tolabs=0, maxit=200);
			preconditioning(ilut(1.0e-8,-1), right);
			ordering(symmetric=nd, nonsymmetric=mpsilst);
			options(compact=yes, linscale=0, refineresidual=10, verbose=0);
		};
	"
	Number_of_Threads= 4
	Wallclock
	
	Iterations= 15
	RHSMax= 1e12
	RHSMin= 1e-10
	
	Transient= BE
	Traps(Damping= 0)
	DirectCurrentComputation
	ComputeDopingConcentration
	
	ErrRef(electron)= 1e5
	ErrRef(hole)= 1e5
	#if "@tool_label@" == "BV"
		CDensityMin= 1e-20
		Digits= 7
	#else
	    Digits= 5
	#endif
	RefDens_eGradQuasiFermi_EparallelToInterface= 1e8
	RefDens_hGradQuasiFermi_ElectricField_HFS= 1e8
	RefDens_eGradQuasiFermi_ElectricField= 1e8
	RefDens_hGradQuasiFermi_ElectricField= 1e8

	# ElementEdge averaging is believed to be a better option today than the default "Element"
	eMobilityAveraging= ElementEdge
	hMobilityAveraging= ElementEdge

	* SimStats
	* CNormPrint
	
	ExitOnFailure
	
	NonLocal "NLM_Gate" (
		Electrode="gate"
		Length= 15e-7
		Digits= 4
	)

	NonLocal "NLM_Bot" (
		RegionInterface="Channel/Barrier"
		Length= @<0.9*tB*1e-4>@
		Digits= 4
		Direction=(1 0 0) MaxAngle= 60
		-Transparent(Region="Channel")
	)

	NonLocal "NLM_Top" (
		RegionInterface="pGate/Barrier"
		Length= @<0.9*tB*1e-4>@
		Digits= 4
		Direction=(1 0 0) MaxAngle= 60
		-Transparent(Region="pGate")
	)
	
	
    -CheckUndefinedModels

    RHSFactor= 1e30
}
