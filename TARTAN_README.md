# Usage

## 1. Set Up the Repository

First, create a `src` directory at the root of this repository and clone the required repositories into it:

```bash
cd <your_path>/autoware_tartan_carpet
mkdir -p src
vcs import src < autoware.repos
vcs import src < autoware-tartan.repos
```

After running the commands above, your `src` directory should look something like this:

```bash
├── ...
├── src # Directory containing multiple repositories
│   ├── core
│   ├── launcher
│   ├── param
│   ├── sensor_component
│   ├── sensor_kit
│   ├── universe
│   └── vehicle
├── ...
```

## 2. Run the Autoware Docker Container in Development Mode

Use the following command to start the Autoware Docker container in development mode:

```bash
./docker/tartan_run.sh --devel --map-path ~/autoware_map
```

**Note**: The `tartan_run.sh` script expects the Autoware artifacts to be in the `~/autoware_data` directory. If they are missing, the script will halt.

Follow this [guide](./ansible/roles/artifacts/README.md) to download the required artifacts.

## 3. Update ROS Dependencies in the Container

Once inside the Docker container, update the necessary ROS packages:

```bash
cd /workspace # Autoware's Docker places you in the /autoware directory
sudo apt update && rosdep update
rosdep install -y --from-paths src --ignore-src --rosdistro $ROS_DISTRO
```

## 4. Build the Workspace

Build the workspace with the following command:

```bash
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release --continue-on-error
source /workspace/install/setup.bash
```

The `--continue-on-error` flag ensures that as many ROS packages as possible are built, even if some fail.

## 5. (Optional) Open Another Interactive Bash Terminal

If needed, you can open another interactive `bash` terminal while inside the Docker container.

```bash
./docker/get_autoware_shell.sh
```

Since the Autoware Docker image is quite large, working with multiple terminals can be more convenient rather than instantiating a new Docker container from the same Docker image.

The scritp make uses of `docker exec` [CLI](https://docs.docker.com/reference/cli/docker/container/exec/).

---

## Useful Commands

### Build a Specific ROS Package

To build a specific ROS package, use:

```bash
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release --packages-select <my_package>
```

**Example:**

```bash
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release --packages-select autoware_launch
```
