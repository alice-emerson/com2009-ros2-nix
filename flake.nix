{
  inputs = {
    nix-ros-overlay.url = "github:lopsided98/nix-ros-overlay/master";
    nixpkgs.follows = "nix-ros-overlay/nixpkgs";  # IMPORTANT!!!
  };
  outputs = { self, nix-ros-overlay, nixpkgs }:
    nix-ros-overlay.inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ nix-ros-overlay.overlays.default ];

          # Dependency of Gazebo, not much I can do about it
          config.permittedInsecurePackages = [ "freeimage-3.18.0-unstable-2024-04-18" ];
        };
      in {
        devShells.default = pkgs.mkShell {
          name = "com2009-env";
          
          TURTLEBOT3_MODEL = "waffle";

          # Hide any system/user plugins to prevent version mismatch errors
          QT_PLUGIN_PATH = "";

          packages = [
            pkgs.colcon
            (with pkgs.rosPackages.jazzy; buildEnv {
              paths = [
                # Base packages
                ros-core
                ament-cmake-core
                python-cmake-module

                # Gazebo simulator
                ros-gz
                gz-launch-vendor

                # Turtlebot
                turtlebot3-gazebo
                turtlebot3-teleop
              ];
            })
          ];
        };
}
