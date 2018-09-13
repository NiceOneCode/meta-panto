#!/bin/sh

echo "Mounting mmcblk0p3 in /mnt... "

mount /dev/mmcblk0p3 /mnt


PATH_DEV_DMG="/dev/dmg"


echo "Creating DMG symlinks... "


mkdir -p $PATH_DEV_DMG
mkdir -p $PATH_DEV_DMG/spi

###############################################################################
# Symlink dispositivo
###############################################################################
  # Create symbolic links to ADC

  ln -s /sys/kernel/dmgACQ/dmgacqmanager/Ch01               $PATH_DEV_DMG/ACQM_Ch01
  ln -s /sys/kernel/dmgACQ/dmgacqmanager/Ch02               $PATH_DEV_DMG/ACQM_Ch02
  ln -s /sys/kernel/dmgACQ/dmgacqmanager/available_Ch01     $PATH_DEV_DMG/ACQM_available_Ch01
  ln -s /sys/kernel/dmgACQ/dmgacqmanager/available_Ch02     $PATH_DEV_DMG/ACQM_available_Ch02
  ln -s /sys/kernel/dmgACQ/dmgacqmanager/configure          $PATH_DEV_DMG/ACQM_configure
  ln -s /sys/kernel/dmgACQ/dmgacqmanager/helpconfig         $PATH_DEV_DMG/ACQM_helpconfig
#  ln -s /sys/kernel/dmgACQ/dmgacqmanager/setSample          $PATH_DEV_DMG/ACQM_setSample
  ln -s /sys/kernel/dmgACQ/dmgacqmanager/state              $PATH_DEV_DMG/ACQM_state
  ln -s /sys/kernel/dmgACQ/dmgacqmanager/verbose            $PATH_DEV_DMG/ACQM_verbose

  ln -s /mnt                                                $PATH_DEV_DMG/log

  ln -s /sys/kernel/dmgSQW/dmgsqwmanager/configure          $PATH_DEV_DMG/SQWM_configure
  ln -s /sys/kernel/dmgSQW/dmgsqwmanager/helpconfig         $PATH_DEV_DMG/SQWM_helpconfig
  ln -s /sys/kernel/dmgSQW/dmgsqwmanager/keepalive          $PATH_DEV_DMG/SQWM_keepalive
  ln -s /sys/kernel/dmgSQW/dmgsqwmanager/state              $PATH_DEV_DMG/SQWM_state
  ln -s /sys/kernel/dmgSQW/dmgsqwmanager/verbose            $PATH_DEV_DMG/SQWM_verbose

  # Serial Devices
  ln -s /dev/spidev2.0                                      $PATH_DEV_DMG/spi/spi3_0
  ln -s /dev/spidev2.1                                      $PATH_DEV_DMG/spi/spi3_1
  ln -s /dev/spidev2.2                                      $PATH_DEV_DMG/spi/spi3_2
  ln -s /dev/spidev2.3                                      $PATH_DEV_DMG/spi/spi3_3
  ln -s /dev/spidev2.4                                      $PATH_DEV_DMG/spi/spi3_4
  ln -s /dev/spidev2.5                                      $PATH_DEV_DMG/spi/spi3_5
  ln -s /dev/spidev2.6                                      $PATH_DEV_DMG/spi/spi3_6
  ln -s /dev/spidev2.7                                      $PATH_DEV_DMG/spi/spi3_7

  ln -s /sys/class/gpio/GPIO_LED_CPU_OK/value               $PATH_DEV_DMG/GPIO_LED_CPU_OK
  ln -s /sys/class/gpio/GPIO_LED_DEBUG1/value               $PATH_DEV_DMG/GPIO_LED_DEBUG1
  ln -s /sys/class/gpio/GPIO_LED_DEBUG2/value               $PATH_DEV_DMG/GPIO_LED_DEBUG2
  ln -s /sys/class/gpio/GPIO_LED_DEBUG3/value               $PATH_DEV_DMG/GPIO_LED_DEBUG3
  ln -s /sys/class/gpio/GPIO_LED_DEBUG4/value               $PATH_DEV_DMG/GPIO_LED_DEBUG4
  ln -s /sys/class/gpio/GPIO_LED_GPS/value                  $PATH_DEV_DMG/GPIO_LED_GPS

  ln -s /sys/class/gpio/FT232_RESET/value                   $PATH_DEV_DMG/FT232_RESET
  ln -s /sys/class/gpio/GPS_RESET/value                     $PATH_DEV_DMG/GPS_RESET
  ln -s /sys/class/gpio/IN_FIBER_IN_5_11/value              $PATH_DEV_DMG/IN_FIBER_IN_5_11
  ln -s /sys/class/gpio/IN_GPS_1PPS/value                   $PATH_DEV_DMG/IN_GPS_1PPS
  ln -s /sys/class/gpio/IN_MAIN_POWER_OFF/value             $PATH_DEV_DMG/IN_MAIN_POWER_OFF
  ln -s /sys/class/gpio/IN_SCAP_OK/value                    $PATH_DEV_DMG/IN_SCAP_OK

  ln -s /dev/ttymxc1                                        $PATH_DEV_DMG/ttyDEV_PORT
  ln -s /dev/ttymxc2                                        $PATH_DEV_DMG/ttyGPS_UART3
  ln -s /dev/ttymxc4                                        $PATH_DEV_DMG/ttyGPS_UART5
