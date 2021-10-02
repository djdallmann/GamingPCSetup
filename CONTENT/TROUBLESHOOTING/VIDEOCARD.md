# Troubleshooting: Video Card

This section covers different tools which can help in identifying issues concerning video card performance such as active power states, core and memory clocks, throttling reasons, gpu temps and fan speeds.

## NVIDIA System Management Interface (nvidia-smi)
All Nvidia driver installations come with a built-in tool called NVIDIA System Management Interface (nvidia-smi), it allows you get realtime information about your graphics card which include:
   * Clock speeds e.g. base, boosted, memory, core
   * Power consumption
   * GPU and memory usage
   * Temperatures and fan speeds
   * **Throttling reasons (extremely useful)**
   * Active power states (P-State)
   * PCI link speed and generation (changes during P-State changes)
   * ECC memory statistics e.g. error correction statistics, if the GPU supports it
   * Processes using the GPU and their process id (PID)

There are many different use cases so we'll just cover a few useful commands and scenarios, for a complete list use ```nvidia-smi --help```

Operating system path for nvidia-smi tool may change during each driver installation and can be found in the Windows DriverStore file repository:
   * ```C:\Windows\System32\DriverStore\FileRepository\nv_dispi.inf_amd64_1c83a5d7cffd7bff\nvidia-smi.exe```

### Commands

* ```nvidia-smi --help```
   *  Provides a list of options and their syntax
* ```nvidia-smi --list-gpus```
   * Lists the available GPUs and their unique identifiers (GPUID)
* ```nvidia-smi``` (No parameters)
   * A very **basic summary** of the gpu state e.g. power, temps, fan speed, applications using gpu, driver version, memory and gpu usage
* ```nvidia-smi -i <GPUID> -q```
   * e.g. ```nvidia-smi.exe -i 1 -q```
   * A **detailed summary** of the gpu state e.g. clock speeds and limits, power, temps, fan speed, applications using gpu, driver version, memory and gpu usage
* ```nvidia-smi -i <GPUID> --query-supported-clocks=mem,gr --format=csv```
   * List all supported clocks for memory and graphics in csv format.
* ```nvidia-smi --help-query-gpu```
   * List all gpu attributes you can query e.g. mem clock, gpu clock, power, p-state
   * Useful for one time queries or when logging details to a file (see below)
* ```nvidia-smi --query-gpu=timestamp,utilization.gpu,utilization.memory,temperature.gpu,fan.speed,pstate,pcie.link.gen.current,pcie.link.width.current,clocks.gr,clocks.max.gr,clocks.sm,clocks.max.sm,clocks.mem,clocks.max.mem,clocks.video,encoder.stats.averageFps,encoder.stats.averageLatency,clocks_throttle_reasons.supported,clocks_throttle_reasons.active --format=csv -l --loop-ms=100 -f C:\Users\yourusername\Desktop\nvsmi.log```
   * Monitor each of the gpu attribute states in a loop, logging the values to a file in CSV format every 100ms (milliseconds).
   * Power states (pstate): 
      * If you're not using high performance plan (such as adaptive or optimal) the pstate will change dynamically as demand increases causing memory and core speeds to fluctuate significantly (latency as a result). The base memory and core frequencies will vary by map or what is being rendered on screen (changes in view), otherwise it should stay at P0 with high performance power setting unless throttled. (see below)
      * https://docs.nvidia.com/gameworks/content/gameworkslibrary/coresdk/nvapi/group__gpupstate.html
         * P0/P1 - Maximum 3D performance
         * P2/P3 - Balanced 3D performance-power
         * P8 - Basic HD video playback
         * P10 - DVD playback
         * P12 - Minimum idle power consumption
   * Throttle reasons which may be due to excessive power draw (Power Scaling), application clock limit, or thermals too high.
      * For related bitmasks (nvml.h):
        * https://docs.nvidia.com/deploy/nvml-api/group__nvmlClocksThrottleReasons.html#group__nvmlClocksThrottleReasons
      * There are specific gpu attributes for each, see ```--help-query-gpu``` for more information
         * clocks_throttle_reasons.sw_power_cap
         * clocks_throttle_reasons.hw_slowdown
         * clocks_throttle_reasons.hw_thermal_slowdown
         * clocks_throttle_reasons.hw_power_brake_slowdown
         * clocks_throttle_reasons.sw_thermal_slowdown
         * clocks_throttle_reasons.sync_boost
