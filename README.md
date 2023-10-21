# Automated pyramidal horn antenna design.

## Description
This script automates the design of a pyramidal horn antenna.  
  
The design is prooven in the "An Automated Approach to Horn Antenna Impedance Matching and Manufacturing Using 3D Printing" article published in the Journal of Communications Software and Systems (JCOMSS).  
https://jcoms.fesb.unist.hr/10.24138/jcomss-2023-0100/ (DOI: 10.24138/jcomss-2023-0100)  
  
Manufacturing is supported by the parametric Autodesk Fusion360 3D models published on Thingiverse.  
https://www.thingiverse.com/thing:6272865  
https://www.thingiverse.com/thing:6272859

Waveguide operates in the TE<sub>10</sub> mode.  
*ea* is by default $0.511$.  
Flare length is approximated with $\lambda \over 3$
  
## Sources
Calculations are mostly derived from: 

**Teshirogi, T., & Yoneyama, T. (2001). Modern millimeter-wave technologies. Ios Press  
Pozar, D. M. (2011). Microwave engineering. John Wiley & Sons.  
Balanis, C.A. (2015). Antenna theory: analysis and design. John Wiley &
Sons.  
Banjeglav, G., & Malarić, K. (2015). 2.4 GHz horn antenna. Transactions on maritime science, 4(01), 35-40.**  

Optimization technique is inspired by:

**Wade, P. (2006). Rectangular Waveguide to Coax Transition Design. W1GHZ.    
Kumar, H. and Kumar, G., “Coaxial feed pyramidal horn antenna with
high efficiency,” IETE Journal of Research, vol. 64, no. 1, pp. 51–58,
2018.**  
  
## Inputs  
  
### Inputs   
  
* **Number of combinations** - feed length and feed offset combinations  
*Around 100 is more than enough, approximate it accordingly in regards to the manufacturing precision that you are able to achieve.*  

* **Feedwidth** - diameter of a pinfeed monopole antenna conductor (probe)  
*Usually in a milimeter range.*  
*Larger diameter (thicker probe) usually results in a wider bandwidth.*

* **Central frequency** - Central frequency for which the adapter will be designed and optimized

* **Gain** - Desired gain of the antenna.  
  
## Outputs

### Textual output of calculated parameters and resulting performance  
![Output](https://github.com/dnemec/pyramidal_horn_antenna_design/blob/main/Images/outputs.PNG?raw=true)
  
### Return loss  
![RL](https://github.com/dnemec/pyramidal_horn_antenna_design/blob/main/Images/returnloss.png?raw=true)
  
### Antenna visualization and radiation pattern  
![WG](https://github.com/dnemec/pyramidal_horn_antenna_design/blob/main/Images/pattern.png?raw=true)
