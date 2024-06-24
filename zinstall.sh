#################################################################
# Install via isaacsim binary
#################################################################

###########
#* 001
###########
# manually install isaac-sim-4.0.0 via server GUI by ref official doc
# need to have nucleus installed and setup localhost serer
# cache is optional based on

###########
#* 002
###########
cd work && gcl git@github.com:zhuoqun-chen/IssacLab.git
cd IsaacLab
ln -s ~/.local/share/ov/pkg/isaac-sim-4.0.0 _isaac_sim

###########
#* 003
###########
cd ./_isaac_sim
# modify environment.yml for my own conda env with pytorch-cuda=11.8 (11.7 no work for my 4070Ti)
# conda env update -f environment.yml little by little (since directly resolve won't work)
#   undate with only pytorch
#   add cuda-toolkit #!z failed to install 11.7 or 11.8, don't know why
#   add the rest pip and conda packages
# until all packages are installed, then:

###########
#* 004
###########
cd ..
# this will add python path and ld_library_path to the isaaclab env
./install.sh --conda #!z buggy, modified conda env start script manually in the end

###########
#* 005
###########
# verify isaac sim & lab installed wo/ problem
conda activate isaaclab

# verify sim by opening sim-GUI directly
${ISAAC_PATH}/isaac-sim.sh # ie, ~/.local/share/ov/pkg/isaac-sim-4.0.0, or ~/work/IsaacLab/_isaac_sim
# verify sim can be started from a script
cd ~/work/IsaacLab
python ${ISAAC_PATH}/standalone_examples/api/omni.isaac.core/add_cubes.py
# verify lab
python source/standalone/tutorials/00_sim/create_empty.py

###########
#* 006
# https://isaac-sim.github.io/IsaacLab/source/setup/sample.html
# https://isaac-sim.github.io/IsaacLab/source/features/environments.html
###########
# test and play many scripts with built-in envs
cd ~/work/IsaacLab

#*z once conda env isaaclab activated, all ./isaaclab.sh -p <-> python
# Spawn different quadrupeds and make robots stand using position commands:
python source/standalone/demos/quadrupeds.py

# Spawn different arms and apply random joint position commands:
python source/standalone/demos/arms.py

# Spawn different hands and command them to open and close:
python source/standalone/demos/hands.py

# Spawn procedurally generated terrains with different configurations:
python source/standalone/demos/procedural_terrain.py

# Spawn multiple markers that are useful for visualizations:
python source/standalone/demos/markers.py

# list all supported rl envs
python source/standalone/environments/list_envs.py

# try launch zero-action agent
python source/standalone/environments/zero_agent.py --task Isaac-Cartpole-v0 --num_envs 32
# try launch random-action agent
python source/standalone/environments/random_agent.py --task Isaac-Cartpole-v0 --num_envs 32

# teleoperation
python source/standalone/environments/teleoperation/teleop_se3_agent.py \
    --task Isaac-Lift-Cube-Franka-IK-Rel-v0 \
    --num_envs 1 \
    --device keyboard

# Track a velocity command on flat terrain with the Anymal D robot
# Isaac-Velocity-Rough-Anymal-C-v0

# Navigate towards a target x-y position and heading with the ANYmal C robot.
# Isaac-Navigation-Flat-Anymal-C-v0

###########
#* 007
# https://isaac-sim.github.io/IsaacLab/source/features/actuators.html
###########
# learn about actuators
