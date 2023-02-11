---
layout: post
comments: true
title: "Install TensorFlow 2.5 and NVIDIA GPU drivers on Ubuntu 20.04 only for processing (no graphics)"
categories: Linux NVIDIA GPU TF
date: 23-07-2021 11:00:00
author:
- Andres Becker
meta: "Ubuntu 20.04"
---

<!-- Set images path as variable -->
{% assign post_resources = '/img/post/2021-07-23-Install-NVIDIA-GPU-drivers-on-Ubuntu-20-04-only-for-processing/' %}

![Screen shot]({{ post_resources | append: 'screen.png' | relative_url }})
{: style="width: 100%;" class="center"}

>In this post, we gonna see how to install the NVIDIA proprietary drivers in a machine with Ubuntu, disable the graphics support (so the GPU will be used only for processing) and test the implementation by looking at the GPU availability in TensorFlow. For the last part, we assume that you already have conda installed on your computer.

This notes where done with the following **system setting**:
- Lenovo ThinkPad T470p
- NVIDIA GeForce 940MX
- Ubuntu 20.04
- Window System / Display Server Protocol: X11

## 0.- Remove previous installations
```console
sudo apt purge nvidia* cuda* libcudnn8* libnvinfer-plugin-dev
sudo apt autoremove
reboot
```

## 1.- Check for the latest driver
```console
sudo apt update
nvidia-detector
```

![nvidia-detector output]({{ post_resources | append: 'nvidia-detector.png' | relative_url }})
{: style="width: 100%;" class="center"}

Even though that the latest version of the NVIDIA driver is 470, we will install the latest **server** version (which usually is some releases behind). This is because the server version comes with the needed scripts (for the system service manager, i.e. `systemctl`) to control the behavior of the GPU during machine suspension/hibernation and resume (which is very useful if you have Laptop like in my case). Whiteout this services, the GPU will be unavailable (at least for TensorFlow) every time the machine resumes from a suspension/hibernation.

>**Warning**: This solution has the disadvantage that the machine will fail to suspend/hibernate when the GPU is used/captured by a process.

```console
apt-cache search . | grep "nvidia-driver-.*-server"
```

![nvidia-server available drivers]({{ post_resources | append: 'nvidia-server.png' | relative_url }})
{: style="width: 100%;" class="center"}

Therefore, we install the latest NVIDIA server drivers

```console
sudo apt install nvidia-driver-460-server
```

Now we install the **suspend**, **hibernate** and **resume** services, so the GPU is available after the machine resumes from suspension/hibernation

```console
sudo echo "options nvidia NVreg_PreserveVideoMemoryAllocations=1" >> /etc/modprobe.d/nvidia.conf
sudo install /usr/share/doc/nvidia-driver-460-server/nvidia-suspend.service /etc/systemd/system/
sudo install /usr/share/doc/nvidia-driver-460-server/nvidia-hibernate.service /etc/systemd/system/
sudo install /usr/share/doc/nvidia-driver-460-server/nvidia-resume.service /etc/systemd/system/
sudo install /usr/share/doc/nvidia-driver-460-server/nvidia /lib/systemd/system-sleep/
sudo install /usr/share/doc/nvidia-driver-460-server/nvidia-sleep.sh /usr/bin/
```

Enable the services

```console
sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service
```

Reboot the machine to observe the changes

```console
reboot
```

After installing the drivers, we can check that everything was installed correctly by executing the command `nvidia-smi`

```console
nvidia-smi
```

![nvidia-smi with X11]({{ post_resources | append: 'smi_w_x11.png' | relative_url }})
{: style="width: 100%;" class="center"}

However, we can see that there are two processes already executing in the GPU, which correspond to the X11 server (system graphics).

Therefore, if you want to use the GPU only for processing (for example training Neural Networks), we need to prevent the system to use the GPU for graphics (display) processing. For this we have to do two thinks

1. Disable the X11 configuration for the graphic card.
2. Disable NVIDIA kernel modules for graphics.

In practice, it is enough just to disable the X11 setting for the graphics card

```console
sudo mv /usr/share/X11/xorg.conf.d/10-nvidia.conf /usr/share/X11/xorg.conf.d/10-nvidia.conf_back
```

However, if we do this, it makes no sense to load the NVIDIA kernel modules responsible for graphics processing (**nvidia_drm** and **nvidia_modeset**)

![nvidia kernel modules]({{ post_resources | append: 'nvidia-kernel-modules.png' | relative_url }})
{: style="width: 100%;" class="center"}

Therefore, we disable these modules by preventing the OS to load them during booting (by blacklisting them)

```console
sudo echo "blacklist nvidia_drm" >> /etc/modprobe.d/nvidia.conf
sudo echo "blacklist nvidia_modeset" >> /etc/modprobe.d/nvidia.conf
sudo echo "install nvidia_drm /bin/false" >> /etc/modprobe.d/nvidia.conf
sudo echo "install nvidia_modeset /bin/false" >> /etc/modprobe.d/nvidia.conf
```

Reboot the machine to observe the changes

```console
reboot
```

We can execute the command `nvidia-smi` and `lsmod` to check that X11 is not longer running on the GPU and that the NVIDIA kernel modules are not loaded

![nvidia smi no graphics]({{ post_resources | append: 'smi-no-graphics.png' | relative_url }})
{: style="width: 100%;" class="center"}

## 2.- Install CUDA toolkit

The next part is to install the **CUDA** toolkit and libraries, so we can use the GPU to train Neural Nets.

First, we need to set the NVIDIA repo

```console
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
```

Install CUDA and reboot.  After the computer starts check that GPUs are visible using the command `nvidia-smi`

```console
sudo apt-get update
sudo apt-get -y install --no-install-recommends cuda libcudnn8 libcudnn8-dev
reboot
```

Install TensorRT, which requires that libcudnn8 is installed (above)

```console
apt install --no-install-recommends libnvinfer8 libnvinfer-dev libnvinfer-plugin8 libnvinfer-plugin-dev
```

Finally, add binaries and libraries paths to your **.bashrc** file, so they CUDA bins and libs can be found by TensorFlow

```console
echo "export PATH=\$PATH:/usr/local/cuda/bin" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/targets/x86_64-linux/lib" >> ~/.bashrc
```

To make the changes visible in your current session, close your session and reopen it or reboot your system.

## 3.- Install TensorFlow 2.5

To test if the GPU is visible and available for TensorFlow, we install it using Anaconda and PIP

>**Note**: I don't know why this happen, but it is always better to install TensorFlow using PIP. It has happen to me that TF does not behave as it should when I install it using Anaconda.

Create Anaconda environment with *python* 3.9

```console
conda create -n test_env python=3.9
conda activate test_env
```

Install TensorFlow 2.5

```console
pip install --upgrade pip
pip install tensorflow==2.5
# Optional: install other stuff
pip install numpy pandas matplotlib seaborn
pip install jupyterlab
```

To check if everything works fine, open python

```console
conda activate test_env
python
```

and check that the GPU is available in TensorFlow

```python
import tensorflow as tf
# List available devises (CPUs and GPUs)
physical_devices = tf.config.list_physical_devices('GPU')
print('Physical Devices: {}'.format(physical_devices))
```

![GPU on TF]({{ post_resources | append: 'GPU_TF.png' | relative_url }})
{: style="width: 100%;" class="center"}

If you have an output similar to the one above (which indicate the available GPUs), then it means that your GPU is ready to train models. Congrats!

## References
- https://www.tensorflow.org/install/gpu
- https://github.com/tensorflow/tensorflow/issues/5777
- https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=20.04&target_type=deb_network

---

*If you notice any mistakes or errors in this post, please don't hesitate to contact me at [{{ site.author.email }}](mailto:{{ site.author.email }}) and I will be more than happy to correct them right away!*
