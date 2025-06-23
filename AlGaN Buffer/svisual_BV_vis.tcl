# Load data
set N @node@
load_file BV_n@previous@_des.plt -name PLT($N)

set bv_label "Lgd12-FP0"

if {[lsearch [list_plots] Plot_IdVd] == -1} {
	create_plot -1d -name Plot_IdVd
}

# Create and display Ids vs. Vds curve

create_curve -name Ids($N) -dataset PLT($N) -axisX  "drain InnerVoltage" -axisY "drain TotalCurrent"

set Vd [get_variable_data "drain InnerVoltage" -dataset PLT($N)]
set Id [get_variable_data "drain TotalCurrent" -dataset PLT($N)]


# Format curve and axes

set_curve_prop Ids($N) -label $bv_label \
  -line_style solid -line_width 3 -show_markers -markers_size 9

set_axis_prop -axis x  -title {Vds (V)} -title_font_size 14 -scale_font_size 14 -type linear 
set_axis_prop -axis y  -title {Ids (A/mm)} -title_font_size 14 -scale_font_size 14 -type log

## Breakdown voltage == Vd at Ioff= 1e-3
ext::ExtractBVi -out BVi -name BVi -v $Vd -i $Id -io 1e-3 -f %.2f
echo "BVi is [format %.2f $BVi] V"
