## Power Profiles to AMD P-STATE Energy Performance Preference

There is a gap in modern Desktop Linux distros, from kernel 6.5+ as this kernel version is enabling AMD-PSTATE in active mode as default CPU driver on ZEN2+ machines, this is crucial especialy on notebooks when running as long as possible on battery is desirable.

Unfortunately Power Profiles Daemon cannot talk to AMD-PSTATE driver directly leaving it unmanaged and inconsistent with whole system energy profile.

This project is aiming to close this gap with monitoring Power Profiles current mode in the background and setting corresponding EPP profile for CPU.

So far there are four modes of operation:

* PP set to 'power-saver' -> EPP set to 'power' (lowest energy usage preference)
* PP set to 'balanced':
    * if AC is disconnected -> EPP set to 'balance_power'
    * if AC is connected -> EPP set to 'balance_performance'
* PP set to 'performance' -> EPP set to 'performance'

There is no configuration required.

Tested on Fedora 39 Silverblue with 6.5.6 kernel on ASUS Zephyrus g14 2021 AMD Ryzen 9 5900HS

dependencies:
* python3
* power-profiles-daemon (installed by default on Fedora 35+)

## NixOS Flake Setup

flake.nix:
```nix
{
  inputs.pp-to-amd-epp.url = github:marcinx64/pp-to-amd-epp;
  # needed so there's no power-profiles-daemon version mismatch
  inputs.pp-to-amd-epp.inputs.nixpkgs.follows = "nixpkgs";
  outputs = {self, nixpkgs, ...}@inputs: {
    # yourhostname being your actual system's hostname
    nixosConfigurations.yourhostname = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
     
      specialArgs = { inherit inputs system; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
```
configuration.nix:
```nix
{
  imports = [
    inputs.pp-to-amd-epp.nixosModules.pp-to-amd-epp
  ];

  services.pp-to-amd-epp.enable = true;
}
```


    
