# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ##MARK MAC   
      ./apple-silicon-support
   ];
  #MARK MAC
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;
  services.udev.extraRules = ''
    KERNEL=="macsmc-battery", SUBSYSTEM=="power_supply", ATTR{charge_control_end_threshold}="80", ATTR{charge_control_start_threshold}="70"
  '';
  boot.kernelParams = [ "apple_dcp.show_notch=1" ];

  hardware.bluetooth.enable = true;
  networking.wireless.iwd = {
  	enable = true;
	settings.General.EnableNetworkConfiguration = true;
  };
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "markbook"; # Define your hostname.
  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  # Set your time zone.
  time.timeZone = "Asia/Manila";

   # Enable sound.
   security.rtkit.enable = true;
   services.pipewire = {
     enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;
     jack.enable = true;
     pulse.enable = true;
     wireplumber.enable = true;
   };

   # Trackpad
   services.libinput.enable = true;
   services.libinput.touchpad.disableWhileTyping = true;
   environment.etc."libinput/local-overrides.quirks".text = ''
     [Internal Keyboard]
     MatchName=Apple MTP keyboard
     MatchUdevType=keyboard
     AttrKeyboardIntegration=internal
   '';
}
