webtalk_init -webtalk_dir C:\\Zynk_Book\\adventures_with_ip\\adventures_with_ip.sdk\\webtalk
webtalk_register_client -client project
webtalk_add_data -client project -key date_generated -value "Mon May 25 20:43:16 2020" -context "software_version_and_target_device"
webtalk_add_data -client project -key product_version -value "SDK v2015.1" -context "software_version_and_target_device"
webtalk_add_data -client project -key build_version -value "2015.1" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_platform -value "amd64" -context "software_version_and_target_device"
webtalk_add_data -client project -key registration_id -value "211820289_0_0_549" -context "software_version_and_target_device"
webtalk_add_data -client project -key tool_flow -value "SDK" -context "software_version_and_target_device"
webtalk_add_data -client project -key beta -value "false" -context "software_version_and_target_device"
webtalk_add_data -client project -key route_design -value "NA" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_family -value "NA" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_device -value "NA" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_package -value "NA" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_speed -value "NA" -context "software_version_and_target_device"
webtalk_add_data -client project -key random_id -value "n5c1c12pptofn6rj3r47u8bei4" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_id -value "2015.1_3" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_iteration -value "3" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_name -value "Microsoft Windows 8 or later , 64-bit" -context "user_environment"
webtalk_add_data -client project -key os_release -value "major release  (build 9200)" -context "user_environment"
webtalk_add_data -client project -key cpu_name -value "Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz" -context "user_environment"
webtalk_add_data -client project -key cpu_speed -value "2808 MHz" -context "user_environment"
webtalk_add_data -client project -key total_processors -value "1" -context "user_environment"
webtalk_add_data -client project -key system_ram -value "17.000 GB" -context "user_environment"
webtalk_register_client -client sdk
webtalk_add_data -client sdk -key uid -value "1590421515382" -context "sdk\\\\bsp/1590421515382"
webtalk_add_data -client sdk -key hwid -value "1590325679601" -context "sdk\\\\bsp/1590421515382"
webtalk_add_data -client sdk -key os -value "standalone" -context "sdk\\\\bsp/1590421515382"
webtalk_add_data -client sdk -key apptemplate -value "empty_application" -context "sdk\\\\bsp/1590421515382"
webtalk_add_data -client sdk -key uid -value "1590421524994" -context "sdk\\\\application/1590421524994"
webtalk_add_data -client sdk -key hwid -value "1590325679601" -context "sdk\\\\application/1590421524994"
webtalk_add_data -client sdk -key bspid -value "1590421515382" -context "sdk\\\\application/1590421524994"
webtalk_add_data -client sdk -key newbsp -value "true" -context "sdk\\\\application/1590421524994"
webtalk_add_data -client sdk -key os -value "standalone" -context "sdk\\\\application/1590421524994"
webtalk_add_data -client sdk -key apptemplate -value "empty_application" -context "sdk\\\\application/1590421524994"
webtalk_transmit -clientid 489369268 -regid "211820289_0_0_549" -xml C:\\Zynk_Book\\adventures_with_ip\\adventures_with_ip.sdk\\webtalk\\usage_statistics_ext_sdk.xml -html C:\\Zynk_Book\\adventures_with_ip\\adventures_with_ip.sdk\\webtalk\\usage_statistics_ext_sdk.html -wdm C:\\Zynk_Book\\adventures_with_ip\\adventures_with_ip.sdk\\webtalk\\sdk_webtalk.wdm -intro "<H3>SDK Usage Report</H3><BR>"
webtalk_terminate
