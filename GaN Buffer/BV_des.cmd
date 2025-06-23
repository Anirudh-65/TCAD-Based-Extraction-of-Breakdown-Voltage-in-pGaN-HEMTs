# Example for studying gate current leakage in p-Gate GaN-based HEMTs

#include "common_des.cmd"

#define _Vmax_ 3e3
#define  _dt_ 1e1
#define _Imax_ 1e-3

Solve {
	
	Coupled(Iterations= 1000 LineSearchDamping= 1e-4 ){ Poisson }
	Coupled(Iterations= 1000 LineSearchDamping= 1e-4 ) { Poisson Electron }
	Coupled(Iterations= 1000 LineSearchDamping= 1e-4 ) { Poisson Electron Hole  }
	* Coupled(Iterations= 1000 LineSearchDamping= 1e-4 ) { Poisson Electron Hole  Temperature}
	Plot(FilePrefix="n@node@_Zero")

	

	NewCurrentFile="BV_"
	Transient (
		InitialTime= 0 FinalTime= _dt_
		InitialStep= @< 1e-3 / _dt_ >@ MinStep= @<1e-12/_dt_>@ Maxstep= @< 10.0 /_dt_>@
		Increment= 1.5 Decrement= 2.0
		Goal { Name= drain Voltage= _Vmax_ }
		BreakCriteria { Current (Contact="drain" absval= _Imax_ ) }
	) {                  
		Coupled { Poisson Electron Hole  } 
		Plot(FilePrefix="n@node@_ss" Time=(Range=(0 2000) Intervals= 4) NoOverwrite)
	}
}
