# Automated pyramidal horn antenna design.

## Description
This is a script that automates the design of a pyramidal horn antenna.  
Inputs can be derived from [Waveguide2Coax script](https://github.com/dnemec/waveguide_to_coax).  
*ea* is by default 0.511.  
  
## Sources
All calculations are derived from:  
**Teshirogi, T., & Yoneyama, T. (2001). Modern millimeter-wave technologies. Ios Press
Banjeglav, G., & Malarić, K. (2015). 2.4 GHz horn antenna. Transactions on maritime science, 4(01), 35-40.**  
  
## Inputs  
  
### Inputs   
![Input](https://raw.githubusercontent.com/dnemec/pyramidal_horn_antenna_design/main/Images/Inputs.PNG?raw=true)
  
* **Waveguide width** - Width of a waveguide. *(The longer side)*     

* **Waveguide height** - Height of a waveguide. *(The shorter side)*     

* **Waveguide length** - Length of a waveguide, usually a half of the guided wavelength.   

* **Feed width** - Diameter of a feed monopole conductor, usually in a milimeter range.  

* **Feed offset** - Axial offset of a feed monopole.
*Use the [**Waveguide2Coax script**](https://github.com/dnemec/waveguide_to_coax) to optimize this parameter.  

* **Central frequency** - selfexplainable  
  
## Outputs

### Textual output of calculated parameters and resulting performance  
![Output](https://raw.githubusercontent.com/dnemec/pyramidal_horn_antenna_design/main/Images/Output.PNG?raw=true)
  
### VSWR
![VSWR](https://raw.githubusercontent.com/dnemec/pyramidal_horn_antenna_design/main/Images/VSWR.png?raw=true)
  
### Return loss
![RL](https://raw.githubusercontent.com/dnemec/pyramidal_horn_antenna_design/main/Images/Returnloss.png?raw=true)
  
### Antenna visualization and radiation pattern
![WG](https://raw.githubusercontent.com/dnemec/pyramidal_horn_antenna_design/main/Images/Pattern.png?raw=true)
