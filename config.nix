
### DANGER: YOU CAN BREAK YOU SYSTEM WITH THIS FORM ###


# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }: {
  imports = [
    <nix-bitcoin/modules/presets/secure-node.nix>

    # FIXME: The hardened kernel profile improves security but
    # decreases performance by ~50%.
    # Turn it off when not needed.
    <nix-bitcoin/modules/presets/hardened.nix>
    #
    # You can enable the hardened-extended preset instead to further improve security
    # at the cost of functionality and performance.
    # See the comments at the top of `hardened-extended.nix` for further details.
    # <nix-bitcoin/modules/presets/hardened-extended.nix>

    # FIXME: Uncomment the next line to import your hardware configuration. If so,
    # add the hardware configuration file to the same directory as this file.
    #./hardware-configuration.nix
  ];


  # FIXME: Define your hostname.
  networking.hostName = "host";
  time.timeZone = "UTC";

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };
  users.users.root = {
    openssh.authorizedKeys.keys = [
      # FIXME: Replace this with your SSH pubkey
      "ssh-ed25519 AAAAC3..."
    ];
  };

  # FIXME: Uncomment this to allow the operator user to run
  # commands as root with `sudo` or `doas`
  # users.users.operator.extraGroups = [ "wheel" ];

  # FIXME: add packages you need in your system
  environment.systemPackages = with pkgs; [
    vim
  ];

  # FIXME: Add custom options (like boot options, output of
  # nixos-generate-config, etc.):

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  # The nix-bitcoin release version that your config is compatible with.
  # When upgrading to a backwards-incompatible release, nix-bitcoin will display an
  # an error and provide instructions for migrating your config to the new release.
  nix-bitcoin.configVersion = "0.0.85";
}
