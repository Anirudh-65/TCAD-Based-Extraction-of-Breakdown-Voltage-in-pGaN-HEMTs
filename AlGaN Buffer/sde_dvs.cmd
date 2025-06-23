; ==================================================================================================
; pGate GaN HEMT based on structure after
;   I. Hwang et. al., “p-GaN Gate HEMTs With Tungsten Gate Metal for High Threshold Voltage and 
;   Low Gate Current”, IEEE EDL 34-2, p. 202 (2013)
;
; Version history
;	Author: Nelson Braga (SNPS)
;	Initial Version: July 17, 2019
;	Version 1.0: September 11, 2019
;		1) Added Schottky contact rounding
;		2) Removed provision for TAT at Schottky gate
; ==================================================================================================

; Define auxiliary variables to help with parameterization

(sde:define-parameter "SubstrateMaterial"       "Silicon") 

; Vertical coordinates
(sde:define-parameter "tSubs"		 5.000)		; Keep substrate thickness small for now
(sde:define-parameter "tNucleation"	 0.150)
(sde:define-parameter "tAlGaNBuffer" 1.300)
(sde:define-parameter "tGaNBuffer"	 1.700)
(sde:define-parameter "NC"		      1e19)		; Carbon doping density in buffer layers
(sde:define-parameter "tChannel"	 0.200)
(sde:define-parameter "tBarrier"	  @tB@)
(sde:define-parameter "tpGate"		 0.100)
(sde:define-parameter "NMg"			 @NMg@)
(sde:define-parameter "sMg"			 @sMg@)		; Standard dev. for Mg diff into barrier layer
(sde:define-parameter "Nbg"			  1e16)		; Background electron density
(sde:define-parameter "tWGate"		 0.250)		; Gate metal thickness
(sde:define-parameter "tSiN" 		 0.200)		; Passivation layer thickness
(sde:define-parameter "r" 		 	   @r@)		; Gate contact corner radius
(sde:define-parameter "xAlGaN_barrier" 		 	   @xB@)
(sde:define-parameter "xAlGaN_buffer" 		 	   @XBufferxB@)

; Derived vertical coordinates
; Align channel interface with x=0
(sde:define-parameter "X0_Channel"		0.000)
(sde:define-parameter "X0_Barrier"		(- X0_Channel tBarrier))
(sde:define-parameter "X0_pGate" 		(- X0_Barrier tpGate))
(sde:define-parameter "X0_WGate" 		(- X0_pGate tWGate tSiN))
(sde:define-parameter "X0_TiSD"	        X0_WGate)
(sde:define-parameter "X0_GaNBuffer" 	(+ X0_Channel tChannel))
(sde:define-parameter "X0_AlGaNBuffer" 	(+ X0_GaNBuffer tGaNBuffer))
(sde:define-parameter "X0_Nucleation" 	(+ X0_AlGaNBuffer tAlGaNBuffer))
(sde:define-parameter "X0_Subs" 		(+ X0_Nucleation tNucleation))
(sde:define-parameter "X1_Subs" 		(+ X0_Subs tSubs))

; Lateral structure dimensions
(sde:define-parameter "Lmg"			4.000)	; Gate metal length
(sde:define-parameter "Lgc"			2.000)	; Gate contact length
(sde:define-parameter "Lsg"			2.000)
(sde:define-parameter "Lgd"	   	   12.000)
(sde:define-parameter "LpGaN"		4.000)	; p-Gate length
(sde:define-parameter "Lohm"		0.500)

; Derived horizontal coordinates
; Align center of pGate region with y origin
(sde:define-parameter "yg"		 	0.000)
(sde:define-parameter "Ymin" 		(- yg (/ LpGaN 2.0) Lsg Lohm))
(sde:define-parameter "Ymax" 		(+ yg (/ LpGaN 2.0) Lgd Lohm))
(sde:define-parameter "ymgl" 		(- yg (/ Lmg 2.0)))
(sde:define-parameter "ymgr" 		(+ yg (/ Lmg 2.0)))
(sde:define-parameter "ygcl" 		(- yg (/ Lgc 2.0)))
(sde:define-parameter "ygcr" 		(+ yg (/ Lgc 2.0)))
(sde:define-parameter "ypgl" 		(- yg (/ LpGaN 2.0)))
(sde:define-parameter "ypgr" 		(+ yg (/ LpGaN 2.0)))
(sde:define-parameter "ysr" 		(+ Ymin Lohm))
(sde:define-parameter "ydl" 		(- Ymax Lohm))


; ==================================================================================================
; Create epi structure
; There are a few other possible ways to do this, including loading CSV file created with Excel

; Define Si substrate
(sdegeo:create-rectangle (position X0_Subs Ymin 0) (position X1_Subs Ymax 0) "@SubstrateMaterial@" "Subs")
(sdedr:define-constant-profile "DC.subs" "BoronActiveConcentration" 1e16)
(sdedr:define-constant-profile-region "CPM.subs" "DC.subs" "Subs")

; "Grow" nucleation and buffer layers
; Define mole fractions in S-Device
(sdegeo:create-rectangle 
	(position X0_Nucleation Ymin 0) (position X0_Subs Ymax 0) "AlN" "Nucleation")
(sdegeo:create-rectangle 
	(position X0_AlGaNBuffer Ymin 0) (position X0_Nucleation  Ymax 0) "AlGaN" "AlGaNBuffer")
(sdegeo:create-rectangle 
	(position X0_GaNBuffer Ymin 0) (position X0_AlGaNBuffer Ymax 0) "GaN" "GaNBuffer")

; C doping uniform distribution in nucleation, buffer layers.
; Use DeepLevels for easy use as SFactor in S-Device
(sdedr:define-constant-profile "DC.C" "DeepLevels" NC)
(sdedr:define-constant-profile-region "CPM.C0" "DC.C" "Nucleation")
(sdedr:define-constant-profile-region "CPM.C1" "DC.C" "AlGaNBuffer")
(sdedr:define-constant-profile-region "CPM.C2" "DC.C" "GaNBuffer")

; GaN Channel
(sdegeo:create-rectangle 
	(position X0_Channel Ymin 0) (position X0_GaNBuffer Ymax 0) "GaN" "Channel")

; AlGaN Barrier
; Split layer in 3 so tunneling to/from traps can be limited to region under gate only
; This helps with simulation speed. It might be a better desciption of reality too as traps
; might be formed during gate formation (e.g. Ga vacancy complexes with O)
(sdegeo:create-rectangle 
	(position X0_Barrier Ymin 0) (position X0_Channel Ymax 0) "AlGaN" "Barrier")
(sdedr:define-constant-profile "xmole_AlGaN_barrier_const" "xMoleFraction" xAlGaN_barrier)
(sdedr:define-constant-profile-region "xmole_AlGaN_barrier_const" "xmole_AlGaN_barrier_const" "Barrier")


; ==================================================================================================
; GaN p-gate
(sdegeo:create-rectangle (position X0_pGate ypgl 0) (position X0_Barrier ypgr 0) "GaN" "pGate")

; Place Mg doping
; Constant doping profile in a box-shaped area, with possible Gaussian decay to account 
; for Mg diffusion
(sdedr:define-refinement-window "RW.pg" "Rectangle" 
	(position X0_pGate ypgl 0) (position X0_Barrier ypgr 0))
(sdedr:define-constant-profile "DC.pg" "pMagnesiumActiveConcentration" NMg)
(sdedr:define-constant-profile-placement "CPM.pg" "DC.pg" "RW.pg" sMg "Gauss")

; Background doping
(sdedr:define-refinement-window "RW.Global" "Rectangle" 
	(position X0_pGate Ymin 0) (position X0_Subs Ymax 0))
(sdedr:define-constant-profile "DC.bgn" "NDopantActiveConcentration" Nbg)
(sdedr:define-constant-profile-placement "CPM.bgn" "DC.bgn" "RW.Global")

; ==================================================================================================
; Pattern device

; Passivation
(define x1 (- X0_Barrier tSiN))
(define x2 (- X0_pGate tSiN))
(define y1 (- ypgl tSiN))
(define y2 (+ ypgr tSiN))

; Use SDE boolean operations: "old replaces new" where overlap occurs
(sdegeo:set-default-boolean "BAB")
(sdegeo:create-rectangle (position x1 ysr 0) (position X0_Barrier ydl 0) "Si3N4" "Pass.1")
(sdegeo:create-rectangle (position x2 y1 0) (position X0_Barrier y2 0) "Si3N4" "Passivation")
(sdegeo:bool-unite (find-material-id "Si3N4"))

; Open gate contact window in passivation layer. Round corners for smaller e-fields
(sdegeo:set-default-boolean "ABA")
(sdegeo:create-rectangle (position X0_WGate ygcl 0) (position (+ X0_pGate r) ygcr 0) "XXX" "XXX")
#if @r@ > 0
(sdegeo:fillet-2d (find-vertex-id (position (+ X0_pGate r) ygcl 0)) r)
(sdegeo:fillet-2d (find-vertex-id (position (+ X0_pGate r) ygcr 0)) r)
#endif
(sdegeo:delete-region (find-material-id "XXX"))

; "Deposit and pattern" gate metal
(sdegeo:set-default-boolean "BAB")
(define WGate (sdegeo:create-rectangle 
	(position X0_WGate ymgl 0) (position (+ X0_pGate r 0.001) ymgr 0) "Tungsten" "gt"))

; S/D Contact
; Carve out AlGaN from s/d Ohmic contact regions to simplify S-Device ohmic contact simulation
(sdegeo:set-default-boolean "ABA")
(define TiSource (sdegeo:create-rectangle 
	(position X0_TiSD Ymin 0) (position (+ X0_Channel 0.1) ysr 0) "Titanium" "src"))
(define TiDrain (sdegeo:create-rectangle 
	(position X0_TiSD ydl 0) (position (+ X0_Channel 0.1) Ymax 0) "Titanium" "drn"))

; Contacts
; First make sure separate lumps become separate regions in the boundary
(sde:separate-lumps)
 
; Source contact (all metal layers)
(sdegeo:define-contact-set "source")
(sdegeo:set-current-contact-set "source")
(sdegeo:set-contact-boundary-edges TiSource)
(sdegeo:delete-region TiSource)

; Drain contact (all metal layers)
(sdegeo:define-contact-set "drain")
(sdegeo:set-current-contact-set "drain")
(sdegeo:set-contact-boundary-edges TiDrain)
(sdegeo:delete-region TiDrain)

; Gate contact
(sdegeo:define-contact-set "gate")
(sdegeo:set-current-contact-set "gate")
(sdegeo:set-contact-boundary-edges WGate)
(sdegeo:delete-region WGate)

; Bulk contact
(sdegeo:define-contact-set "bulk")
(sdegeo:set-current-contact-set "bulk")
(sdegeo:define-2d-contact (find-edge-id (position X1_Subs 0 0)) "bulk") 
                                             
; Thermal contact
(sdegeo:define-contact-set "thermal")
(sdegeo:set-current-contact-set "thermal")
(sdegeo:define-2d-contact (find-edge-id (position X1_Subs 0 0)) "thermal") 

; ==================================================================================================
; Mesh for device simulation
(sde:define-parameter "Xmin" X0_WGate)
(sde:define-parameter "Xmax" X1_Subs)

; Meshing
(sdedr:define-refinement-window "RW.Global" "Rectangle" (position Xmin Ymin 0) (position Xmax Ymax 0))
(sdedr:define-refinement-size "RS.Global" 0.5 0.5 0.02 0.02)
(sdedr:define-refinement-function "RS.Global" "DopingConcentration" "MaxTransDiff" 1.0)
(sdedr:define-refinement-function "RS.Global" "PMIUserfield1" "MaxTransDiff" 1.0)
(sdedr:define-refinement-function "RS.Global" "MaxLenInt" "GaN" "AlGaN" 0.001 2.0 "DoubleSide")
(sdedr:define-refinement-function "RS.Global" "MaxLenInt" "GaN" "Si3N4" 0.02 2.0)
(sdedr:define-refinement-function "RS.Global" "MaxLenInt" "AlGaN" "Si3N4" 0.002 2.0)
(sdedr:define-refinement-function "RS.Global" "MaxLenInt" "@SubstrateMaterial@" "AlN" 0.02 2.0)
(sdedr:define-refinement-function "RS.Global" "MaxLenInt" "AlGaN" "AlN" 0.02 2.0)
(sdedr:define-refinement-placement "RP.Global" "RS.Global" "RW.Global")	

; Channel
(sdedr:define-refinement-window "RW.Chan" "Rectangle" 
 	(position X0_pGate (- ypgl 0.4) 0) (position 0.2 (+ ypgr 0.4) 0))
(sdedr:define-refinement-size "RS.Chan" 0.04 (/ (- ypgr ypgl) 8.0) 0.01 0.01)
(sdedr:define-refinement-placement "RP.Chan" "RS.Chan" "RW.Chan")	

; Dense mesh in p-gate depletion for smooth Schottky TAT curves
(sdedr:define-refinement-window "RW.tun" "Rectangle" 
	(position X0_pGate ygcl 0) (position (+ X0_pGate r 0.012) ygcr 0) 
)
(sdedr:define-refinement-size "RS.tun" 0.0004 888 0.0002 888)
(sdedr:define-refinement-placement "RP.tun" "RS.tun" "RW.tun")

; Tunneling at Schottky edges
(sdedr:define-refinement-size "RS.tun.corners" 888 0.001 888 0.0002)

(sdedr:define-refinement-window "RW.tun.l" "Rectangle" 
	(position X0_pGate (- ygcl 0.010) 0) (position (+ X0_pGate r 0.008) (+ ygcl r) 0) 
)
(sdedr:define-refinement-placement "RP.tun.l" "RS.tun.corners" "RW.tun.l")

(sdedr:define-refinement-window "RW.tun.r" "Rectangle" 
	(position X0_pGate (- ygcr r) 0) (position (+ X0_pGate r 0.008) (+ ygcr 0.010)  0) 
)
(sdedr:define-refinement-placement "RP.tun.r" "RS.tun.corners" "RW.tun.r")

; Depletion and p-gate bottom
(sdedr:define-refinement-size  "RS.depletion" 0.002 888 0.0002 888)
(sdedr:define-refinement-region "RP.depletion" "RS.depletion" "pGate.t")

(sdedr:define-refinement-size  "RS.bot" 0.004 888 0.0002 888)
(sdedr:define-refinement-region "RP.bot" "RS.bot" "pGate.b")

; Barrier
(sdedr:define-refinement-size  "RS.barrier" 0.002 888 0.001 888)
(sdedr:define-refinement-region "RP.barrier" "RS.barrier" "Barrier")

; Sufficient vertical lines within channel region where potential might change
(sdedr:define-refinement-window "RW.chcnt" "Rectangle" 
	(position X0_Barrier ypgl 0) (position (+ X0_Channel 0.01) ypgr 0) 
)
(sdedr:define-refinement-size  "RS.chcnt" 999 (/ (- ypgr ypgl) 16.0) 888 0.001)
(sdedr:define-refinement-placement "RP.chcnt" "RS.chcnt" "RW.chcnt")

; Denser mesh where lattice temperature might change significantly
(sdedr:define-refinement-window "RW.hot" "Rectangle" 
	(position X0_Barrier (- ypgr 0.2) 0) (position (+ X0_Channel 0.4) (+ ypgr 0.4) 0) 
)
(sdedr:define-refinement-size "RS.hot" 0.04 0.04 0.001 0.001)
(sdedr:define-refinement-placement "RP.hot" "RS.hot" "RW.hot")

; Build mesh and save tdr with interface regions
(sde:build-mesh "-AI" "n@node@_msh")
