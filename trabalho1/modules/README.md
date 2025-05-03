1. Install Quartus
2. Get license on https://licensing.intel.com/psg/s/?language=en_US&q_type=full&q_ver=2025.02&lic_ver=2025.02&dsn=b2eefc06&nic=f20af63d28ad&nic=e00af63d28ae&nic=e20af63d28ad&nic=88a4c290dd51&nic=e00af63d28ad
3. After registration, click "Sign up for Evaluation or No-Cost Licenses" and follow the instructions (check https://www.youtube.com/watch?v=F6FvXga4f1A for guidance).
4. Download the license file sent to your email.
5. Go to system environment variables and add a new variable called `LM_LICENSE_FILE` with the path to the license file.
6. Open Quartus and go to Tools > License Setup. Select the option "Use LM_LICENSE_FILE".

Obs: perhaps you need to change the path to Questa from `c:/intelfpga_standard/24.1std/questa_fe/win64` to `c:/intelfpga/24.1std/questa_fse/win64` as the  trial license only works for starter edition ((https://community.intel.com/t5/Intel-FPGA-Software-Installation/Questa-License-Issue/m-p/1672274/highlight/true#M6506).


