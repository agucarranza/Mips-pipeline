webtalk_init -webtalk_dir /home/agustin/arqui/mips/mips.sim/sim_1/behav/xsim/xsim.dir/tb_mips_behav/webtalk/
webtalk_register_client -client project
webtalk_add_data -client project -key date_generated -value "Sat Jan 23 03:26:24 2021" -context "software_version_and_target_device"
webtalk_add_data -client project -key product_version -value "XSIM v2020.1 (64-bit)" -context "software_version_and_target_device"
webtalk_add_data -client project -key build_version -value "2902540" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_platform -value "LIN64" -context "software_version_and_target_device"
webtalk_add_data -client project -key registration_id -value "" -context "software_version_and_target_device"
webtalk_add_data -client project -key tool_flow -value "xsim_vivado" -context "software_version_and_target_device"
webtalk_add_data -client project -key beta -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key route_design -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_family -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_device -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_package -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_speed -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key random_id -value "9243c741-ef40-4c50-a834-8ebb59f86c36" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_id -value "5f3eda23ff96417dbea6ece9593cd67a" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_iteration -value "137" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_name -value "ManjaroLinux" -context "user_environment"
webtalk_add_data -client project -key os_release -value "Manjaro Linux" -context "user_environment"
webtalk_add_data -client project -key cpu_name -value "Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz" -context "user_environment"
webtalk_add_data -client project -key cpu_speed -value "887.223 MHz" -context "user_environment"
webtalk_add_data -client project -key total_processors -value "1" -context "user_environment"
webtalk_add_data -client project -key system_ram -value "25.000 GB" -context "user_environment"
webtalk_register_client -client xsim
webtalk_add_data -client xsim -key Command -value "xsim" -context "xsim\\command_line_options"
webtalk_add_data -client xsim -key trace_waveform -value "true" -context "xsim\\usage"
webtalk_add_data -client xsim -key runtime -value "260 ns" -context "xsim\\usage"
webtalk_add_data -client xsim -key iteration -value "2" -context "xsim\\usage"
webtalk_add_data -client xsim -key Simulation_Time -value "0.03_sec" -context "xsim\\usage"
webtalk_add_data -client xsim -key Simulation_Memory -value "119532_KB" -context "xsim\\usage"
webtalk_transmit -clientid 2635676188 -regid "" -xml /home/agustin/arqui/mips/mips.sim/sim_1/behav/xsim/xsim.dir/tb_mips_behav/webtalk/usage_statistics_ext_xsim.xml -html /home/agustin/arqui/mips/mips.sim/sim_1/behav/xsim/xsim.dir/tb_mips_behav/webtalk/usage_statistics_ext_xsim.html -wdm /home/agustin/arqui/mips/mips.sim/sim_1/behav/xsim/xsim.dir/tb_mips_behav/webtalk/usage_statistics_ext_xsim.wdm -intro "<H3>XSIM Usage Report</H3><BR>"
webtalk_terminate
