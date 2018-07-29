#Thinkpad-T460s-CLOVER
include DSDT patches, kexts







#Thinkpad T460s配置

* i5-6200U
* intel HD520 graphics & GTX 930M
* No-touch 1920x1080
* Replace my old Wi-Fi/BT with DW1560
* 256 SSD
* 8 GB 2133 MHz DDR4



# 工作正常部分
* Wi-Fi/BT 更换为 Dell DW1560（BCM94352Z）wifi/bt 通过rehabman提供的BrcmPatchRAM2.kext/BrcmFirmwareRepo.kext 驱动成功。
* 有线网卡通过使用IntelMausiEthernext.kext 驱动成功
* 声卡通过VoodooHDA.kext 驱动成功
* 键盘-小红点-触摸板-Thinkpad特有的中部按键VoodooPS2Controller.kext驱动成功
* 通过USBInjectAll.kext 驱动成功，摄像头和facetime能识别运行。
* 亮度可调，睡眠正常。
* 核心显卡正常驱动。
* Airdrop/Handoff 正常使用。
* HDMI视频输出正常。




# 无解部分
* 长时间睡眠后唤醒假死
* 开机需要手动选择声音输出设备，开机默认耳机输出。
* 开机亮度似乎都为最亮（100%）
* 看YouTube视频/B站视频时风扇容易飙高（不知是不是独立显卡原因，当然独显是不能驱动的）正常网页浏览风扇静音。
* 读卡器无法工作。
* 指纹无法工作。


#注意部分
* mac os 10.13.* 系统需要在drivers64UEFI文件夹下面多加上apfs.efi
* Fack ID/ intelGFX=0x1234567
* 关于clover设置详细自己需要到远景论坛爬贴，这样出现问题心中才有数，黑苹果安装一定有做好备份工作，具体Windows备份自己Google。
